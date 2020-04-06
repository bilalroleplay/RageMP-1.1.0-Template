-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 06. Apr 2020 um 03:13
-- Server-Version: 10.4.11-MariaDB
-- PHP-Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `ragemp`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `accounts`
--

INSERT INTO `accounts` (`id`, `username`, `password`) VALUES
(1, 'peter', 'test');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `accounts_socialclub`
--

CREATE TABLE `accounts_socialclub` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `accounts_socialclub`
--

INSERT INTO `accounts_socialclub` (`id`, `account_id`, `name`) VALUES
(1, 1, 'xnxnxnxnxnxn');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bans_socialclub`
--

CREATE TABLE `bans_socialclub` (
  `id` int(11) NOT NULL,
  `socialclub` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `characters`
--

CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `cash` int(255) NOT NULL,
  `dim` int(11) NOT NULL,
  `last_pos_x` float NOT NULL,
  `last_pos_y` float NOT NULL,
  `last_pos_z` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `characters`
--

INSERT INTO `characters` (`id`, `account_id`, `first_name`, `last_name`, `cash`, `dim`, `last_pos_x`, `last_pos_y`, `last_pos_z`) VALUES
(6, 1, 'Doktor', 'Strange', 324234, 0, 3.49134, 14.2282, 70.8869);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `characters_clothes`
--

CREATE TABLE `characters_clothes` (
  `id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL,
  `hair` int(11) NOT NULL,
  `masks` int(11) NOT NULL,
  `torsos` int(11) NOT NULL,
  `legs` int(11) NOT NULL,
  `bags` int(11) NOT NULL,
  `shoes` int(11) NOT NULL,
  `accessories` int(11) NOT NULL,
  `undershirts` int(11) NOT NULL,
  `armor` int(11) NOT NULL,
  `decals` int(11) NOT NULL,
  `tops` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `characters_clothes`
--

INSERT INTO `characters_clothes` (`id`, `character_id`, `hair`, `masks`, `torsos`, `legs`, `bags`, `shoes`, `accessories`, `undershirts`, `armor`, `decals`, `tops`) VALUES
(2, 6, 7, 0, 11, 4, 0, 4, 0, 15, 0, 0, 13);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `characters_customization`
--

