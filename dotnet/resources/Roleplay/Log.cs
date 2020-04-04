using System;

namespace Roleplay
{
    class Log
    {
        private static void WriteLine(ConsoleColor _c, string _prefix, string _text)
        {
            Console.ForegroundColor = ConsoleColor.White;
            Console.Write("[");
            Console.ForegroundColor = ConsoleColor.Blue;
            Console.Write(DateTime.Now.ToShortTimeString());
            Console.ForegroundColor = ConsoleColor.White;
            Console.Write("] [");
            Console.ForegroundColor = _c;
            Console.Write(_prefix);
            Console.ForegroundColor = ConsoleColor.White;
            Console.Write("] :: ");
            Console.WriteLine(_text);
            Console.ForegroundColor = ConsoleColor.White;
        }

        //Informationen
        public static void WriteI(string _text)
        {
            WriteLine(ConsoleColor.Yellow, "INFO", _text);
        }

        //Datenbank Fehlermeldung
        public static void WriteDError(string _text)
        {
            WriteLine(ConsoleColor.Red, "DB FEHLER", _text);
        }

        //MySQL Fehlermeldung
        public static void WriteMError(string _text)
        {
            WriteLine(ConsoleColor.Red, "MYSQL FEHLER", _text);
        }

        //Reader Fehlermeldung
        public static void WriteRError(string _text)
        {
            WriteLine(ConsoleColor.Red, "READER FEHLER", _text);
        }

        //MySQL
        public static void WriteM(string _text)
        {
            WriteLine(ConsoleColor.Cyan, "MYSQL", _text);
        }

        //Server
        public static void WriteS(string _text)
        {
            WriteLine(ConsoleColor.Green, "SERVER", _text);
        }

        //Hiermit kannst Du selber einen Prefix angeben so das es z.B. folgenderweise aussieht: [13:30] [PREFIX] :: TEXT
        public static void Write(ConsoleColor _c, string _prefix, string _text)
        {
            WriteLine(_c, _prefix, _text);
        }
    }
}