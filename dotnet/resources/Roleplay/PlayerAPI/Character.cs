using GTANetworkAPI;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace Roleplay.PlayerAPI
{
    class Character : Script
    {
        private static readonly string[] headOverlayNames = { "blemishes", "facialHair", "eyebrows", "ageing", "makeup", "blush", "complexion", "sunDamage", "lipstick", "molesFreckles", "chestHair", "bodyBlemishes", "addBodyBlemishes" };
        private static readonly string[] faceFeatureNames = {
            "f_noseWidth", "f_noseHeight", "f_noseLength", "f_noseBridge", "f_noseTip",
            "f_noseShift", "f_browHeight", "f_browWidth", "f_cheekboneHeight", "f_cheekboneWidth",
            "f_cheeksWidth", "f_eyes", "f_lips", "f_jawWidth", "f_jawHeight",
            "f_chinLength", "f_chinPosition", "f_chinWidth", "f_chinShape", "f_neckWidth"
        };

        private static HeadOverlay CreateHeadOverlay(byte index, byte color, byte secondaryColor, float opacity)
        {
            return new HeadOverlay
            {
                Index = index,
                Color = color,
                SecondaryColor = secondaryColor,
                Opacity = opacity
            };
        }

        #region Character Select
        [RemoteEvent("login.character.select")]
        public static void SelectCharacter(Player c, int id)
        {
            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();
            MySqlCommand cmd = new MySqlCommand("SELECT * FROM characters_customization WHERE character_id = @character_id", conn);
            cmd.Parameters.AddWithValue("@character_id", id);
            MySqlDataReader r = cmd.ExecuteReader();
            if (r.Read())
            {
                HeadBlend headBlend = new HeadBlend
                {
                    ShapeFirst = r.GetByte("h_ShapeFirst"),
                    ShapeSecond = r.GetByte("h_ShapeSecond"),
                    ShapeThird = r.GetByte("h_ShapeThird"),
                    SkinFirst = r.GetByte("h_SkinFirst"),
                    SkinSecond = r.GetByte("h_SkinSecond"),
                    SkinThird = r.GetByte("h_SkinThird"),
                    ShapeMix = r.GetFloat("h_ShapeMix"),
                    SkinMix = r.GetFloat("h_SkinMix"),
                    ThirdMix = r.GetFloat("h_ThirdMix")
                };

                float[] faceFeatures = new float[faceFeatureNames.Length];
                for (int i = 0; i < faceFeatureNames.Length; i++)
                    faceFeatures[i] = r.GetFloat(faceFeatureNames[i]);

                Dictionary<int, HeadOverlay> headOverlays = new Dictionary<int, HeadOverlay>();

                for (int i = 0; i < headOverlayNames.Length; i++)
                {
                    string s = headOverlayNames[i];
                    headOverlays.Add(i, CreateHeadOverlay(r.GetByte("o_i_" + s), r.GetByte("o_c_" + s), r.GetByte("o_c2_" + s), r.GetFloat("o_o_" + s)));
                }

                c.SetData("isMale", r.GetBoolean("sex"));

                c.SetCustomization(r.GetBoolean("sex"), headBlend,
                r.GetByte("eyeColor"), r.GetByte("hairColor"), r.GetByte("hightlightColor"),
                faceFeatures, headOverlays, new Decoration[] { });

                r.Close();

                cmd = new MySqlCommand("SELECT * FROM characters_clothes WHERE character_id = @character_id", conn);
                cmd.Parameters.AddWithValue("@character_id", id);
                r = cmd.ExecuteReader();
                if (r.Read())
                {
                    c.SetData("shoes", r.GetInt32("shoes"));
                    c.SetData("legs", r.GetInt32("legs"));
                    c.SetData("tops", r.GetInt32("tops"));
                    c.SetData("torsos", r.GetInt32("torsos"));
                    c.SetData("undershirts", r.GetInt32("undershirts"));
                    c.SetData("hair", r.GetInt32("hair"));
                }
                r.Close();

                cmd = new MySqlCommand("SELECT * FROM characters WHERE id = @id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                r = cmd.ExecuteReader();
                if (r.Read())
                {
                    c.SetData("adminlvl", r.GetInt32("admin"));
                    c.SetData("dim", r.GetUInt32("dim"));
                    c.Name = r.GetString("first_name") + r.GetString("last_name");
                    c.Position = new Vector3(r.GetFloat("last_pos_x"), r.GetFloat("last_pos_y"), r.GetFloat("last_pos_z"));
                    c.Dimension = r.GetUInt32("dim");
                }
                r.Close();

                DatabaseAPI.API.GetInstance().FreeConnection(conn);

                c.SetData("character_id", id);

                c.TriggerEvent("ShowHUD", c);
                c.TriggerEvent("LoginSuccess");

                ApplyPlayerClothes(c);
                MoneyAPI.API.SyncCash(c);

                c.SendNotification("~g~Erfolgreich eingeloggt!");
            }
            else
            {
                r.Close();
                DatabaseAPI.API.GetInstance().FreeConnection(conn);

                //Log.WriteDError("[" + id + "][" + c.Name + "]: Fehlt in {characters_customization} > Wird zu 'CharacterCreator' weitergeleitet.");
                c.SetData("temp_id", id);
                CharacterCreator(c);
            }
        }
        #endregion

        #region Character Create
        private static void BindHead(MySqlCommand cmd, string type, HeadOverlay headOverlay)
        {
            cmd.Parameters.AddWithValue("@o_i_" + type, headOverlay.Index);
            cmd.Parameters.AddWithValue("@o_c_" + type, headOverlay.Color);
            cmd.Parameters.AddWithValue("@o_c2_" + type, headOverlay.SecondaryColor);
            cmd.Parameters.AddWithValue("@o_o_" + type, headOverlay.Opacity);
        }

        [RemoteEvent("login.character.create")]
        public static void CreateCharacter(Player c, int hair, bool isMale, string headBlendJStr, byte eyeColor, byte hairColor, byte hightlightColor, string faceFeaturesStr, string headOverlaysJStr, string decorationJStr)
        {
            int characterId = c.GetData<int>("temp_id");

            HeadBlend headBlend = JsonConvert.DeserializeObject<HeadBlend>(headBlendJStr);
            float[] faceFeatures = JsonConvert.DeserializeObject<float[]>(faceFeaturesStr);
            Dictionary<int, HeadOverlay> headOverlays = JsonConvert.DeserializeObject<Dictionary<int, HeadOverlay>>(headOverlaysJStr);

            MySqlConnection conn = DatabaseAPI.API.GetInstance().GetConnection();
            MySqlCommand cmd = new MySqlCommand("INSERT INTO characters_customization (" +
                "character_id, sex, h_ShapeFirst, h_ShapeSecond, h_ShapeThird, h_SkinFirst, h_SkinSecond, h_SkinThird, h_ShapeMix, h_SkinMix, h_ThirdMix, " +
                "eyeColor, hairColor, hightlightColor, " +
                "f_noseWidth, f_noseHeight, f_noseLength, f_noseBridge, f_noseTip, " +
                "f_noseShift, f_browHeight, f_browWidth, f_cheekboneHeight, f_cheekboneWidth, " +
                "f_cheeksWidth, f_eyes, f_lips, f_jawWidth, f_jawHeight, " +
                "f_chinLength, f_chinPosition, f_chinWidth, f_chinShape, f_neckWidth, " +
                "o_i_blemishes, o_c_blemishes, o_c2_blemishes, o_o_blemishes, " +
                "o_i_facialHair, o_c_facialHair, o_c2_facialHair, o_o_facialHair, " +
                "o_i_eyebrows, o_c_eyebrows, o_c2_eyebrows, o_o_eyebrows, " +
                "o_i_ageing, o_c_ageing, o_c2_ageing, o_o_ageing, " +
                "o_i_makeup, o_c_makeup, o_c2_makeup, o_o_makeup, " +
                "o_i_blush, o_c_blush, o_c2_blush, o_o_blush, " +
                "o_i_complexion, o_c_complexion, o_c2_complexion, o_o_complexion, " +
                "o_i_sunDamage, o_c_sunDamage, o_c2_sunDamage, o_o_sunDamage, " +
                "o_i_lipstick, o_c_lipstick, o_c2_lipstick, o_o_lipstick, " +
                "o_i_molesFreckles, o_c_molesFreckles, o_c2_molesFreckles, o_o_molesFreckles, " +
                "o_i_chestHair, o_c_chestHair, o_c2_chestHair, o_o_chestHair, " +
                "o_i_bodyBlemishes, o_c_bodyBlemishes, o_c2_bodyBlemishes, o_o_bodyBlemishes, " +
                "o_i_addBodyBlemishes, o_c_addBodyBlemishes, o_c2_addBodyBlemishes, o_o_addBodyBlemishes" +
                ")VALUES(" +
                "@character_id, @sex, @h_ShapeFirst, @h_ShapeSecond, @h_ShapeThird, @h_SkinFirst, @h_SkinSecond, @h_SkinThird, @h_ShapeMix, @h_SkinMix, @h_ThirdMix, " +
                "@eyeColor, @hairColor, @hightlightColor, " +
                "@f_noseWidth, @f_noseHeight, @f_noseLength, @f_noseBridge, @f_noseTip, " +
                "@f_noseShift, @f_browHeight, @f_browWidth, @f_cheekboneHeight, @f_cheekboneWidth, " +
                "@f_cheeksWidth, @f_eyes, @f_lips, @f_jawWidth, @f_jawHeight, " +
                "@f_chinLength, @f_chinPosition, @f_chinWidth, @f_chinShape, @f_neckWidth, " +
                "@o_i_blemishes, @o_c_blemishes, @o_c2_blemishes, @o_o_blemishes, " +
                "@o_i_facialHair, @o_c_facialHair, @o_c2_facialHair, @o_o_facialHair, " +
                "@o_i_eyebrows, @o_c_eyebrows, @o_c2_eyebrows, @o_o_eyebrows, " +
                "@o_i_ageing, @o_c_ageing, @o_c2_ageing, @o_o_ageing, " +
                "@o_i_makeup, @o_c_makeup, @o_c2_makeup, @o_o_makeup, " +
                "@o_i_blush, @o_c_blush, @o_c2_blush, @o_o_blush, " +
                "@o_i_complexion, @o_c_complexion, @o_c2_complexion, @o_o_complexion, " +
                "@o_i_sunDamage, @o_c_sunDamage, @o_c2_sunDamage, @o_o_sunDamage, " +
                "@o_i_lipstick, @o_c_lipstick, @o_c2_lipstick, @o_o_lipstick, " +
                "@o_i_molesFreckles, @o_c_molesFreckles, o_c2_molesFreckles, o_o_molesFreckles, " +
                "@o_i_chestHair, @o_c_chestHair, @o_c2_chestHair, @o_o_chestHair, " +
                "@o_i_bodyBlemishes, @o_c_bodyBlemishes, @o_c2_bodyBlemishes, @o_o_bodyBlemishes, " +
                "@o_i_addBodyBlemishes, @o_c_addBodyBlemishes, @o_c2_addBodyBlemishes, @o_o_addBodyBlemishes" +
                ")",
            conn);

            cmd.Parameters.AddWithValue("@character_id", characterId);
            cmd.Parameters.AddWithValue("@sex", isMale);

            cmd.Parameters.AddWithValue("@h_ShapeFirst", headBlend.ShapeFirst);
            cmd.Parameters.AddWithValue("@h_ShapeSecond", headBlend.ShapeSecond);
            cmd.Parameters.AddWithValue("@h_ShapeThird", headBlend.ShapeThird);
            cmd.Parameters.AddWithValue("@h_SkinFirst", headBlend.SkinFirst);
            cmd.Parameters.AddWithValue("@h_SkinSecond", headBlend.SkinSecond);
            cmd.Parameters.AddWithValue("@h_SkinThird", headBlend.SkinThird);
            cmd.Parameters.AddWithValue("@h_ShapeMix", headBlend.ShapeMix);
            cmd.Parameters.AddWithValue("@h_SkinMix", headBlend.SkinMix);
            cmd.Parameters.AddWithValue("@h_ThirdMix", headBlend.ThirdMix);

            cmd.Parameters.AddWithValue("@eyeColor", eyeColor);
            cmd.Parameters.AddWithValue("@hairColor", hairColor);
            cmd.Parameters.AddWithValue("@hightlightColor", hightlightColor);

            for (int i = 0; i < faceFeatureNames.Length; i++)
            {
                cmd.Parameters.AddWithValue("@" + faceFeatureNames[i], faceFeatures[0]);
            }

            HeadOverlay headOverlay;
            for (int i = 0; i < headOverlayNames.Length; i++)
            {
                string s = headOverlayNames[i];
                if (headOverlays.TryGetValue(i, out headOverlay))
                {
                    BindHead(cmd, s, headOverlay);
                }
                else
                {
                    BindHead(cmd, s, CreateHeadOverlay(0, 0, 0, 0));
                    Log.WriteSError("headOverlays Missing Key: " + s);
                }
            }
            cmd.ExecuteNonQuery();

            cmd = new MySqlCommand("INSERT INTO characters_clothes (character_id, hair, masks, bags, accessories, armor, decals, torsos, shoes, legs, tops, undershirts) VALUES (@charid, @hair, @masks, @bags, @accessories, @armor, @decals, @torsos, @shoes, @legs, @tops, @us)", conn);
            cmd.Parameters.AddWithValue("@charid", characterId);
            cmd.Parameters.AddWithValue("@hair", hair);
            cmd.Parameters.AddWithValue("@shoes", 4);
            if (!isMale)
            {
                cmd.Parameters.AddWithValue("@tops", 0);
                cmd.Parameters.AddWithValue("@torsos", 4);
                cmd.Parameters.AddWithValue("@us", 2);
            }
            else
            {
                cmd.Parameters.AddWithValue("@tops", 13);
                cmd.Parameters.AddWithValue("@torsos", 11);
                cmd.Parameters.AddWithValue("@us", 15);
            }
            cmd.Parameters.AddWithValue("@legs", 4);
            cmd.Parameters.AddWithValue("@masks", 0);
            cmd.Parameters.AddWithValue("@bags", 0);
            cmd.Parameters.AddWithValue("@accessories", 0);
            cmd.Parameters.AddWithValue("@armor", 0);
            cmd.Parameters.AddWithValue("@decals", 0);
            cmd.ExecuteNonQuery();

            DatabaseAPI.API.GetInstance().FreeConnection(conn);

            c.TriggerEvent("toggleCreator", false);
            SelectCharacter(c, characterId);
        }

        public static void CharacterCreator(Player c)
        {
            c.Position = new Vector3(402.8664, -996.4108, -99.00027);

            c.TriggerEvent("toggleCreator", true);
        }

        [RemoteEvent("creator_GenderChange")]
        public static void CharacterCreatorGenderChange(Player c, bool male)
        {
            if (male)
                c.SetSkin(PedHash.FreemodeMale01);
            else
                c.SetSkin(PedHash.FreemodeFemale01);

            c.TriggerEvent("creator_GenderChanged");
            c.Position = new Vector3(402.8664, -996.4108, -99.00027);
        }

        [RemoteEvent("creator_leave")]
        public static void CharacterCreatorLeave(Player c)
        {
            c.Position = new Vector3(-1167.994, -700.4285, 21.89281);
            c.TriggerEvent("toggleCreator", false);
        }
        #endregion

        #region Character
        public static void ApplyPlayerClothes(Player c)
        {
            //Klamotten
            c.SetClothes(6, c.GetData<int>("shoes"), 0);
            c.SetClothes(4, c.GetData<int>("legs"), 0);
            c.SetClothes(11, c.GetData<int>("tops"), 0);
            c.SetClothes(3, c.GetData<int>("torsos"), 0);
            c.SetClothes(8, c.GetData<int>("undershirts"), 0);

            //Haare
            c.SetClothes(2, c.GetData<int>("hair"), 0);
        }
        #endregion
    }
}