CREATE TABLE `characters_customization` (
  `id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL,
  `sex` tinyint(1) NOT NULL,
  `h_ShapeFirst` tinyint(3) UNSIGNED NOT NULL,
  `h_ShapeSecond` tinyint(3) UNSIGNED NOT NULL,
  `h_ShapeThird` tinyint(3) UNSIGNED NOT NULL,
  `h_SkinFirst` tinyint(3) UNSIGNED NOT NULL,
  `h_SkinSecond` tinyint(3) UNSIGNED NOT NULL,
  `h_SkinThird` tinyint(3) UNSIGNED NOT NULL,
  `h_ShapeMix` float NOT NULL,
  `h_SkinMix` float NOT NULL,
  `h_ThirdMix` float NOT NULL,
  `eyeColor` tinyint(3) UNSIGNED NOT NULL,
  `hairColor` tinyint(3) UNSIGNED NOT NULL,
  `hightlightColor` tinyint(3) UNSIGNED NOT NULL,
  `f_noseWidth` float NOT NULL,
  `f_noseHeight` float NOT NULL,
  `f_noseLength` float NOT NULL,
  `f_noseBridge` float NOT NULL,
  `f_noseTip` float NOT NULL,
  `f_noseShift` float NOT NULL,
  `f_browHeight` float NOT NULL,
  `f_browWidth` float NOT NULL,
  `f_cheekboneHeight` float NOT NULL,
  `f_cheekboneWidth` float NOT NULL,
  `f_cheeksWidth` float NOT NULL,
  `f_eyes` float NOT NULL,
  `f_lips` float NOT NULL,
  `f_jawWidth` float NOT NULL,
  `f_jawHeight` float NOT NULL,
  `f_chinLength` float NOT NULL,
  `f_chinPosition` float NOT NULL,
  `f_chinWidth` float NOT NULL,
  `f_chinShape` float NOT NULL,
  `f_neckWidth` float NOT NULL,
  `o_i_blemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_c_blemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_blemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_o_blemishes` float NOT NULL,
  `o_i_facialHair` tinyint(3) UNSIGNED NOT NULL,
  `o_c_facialHair` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_facialHair` tinyint(3) UNSIGNED NOT NULL,
  `o_o_facialHair` float NOT NULL,
  `o_i_eyebrows` tinyint(3) UNSIGNED NOT NULL,
  `o_c_eyebrows` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_eyebrows` tinyint(3) UNSIGNED NOT NULL,
  `o_o_eyebrows` float NOT NULL,
  `o_i_ageing` tinyint(3) UNSIGNED NOT NULL,
  `o_c_ageing` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_ageing` tinyint(3) UNSIGNED NOT NULL,
  `o_o_ageing` float NOT NULL,
  `o_i_makeup` tinyint(3) UNSIGNED NOT NULL,
  `o_c_makeup` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_makeup` tinyint(3) UNSIGNED NOT NULL,
  `o_o_makeup` float NOT NULL,
  `o_i_blush` tinyint(3) UNSIGNED NOT NULL,
  `o_c_blush` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_blush` tinyint(3) UNSIGNED NOT NULL,
  `o_o_blush` float NOT NULL,
  `o_i_complexion` tinyint(3) UNSIGNED NOT NULL,
  `o_c_complexion` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_complexion` tinyint(3) UNSIGNED NOT NULL,
  `o_o_complexion` float NOT NULL,
  `o_i_sunDamage` tinyint(3) UNSIGNED NOT NULL,
  `o_c_sunDamage` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_sunDamage` tinyint(3) UNSIGNED NOT NULL,
  `o_o_sunDamage` float NOT NULL,
  `o_i_lipstick` tinyint(3) UNSIGNED NOT NULL,
  `o_c_lipstick` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_lipstick` tinyint(3) UNSIGNED NOT NULL,
  `o_o_lipstick` float NOT NULL,
  `o_i_molesFreckles` tinyint(3) UNSIGNED NOT NULL,
  `o_c_molesFreckles` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_molesFreckles` tinyint(3) UNSIGNED NOT NULL,
  `o_o_molesFreckles` float NOT NULL,
  `o_i_chestHair` tinyint(3) UNSIGNED NOT NULL,
  `o_c_chestHair` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_chestHair` tinyint(3) UNSIGNED NOT NULL,
  `o_o_chestHair` float NOT NULL,
  `o_i_bodyBlemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_c_bodyBlemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_bodyBlemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_o_bodyBlemishes` float NOT NULL,
  `o_i_addBodyBlemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_c_addBodyBlemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_c2_addBodyBlemishes` tinyint(3) UNSIGNED NOT NULL,
  `o_o_addBodyBlemishes` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `characters_customization`
--

INSERT INTO `characters_customization` (`id`, `character_id`, `sex`, `h_ShapeFirst`, `h_ShapeSecond`, `h_ShapeThird`, `h_SkinFirst`, `h_SkinSecond`, `h_SkinThird`, `h_ShapeMix`, `h_SkinMix`, `h_ThirdMix`, `eyeColor`, `hairColor`, `hightlightColor`, `f_noseWidth`, `f_noseHeight`, `f_noseLength`, `f_noseBridge`, `f_noseTip`, `f_noseShift`, `f_browHeight`, `f_browWidth`, `f_cheekboneHeight`, `f_cheekboneWidth`, `f_cheeksWidth`, `f_eyes`, `f_lips`, `f_jawWidth`, `f_jawHeight`, `f_chinLength`, `f_chinPosition`, `f_chinWidth`, `f_chinShape`, `f_neckWidth`, `o_i_blemishes`, `o_c_blemishes`, `o_c2_blemishes`, `o_o_blemishes`, `o_i_facialHair`, `o_c_facialHair`, `o_c2_facialHair`, `o_o_facialHair`, `o_i_eyebrows`, `o_c_eyebrows`, `o_c2_eyebrows`, `o_o_eyebrows`, `o_i_ageing`, `o_c_ageing`, `o_c2_ageing`, `o_o_ageing`, `o_i_makeup`, `o_c_makeup`, `o_c2_makeup`, `o_o_makeup`, `o_i_blush`, `o_c_blush`, `o_c2_blush`, `o_o_blush`, `o_i_complexion`, `o_c_complexion`, `o_c2_complexion`, `o_o_complexion`, `o_i_sunDamage`, `o_c_sunDamage`, `o_c2_sunDamage`, `o_o_sunDamage`, `o_i_lipstick`, `o_c_lipstick`, `o_c2_lipstick`, `o_o_lipstick`, `o_i_molesFreckles`, `o_c_molesFreckles`, `o_c2_molesFreckles`, `o_o_molesFreckles`, `o_i_chestHair`, `o_c_chestHair`, `o_c2_chestHair`, `o_o_chestHair`, `o_i_bodyBlemishes`, `o_c_bodyBlemishes`, `o_c2_bodyBlemishes`, `o_o_bodyBlemishes`, `o_i_addBodyBlemishes`, `o_c_addBodyBlemishes`, `o_c2_addBodyBlemishes`, `o_o_addBodyBlemishes`) VALUES
(6, 6, 1, 11, 9, 0, 11, 9, 0, 0.91, 1, 0, 5, 37, 32, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6, 5, 0, 0, 0.4, 21, 0, 0, 0.18, 14, 0, 0, 0.12, 11, 0, 0, 0.1, 24, 0, 0, 0.52, 4, 0, 0, 0.22, 9, 0, 0, 0.98, 1, 0, 0, 0.38, 5, 0, 0, 0.66, 10, 0, 0, 0, 2, 0, 0, 0.42, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cms_pages`
--

CREATE TABLE `cms_pages` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` enum('acp','homepage') DEFAULT 'homepage',
  `header` enum('1','0') DEFAULT '1',
  `min_rank` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `cms_pages`
--

INSERT INTO `cms_pages` (`id`, `name`, `title`, `content`, `header`, `min_rank`) VALUES
(1, 'index', 'Startseite', 'homepage', '1', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `house`
--

CREATE TABLE `house` (
  `id` int(11) NOT NULL,
  `status` tinyint(2) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `interior` int(255) DEFAULT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `cost` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `house`
--

INSERT INTO `house` (`id`, `status`, `owner`, `interior`, `x`, `y`, `z`, `locked`, `cost`) VALUES
(6, 0, 'DonaldDuck', 5, 1.67415, 17.7212, 71.0122, 0, 250000),
(7, 0, 'DonaldDuck', 1, -5.51424, 20.0145, 71.2001, 1, 245400);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `accounts_socialclub`
--
ALTER TABLE `accounts_socialclub`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `bans_socialclub`
--
ALTER TABLE `bans_socialclub`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `characters_clothes`
--
ALTER TABLE `characters_clothes`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `characters_customization`
--
ALTER TABLE `characters_customization`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `cms_pages`
--
ALTER TABLE `cms_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `house`
--
ALTER TABLE `house`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT für Tabelle `accounts_socialclub`
--
ALTER TABLE `accounts_socialclub`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `bans_socialclub`
--
ALTER TABLE `bans_socialclub`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `characters`
--
ALTER TABLE `characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `characters_clothes`
--
ALTER TABLE `characters_clothes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `characters_customization`
--
ALTER TABLE `characters_customization`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT für Tabelle `cms_pages`
--
ALTER TABLE `cms_pages`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `house`
--
ALTER TABLE `house`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
