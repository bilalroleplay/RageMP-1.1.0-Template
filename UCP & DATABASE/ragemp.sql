-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 26. Mai 2020 um 11:56
-- Server-Version: 10.4.11-MariaDB
-- PHP-Version: 7.4.6

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
  `password` varchar(255) NOT NULL,
  `max_characters` int(11) NOT NULL DEFAULT 2
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `accounts_socialclub`
--

CREATE TABLE `accounts_socialclub` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Tabellenstruktur für Tabelle `cfg_vehicles`
--

CREATE TABLE `cfg_vehicles` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `hash` int(2) UNSIGNED NOT NULL,
  `multi` int(2) NOT NULL DEFAULT 1,
  `price` int(10) NOT NULL DEFAULT 0,
  `type` tinyint(4) DEFAULT NULL,
  `fuel_tank` float NOT NULL DEFAULT 0,
  `fuel_consumption` float NOT NULL DEFAULT 0,
  `aktiv` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='/epm (Summe)\r\nSELECT *, fuel_tank / fuel_consumption AS range_km From cfg_vehicles' ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `cfg_vehicles`
--

INSERT INTO `cfg_vehicles` (`id`, `name`, `hash`, `multi`, `price`, `type`, `fuel_tank`, `fuel_consumption`, `aktiv`) VALUES
(1, 'adder', 3078201489, 28, 0, 1, 75, 2.1, 1),
(2, 'airbus', 1283517198, 1, 0, NULL, 0, 0, 0),
(3, 'airtug', 1560980623, 1, 0, NULL, 0, 0, 0),
(4, 'akula', 1181327175, 1, 0, NULL, 0, 0, 0),
(5, 'akuma', 1672195559, 20, 0, 1, 13, 0.35, 1),
(6, 'alpha', 767087018, 1, 0, NULL, 0, 0, 0),
(7, 'alphaz1', 2771347558, 1, 0, NULL, 0, 0, 0),
(8, 'ambulance', 1171614426, 50, 0, 1, 110, 1.1, 1),
(9, 'annihilator', 837858166, 1, 0, NULL, 0, 0, 0),
(10, 'apc', 562680400, 1, 0, NULL, 0, 0, 0),
(11, 'ardent', 159274291, 1, 0, NULL, 0, 0, 0),
(12, 'armytanker', 3087536137, 1, 0, NULL, 0, 0, 0),
(13, 'armytrailer2', 2657817814, 1, 0, NULL, 0, 0, 0),
(14, 'asea', 2485144969, 1, 0, NULL, 0, 0, 0),
(15, 'asea2', 2487343317, 1, 0, NULL, 0, 0, 0),
(16, 'asterope', 2391954683, 1, 0, NULL, 0, 0, 0),
(17, 'autarch', 3981782132, 1, 0, NULL, 0, 0, 0),
(18, 'avarus', 2179174271, 20, 0, 1, 15, 0.38, 1),
(19, 'avenger', 2176659152, 1, 0, NULL, 0, 0, 0),
(20, 'bagger', 2154536131, 1, 0, NULL, 0, 0, 0),
(21, 'baletrailer', 3895125590, 1, 0, NULL, 0, 0, 0),
(22, 'baller', 3486135912, 1, 0, NULL, 0, 0, 0),
(23, 'baller2', 142944341, 1, 0, NULL, 0, 0, 0),
(24, 'baller3', 1878062887, 1, 0, NULL, 0, 0, 0),
(25, 'baller4', 634118882, 1, 0, NULL, 0, 0, 0),
(26, 'baller5', 470404958, 1, 0, NULL, 0, 0, 0),
(27, 'baller6', 666166960, 1, 0, NULL, 0, 0, 0),
(28, 'banshee', 3253274834, 1, 0, NULL, 0, 0, 0),
(29, 'banshee2', 633712403, 1, 0, NULL, 0, 0, 0),
(30, 'barracks', 3471458123, 1, 0, NULL, 0, 0, 0),
(31, 'barracks2', 1074326203, 1, 0, NULL, 0, 0, 0),
(32, 'barracks3', 630371791, 1, 0, NULL, 0, 0, 0),
(33, 'barrage', 4081974053, 1, 0, NULL, 0, 0, 0),
(34, 'bati', 4180675781, 20, 0, 1, 14, 0.44, 1),
(35, 'bati2', 3403504941, 1, 0, NULL, 0, 0, 0),
(36, 'benson', 2053223216, 1, 0, 2, 350, 3.6, 1),
(37, 'besra', 1824333165, 1, 0, NULL, 0, 0, 0),
(38, 'bestiagts', 1274868363, 20, 0, 1, 70, 2, 1),
(39, 'bf400', 86520421, 1, 0, NULL, 0, 0, 0),
(40, 'bfinjection', 1126868326, 1, 0, 1, 50, 0.9, 1),
(41, 'biff', 850991848, 1, 0, 2, 300, 3.5, 1),
(42, 'bifta', 3945366167, 1, 0, NULL, 0, 0, 0),
(43, 'bison', 4278019151, 1, 0, NULL, 0, 0, 0),
(44, 'bison2', 2072156101, 1, 0, NULL, 0, 0, 0),
(45, 'bison3', 1739845664, 1, 0, NULL, 0, 0, 0),
(46, 'bjxl', 850565707, 1, 0, NULL, 0, 0, 0),
(47, 'blade', 3089165662, 1, 0, NULL, 0, 0, 0),
(48, 'blazer', 2166734073, 1, 0, 1, 10, 0.48, 1),
(49, 'blazer2', 4246935337, 1, 0, NULL, 0, 0, 0),
(50, 'blazer3', 3025077634, 1, 0, NULL, 0, 0, 0),
(51, 'blazer4', 3854198872, 20, 0, 1, 12, 0.6, 1),
(52, 'blazer5', 2704629607, 1, 0, NULL, 0, 0, 0),
(53, 'blimp', 4143991942, 1, 0, NULL, 0, 0, 0),
(54, 'blimp2', 3681241380, 1, 0, NULL, 0, 0, 0),
(55, 'blimp3', 3987008919, 1, 0, NULL, 0, 0, 0),
(56, 'blista', 3950024287, 1, 0, NULL, 0, 0, 0),
(57, 'blista2', 1039032026, 1, 0, NULL, 0, 0, 0),
(58, 'blista3', 3703315515, 1, 0, NULL, 0, 0, 0),
(59, 'bmx', 1131912276, 1, 0, NULL, 0, 0, 0),
(60, 'boattrailer', 524108981, 1, 0, NULL, 0, 0, 0),
(61, 'bobcatxl', 1069929536, 1, 0, NULL, 0, 0, 0),
(62, 'bodhi2', 2859047862, 1, 0, 1, 60, 0.78, 1),
(63, 'bombushka', 4262088844, 1, 0, NULL, 0, 0, 0),
(64, 'boxville', 2307837162, 1, 0, NULL, 0, 0, 0),
(65, 'boxville2', 4061868990, 1, 0, NULL, 0, 0, 0),
(66, 'boxville3', 121658888, 1, 0, NULL, 0, 0, 0),
(67, 'boxville4', 444171386, 1, 0, 1, 100, 1.4, 1),
(68, 'boxville5', 682434785, 1, 0, NULL, 0, 0, 0),
(69, 'brawler', 2815302597, 1, 0, NULL, 0, 0, 0),
(70, 'brickade', 3989239879, 1, 0, NULL, 0, 0, 0),
(71, 'brioso', 1549126457, 1, 0, NULL, 0, 0, 0),
(72, 'bruiser', 668439077, 1, 0, NULL, 0, 0, 0),
(73, 'bruiser2', 2600885406, 1, 0, NULL, 0, 0, 0),
(74, 'bruiser3', 2252616474, 1, 0, NULL, 0, 0, 0),
(75, 'btype', 117401876, 1, 0, NULL, 0, 0, 0),
(76, 'btype2', 3463132580, 1, 0, NULL, 0, 0, 0),
(77, 'btype3', 3692679425, 1, 0, NULL, 0, 0, 0),
(78, 'buccaneer', 3612755468, 1, 0, NULL, 0, 0, 0),
(79, 'buccaneer2', 3281516360, 1, 0, NULL, 0, 0, 0),
(80, 'buffalo', 3990165190, 1, 0, NULL, 0, 0, 0),
(81, 'buffalo2', 736902334, 1, 0, NULL, 0, 0, 0),
(82, 'buffalo3', 237764926, 1, 0, NULL, 0, 0, 0),
(83, 'bulldozer', 1886712733, 1, 0, NULL, 0, 0, 0),
(84, 'bullet', 2598821281, 1, 0, NULL, 0, 0, 0),
(85, 'burrito', 2948279460, 1, 0, NULL, 0, 0, 0),
(86, 'burrito2', 3387490166, 1, 0, NULL, 0, 0, 0),
(87, 'burrito3', 2551651283, 1, 0, NULL, 0, 0, 0),
(88, 'burrito4', 893081117, 1, 0, 1, 75, 1.1, 1),
(89, 'burrito5', 1132262048, 1, 0, NULL, 0, 0, 0),
(90, 'bus', 3581397346, 1, 0, NULL, 0, 0, 0),
(91, 'buzzard', 788747387, 1, 0, NULL, 0, 0, 0),
(92, 'buzzard2', 745926877, 1, 0, NULL, 0, 0, 0),
(93, 'cablecar', 3334677549, 1, 0, NULL, 0, 0, 0),
(94, 'caddy', 1147287684, 1, 0, NULL, 0, 0, 0),
(95, 'caddy2', 3757070668, 1, 0, NULL, 0, 0, 0),
(96, 'caddy3', 3525819835, 1, 0, NULL, 0, 0, 0),
(97, 'camper', 1876516712, 1, 0, NULL, 0, 0, 0),
(98, 'carbonizzare', 2072687711, 1, 0, NULL, 0, 0, 0),
(99, 'carbonrs', 11251904, 22, 0, 1, 14, 0.43, 1),
(100, 'cargobob', 4244420235, 1, 0, NULL, 0, 0, 0),
(101, 'cargobob2', 1621617168, 1, 0, NULL, 0, 0, 0),
(102, 'cargobob3', 1394036463, 1, 0, NULL, 0, 0, 0),
(103, 'cargobob4', 2025593404, 1, 0, NULL, 0, 0, 0),
(104, 'cargoplane', 368211810, 1, 0, NULL, 0, 0, 0),
(105, 'casco', 941800958, 1, 0, NULL, 0, 0, 0),
(106, 'cavalcade', 2006918058, 1, 0, NULL, 0, 0, 0),
(107, 'cavalcade2', 3505073125, 1, 0, NULL, 0, 0, 0),
(108, 'cerberus', 3493417227, 1, 0, NULL, 0, 0, 0),
(109, 'cerberus2', 679453769, 1, 0, NULL, 0, 0, 0),
(110, 'cerberus3', 1909700336, 1, 0, NULL, 0, 0, 0),
(111, 'cheburek', 3306466016, 1, 0, NULL, 0, 0, 0),
(112, 'cheetah', 2983812512, 1, 0, NULL, 0, 0, 0),
(113, 'cheetah2', 223240013, 1, 0, NULL, 0, 0, 0),
(114, 'chernobog', 3602674979, 1, 0, NULL, 0, 0, 0),
(115, 'chimera', 6774487, 1, 0, NULL, 0, 0, 0),
(116, 'chino', 349605904, 1, 0, NULL, 0, 0, 0),
(117, 'chino2', 2933279331, 1, 0, NULL, 0, 0, 0),
(118, 'cliffhanger', 390201602, 1, 0, NULL, 0, 0, 0),
(119, 'clique', 2728360112, 1, 0, NULL, 0, 0, 0),
(120, 'coach', 2222034228, 1, 0, NULL, 0, 0, 0),
(121, 'cog55', 906642318, 1, 0, NULL, 0, 0, 0),
(122, 'cog552', 704435172, 1, 0, NULL, 0, 0, 0),
(123, 'cogcabrio', 330661258, 1, 0, NULL, 0, 0, 0),
(124, 'cognoscenti', 2264796000, 1, 0, NULL, 0, 0, 0),
(125, 'cognoscenti2', 3690124666, 1, 0, NULL, 0, 0, 0),
(126, 'comet2', 3249425686, 1, 0, NULL, 0, 0, 0),
(127, 'comet3', 2272483501, 1, 0, NULL, 0, 0, 0),
(128, 'comet4', 1561920505, 1, 0, NULL, 0, 0, 0),
(129, 'contender', 683047626, 1, 0, NULL, 0, 0, 0),
(130, 'coquette', 108773431, 20, 0, 1, 70, 1.8, 1),
(131, 'coquette2', 1011753235, 1, 0, NULL, 0, 0, 0),
(132, 'coquette3', 784565758, 1, 0, NULL, 0, 0, 0),
(133, 'cruiser', 448402357, 1, 0, 1, -1, -1, 1),
(134, 'crusader', 321739290, 1, 0, NULL, 0, 0, 0),
(135, 'cuban800', 3650256867, 1, 0, NULL, 0, 0, 0),
(136, 'cutter', 3288047904, 1, 0, NULL, 0, 0, 0),
(137, 'cyclone', 1392481335, 1, 0, NULL, 0, 0, 0),
(138, 'daemon', 2006142190, 1, 0, NULL, 0, 0, 0),
(139, 'daemon2', 2890830793, 1, 0, NULL, 0, 0, 0),
(140, 'deathbike', 4267640610, 20, 0, 1, 14, 0.4, 1),
(141, 'deathbike2', 2482017624, 1, 0, NULL, 0, 0, 0),
(142, 'deathbike3', 2920466844, 1, 0, NULL, 0, 0, 0),
(143, 'defiler', 822018448, 1, 0, NULL, 0, 0, 0),
(144, 'deluxo', 1483171323, 1, 0, NULL, 0, 0, 0),
(145, 'deveste', 1591739866, 1, 0, NULL, 0, 0, 0),
(146, 'deviant', 1279262537, 1, 0, NULL, 0, 0, 0),
(147, 'diablous', 4055125828, 1, 0, NULL, 0, 0, 0),
(148, 'diablous2', 1790834270, 1, 0, NULL, 0, 0, 0),
(149, 'dilettante', 3164157193, 1, 0, NULL, 0, 0, 0),
(150, 'dilettante2', 1682114128, 1, 0, NULL, 0, 0, 0),
(151, 'dinghy', 1033245328, 1, 0, NULL, 0, 0, 0),
(152, 'dinghy2', 276773164, 1, 0, NULL, 0, 0, 0),
(153, 'dinghy3', 509498602, 1, 0, NULL, 0, 0, 0),
(154, 'dinghy4', 867467158, 1, 0, NULL, 0, 0, 0),
(155, 'dloader', 1770332643, 1, 0, NULL, 0, 0, 0),
(156, 'docktrailer', 2154757102, 1, 0, NULL, 0, 0, 0),
(157, 'docktug', 3410276810, 1, 0, NULL, 0, 0, 0),
(158, 'dodo', 3393804037, 1, 0, NULL, 0, 0, 0),
(159, 'dominator', 80636076, 1, 0, NULL, 0, 0, 0),
(160, 'dominator2', 3379262425, 1, 0, NULL, 0, 0, 0),
(161, 'dominator3', 3308022675, 1, 0, NULL, 0, 0, 0),
(162, 'dominator4', 3606777648, 1, 0, NULL, 0, 0, 0),
(163, 'dominator5', 2919906639, 1, 0, NULL, 0, 0, 0),
(164, 'dominator6', 3001042683, 1, 0, NULL, 0, 0, 0),
(165, 'double', 2623969160, 1, 0, NULL, 0, 0, 0),
(166, 'dubsta', 1177543287, 1, 0, NULL, 0, 0, 0),
(167, 'dubsta2', 3900892662, 1, 0, NULL, 0, 0, 0),
(168, 'dubsta3', 3057713523, 2, 0, 1, 100, 1.8, 1),
(169, 'dukes', 723973206, 1, 0, NULL, 0, 0, 0),
(170, 'dukes2', 3968823444, 1, 0, NULL, 0, 0, 0),
(171, 'dump', 2164484578, 1, 0, NULL, 0, 0, 0),
(172, 'dune', 2633113103, 1, 0, NULL, 0, 0, 0),
(173, 'dune2', 534258863, 1, 0, NULL, 0, 0, 0),
(174, 'dune3', 1897744184, 1, 0, NULL, 0, 0, 0),
(175, 'dune4', 3467805257, 1, 0, NULL, 0, 0, 0),
(176, 'dune5', 3982671785, 1, 0, NULL, 0, 0, 0),
(177, 'duster', 970356638, 1, 0, NULL, 0, 0, 0),
(178, 'elegy', 196747873, 1, 0, NULL, 0, 0, 0),
(179, 'elegy2', 3728579874, 1, 0, NULL, 0, 0, 0),
(180, 'emperor', 3609690755, 1, 0, NULL, 0, 0, 0),
(181, 'emperor2', 2411965148, 1, 0, 1, 55, 0.78, 1),
(182, 'emperor3', 3053254478, 1, 0, NULL, 0, 0, 0),
(183, 'enduro', 1753414259, 1, 0, NULL, 0, 0, 0),
(184, 'entityxf', 3003014393, 1, 0, NULL, 0, 0, 0),
(185, 'esskey', 2035069708, 1, 0, NULL, 0, 0, 0),
(186, 'exemplar', 4289813342, 1, 0, NULL, 0, 0, 0),
(187, 'f620', 3703357000, 1, 0, NULL, 0, 0, 0),
(188, 'faction', 2175389151, 1, 0, NULL, 0, 0, 0),
(189, 'faction2', 2504420315, 1, 0, NULL, 0, 0, 0),
(190, 'faction3', 2255212070, 1, 0, NULL, 0, 0, 0),
(191, 'faggio', 2452219115, 1, 0, 1, 5, 0.16, 1),
(192, 'faggio2', 55628203, 1, 0, 1, 5, 0.17, 1),
(193, 'faggio3', 3005788552, 1, 0, NULL, 0, 0, 0),
(194, 'fbi', 1127131465, 1, 0, NULL, 0, 0, 0),
(195, 'fbi2', 2647026068, 1, 0, NULL, 0, 0, 0),
(196, 'fcr', 627535535, 1, 0, NULL, 0, 0, 0),
(197, 'fcr2', 3537231886, 1, 0, NULL, 0, 0, 0),
(198, 'felon', 3903372712, 1, 0, NULL, 0, 0, 0),
(199, 'felon2', 4205676014, 1, 0, NULL, 0, 0, 0),
(200, 'feltzer2', 2299640309, 1, 0, NULL, 0, 0, 0),
(201, 'feltzer3', 2728226064, 1, 0, NULL, 0, 0, 0),
(202, 'firetruk', 1938952078, 30, 0, 2, 110, 1.99, 1),
(203, 'fixter', 3458454463, 1, 0, 1, -1, -1, 1),
(204, 'flatbed', 1353720154, 1, 0, NULL, 0, 0, 0),
(205, 'fmj', 1426219628, 1, 0, NULL, 0, 0, 0),
(206, 'forklift', 1491375716, 1, 0, NULL, 0, 0, 0),
(207, 'fq2', 3157435195, 1, 0, NULL, 0, 0, 0),
(208, 'freecrawler', 4240635011, 1, 0, NULL, 0, 0, 0),
(209, 'freight', 1030400667, 1, 0, NULL, 0, 0, 0),
(210, 'freightcar', 184361638, 1, 0, NULL, 0, 0, 0),
(211, 'freightcont1', 920453016, 1, 0, NULL, 0, 0, 0),
(212, 'freightcont2', 240201337, 1, 0, NULL, 0, 0, 0),
(213, 'freightgrain', 642617954, 1, 0, NULL, 0, 0, 0),
(214, 'frogger', 744705981, 1, 0, NULL, 0, 0, 0),
(215, 'frogger2', 1949211328, 1, 0, NULL, 0, 0, 0),
(216, 'fugitive', 1909141499, 1, 0, NULL, 0, 0, 0),
(217, 'furoregt', 3205927392, 1, 0, NULL, 0, 0, 0),
(218, 'fusilade', 499169875, 1, 0, NULL, 0, 0, 0),
(219, 'futo', 2016857647, 1, 0, NULL, 0, 0, 0),
(220, 'gargoyle', 741090084, 1, 0, NULL, 0, 0, 0),
(221, 'gauntlet', 2494797253, 1, 0, NULL, 0, 0, 0),
(222, 'gauntlet2', 349315417, 1, 0, NULL, 0, 0, 0),
(223, 'gburrito', 2549763894, 1, 0, NULL, 0, 0, 0),
(224, 'gburrito2', 296357396, 1, 0, 1, 75, 1.1, 1),
(225, 'glendale', 75131841, 1, 0, NULL, 0, 0, 0),
(226, 'gp1', 1234311532, 1, 0, NULL, 0, 0, 0),
(227, 'graintrailer', 1019737494, 1, 0, NULL, 0, 0, 0),
(228, 'granger', 2519238556, 1, 0, NULL, 0, 0, 0),
(229, 'gresley', 2751205197, 1, 0, NULL, 0, 0, 0),
(230, 'gt500', 2215179066, 1, 0, NULL, 0, 0, 0),
(231, 'guardian', 2186977100, 1, 0, NULL, 0, 0, 0),
(232, 'habanero', 884422927, 1, 0, NULL, 0, 0, 0),
(233, 'hakuchou', 1265391242, 1, 0, NULL, 0, 0, 0),
(234, 'hakuchou2', 4039289119, 1, 0, NULL, 0, 0, 0),
(235, 'halftrack', 4262731174, 1, 0, NULL, 0, 0, 0),
(236, 'handler', 444583674, 1, 0, NULL, 0, 0, 0),
(237, 'hauler', 1518533038, 1, 0, NULL, 0, 0, 0),
(238, 'hauler2', 387748548, 1, 0, NULL, 0, 0, 0),
(239, 'havok', 2310691317, 1, 0, NULL, 0, 0, 0),
(240, 'hermes', 15219735, 1, 0, NULL, 0, 0, 0),
(241, 'hexer', 301427732, 1, 0, NULL, 0, 0, 0),
(242, 'hotknife', 37348240, 1, 0, NULL, 0, 0, 0),
(243, 'hotring', 1115909093, 1, 0, NULL, 0, 0, 0),
(244, 'howard', 3287439187, 1, 0, NULL, 0, 0, 0),
(245, 'hunter', 4252008158, 1, 0, NULL, 0, 0, 0),
(246, 'huntley', 486987393, 1, 0, NULL, 0, 0, 0),
(247, 'hydra', 970385471, 1, 0, NULL, 0, 0, 0),
(248, 'impaler', 2198276962, 1, 0, NULL, 0, 0, 0),
(249, 'impaler2', 1009171724, 1, 0, NULL, 0, 0, 0),
(250, 'impaler3', 2370166601, 1, 0, NULL, 0, 0, 0),
(251, 'impaler4', 2550461639, 1, 0, NULL, 0, 0, 0),
(252, 'imperator', 444994115, 1, 0, NULL, 0, 0, 0),
(253, 'imperator2', 1637620610, 1, 0, NULL, 0, 0, 0),
(254, 'imperator3', 3539435063, 1, 0, NULL, 0, 0, 0),
(255, 'infernus', 418536135, 1, 0, NULL, 0, 0, 0),
(256, 'infernus2', 2889029532, 1, 0, NULL, 0, 0, 0),
(257, 'ingot', 3005245074, 1, 0, NULL, 0, 0, 0),
(258, 'innovation', 4135840458, 20, 0, 1, 13, 0.45, 1),
(259, 'insurgent', 2434067162, 1, 0, NULL, 0, 0, 0),
(260, 'insurgent2', 2071877360, 1, 0, NULL, 0, 0, 0),
(261, 'insurgent3', 2370534026, 1, 0, NULL, 0, 0, 0),
(262, 'intruder', 886934177, 1, 0, NULL, 0, 0, 0),
(263, 'issi2', 3117103977, 1, 0, NULL, 0, 0, 0),
(264, 'issi3', 931280609, 1, 0, NULL, 0, 0, 0),
(265, 'issi4', 628003514, 1, 0, NULL, 0, 0, 0),
(266, 'issi5', 1537277726, 1, 0, NULL, 0, 0, 0),
(267, 'issi6', 1239571361, 1, 0, NULL, 0, 0, 0),
(268, 'italigtb', 2246633323, 1, 0, NULL, 0, 0, 0),
(269, 'italigtb2', 3812247419, 1, 0, NULL, 0, 0, 0),
(270, 'italigto', 3963499524, 20, 0, 1, 70, 1.8, 1),
(271, 'jackal', 3670438162, 1, 0, NULL, 0, 0, 0),
(272, 'jb700', 1051415893, 1, 0, NULL, 0, 0, 0),
(273, 'jester', 2997294755, 20, 0, 1, 72, 1.7, 1),
(274, 'jester2', 3188613414, 1, 0, NULL, 0, 0, 0),
(275, 'jet', 1058115860, 1, 0, NULL, 0, 0, 0),
(276, 'jetmax', 861409633, 1, 0, NULL, 0, 0, 0),
(277, 'journey', 4174679674, 1, 0, NULL, 0, 0, 0),
(278, 'kalahari', 92612664, 1, 0, NULL, 0, 0, 0),
(279, 'khamelion', 544021352, 30, 0, 1, 65, 1.7, 1),
(280, 'khanjali', 2859440138, 1, 0, NULL, 0, 0, 0),
(281, 'kuruma', 2922118804, 21, 0, 1, 65, 1.5, 1),
(282, 'kuruma2', 410882957, 1, 0, NULL, 0, 0, 0),
(283, 'landstalker', 1269098716, 1, 0, NULL, 0, 0, 0),
(284, 'lazer', 3013282534, 1, 0, NULL, 0, 0, 0),
(285, 'le7b', 3062131285, 1, 0, NULL, 0, 0, 0),
(286, 'lectro', 640818791, 1, 0, NULL, 0, 0, 0),
(287, 'lguard', 469291905, 1, 0, NULL, 0, 0, 0),
(288, 'limo2', 4180339789, 1, 0, NULL, 0, 0, 0),
(289, 'lurcher', 2068293287, 1, 0, NULL, 0, 0, 0),
(290, 'luxor', 621481054, 1, 0, NULL, 0, 0, 0),
(291, 'luxor2', 3080673438, 1, 0, NULL, 0, 0, 0),
(292, 'lynx', 482197771, 1, 0, NULL, 0, 0, 0),
(293, 'mamba', 2634021974, 1, 0, NULL, 0, 0, 0),
(294, 'mammatus', 2548391185, 1, 0, NULL, 0, 0, 0),
(295, 'manana', 2170765704, 1, 0, NULL, 0, 0, 0),
(296, 'manchez', 2771538552, 1, 0, NULL, 0, 0, 0),
(297, 'marquis', 3251507587, 1, 0, NULL, 0, 0, 0),
(298, 'marshall', 1233534620, 1, 0, NULL, 0, 0, 0),
(299, 'massacro', 4152024626, 1, 0, NULL, 0, 0, 0),
(300, 'massacro2', 3663206819, 1, 0, NULL, 0, 0, 0),
(301, 'maverick', 2634305738, 1, 0, NULL, 0, 0, 0),
(302, 'menacer', 2044532910, 1, 0, NULL, 0, 0, 0),
(303, 'mesa', 914654722, 1, 0, NULL, 0, 0, 0),
(304, 'mesa2', 3546958660, 1, 0, NULL, 0, 0, 0),
(305, 'mesa3', 2230595153, 1, 0, NULL, 0, 0, 0),
(306, 'microlight', 2531412055, 1, 0, NULL, 0, 0, 0),
(307, 'miljet', 165154707, 1, 0, NULL, 0, 0, 0),
(308, 'minivan', 3984502180, 1, 0, NULL, 0, 0, 0),
(309, 'minivan2', 3168702960, 1, 0, NULL, 0, 0, 0),
(310, 'mixer', 3510150843, 1, 0, NULL, 0, 0, 0),
(311, 'mixer2', 475220373, 1, 0, NULL, 0, 0, 0),
(312, 'mogul', 3545667823, 1, 0, NULL, 0, 0, 0),
(313, 'molotok', 1565978651, 1, 0, NULL, 0, 0, 0),
(314, 'monroe', 3861591579, 1, 0, NULL, 0, 0, 0),
(315, 'monster', 3449006043, 1, 0, NULL, 0, 0, 0),
(316, 'monster3', 1721676810, 1, 0, NULL, 0, 0, 0),
(317, 'monster4', 840387324, 1, 0, NULL, 0, 0, 0),
(318, 'monster5', 3579220348, 1, 0, NULL, 0, 0, 0),
(319, 'moonbeam', 525509695, 1, 0, NULL, 0, 0, 0),
(320, 'moonbeam2', 1896491931, 1, 0, NULL, 0, 0, 0),
(321, 'mower', 1783355638, 1, 0, NULL, 0, 0, 0),
(322, 'mule', 904750859, 1, 0, 1, 110, 1.8, 1),
(323, 'mule2', 3244501995, 1, 0, NULL, 0, 0, 0),
(324, 'mule3', 2242229361, 1, 0, NULL, 0, 0, 0),
(325, 'mule4', 1945374990, 1, 0, NULL, 0, 0, 0),
(326, 'nemesis', 3660088182, 1, 0, NULL, 0, 0, 0),
(327, 'neon', 2445973230, 1, 0, NULL, 0, 0, 0),
(328, 'nero', 1034187331, 1, 0, NULL, 0, 0, 0),
(329, 'nero2', 1093792632, 1, 0, NULL, 0, 0, 0),
(330, 'nightblade', 2688780135, 1, 0, NULL, 0, 0, 0),
(331, 'nightshade', 2351681756, 1, 0, NULL, 0, 0, 0),
(332, 'nightshark', 433954513, 1, 0, NULL, 0, 0, 0),
(333, 'nimbus', 2999939664, 1, 0, NULL, 0, 0, 0),
(334, 'ninef', 1032823388, 20, 0, 1, 80, 2.1, 1),
(335, 'ninef2', 2833484545, 1, 0, NULL, 0, 0, 0),
(336, 'nokota', 1036591958, 1, 0, NULL, 0, 0, 0),
(337, 'omnis', 3517794615, 1, 0, NULL, 0, 0, 0),
(338, 'oppressor', 884483972, 1, 0, NULL, 0, 0, 0),
(339, 'oppressor2', 2069146067, 1, 0, NULL, 0, 0, 0),
(340, 'oracle', 1348744438, 1, 0, NULL, 0, 0, 0),
(341, 'oracle2', 3783366066, 1, 0, NULL, 0, 0, 0),
(342, 'osiris', 1987142870, 1, 0, NULL, 0, 0, 0),
(343, 'packer', 569305213, 1, 0, NULL, 0, 0, 0),
(344, 'panto', 3863274624, 1, 0, NULL, 0, 0, 0),
(345, 'paradise', 1488164764, 1, 0, 1, 75, 1.1, 1),
(346, 'pariah', 867799010, 1, 0, NULL, 0, 0, 0),
(347, 'patriot', 3486509883, 1, 0, NULL, 0, 0, 0),
(348, 'patriot2', 3874056184, 1, 0, NULL, 0, 0, 0),
(349, 'pbus', 2287941233, 1, 0, NULL, 0, 0, 0),
(350, 'pbus2', 345756458, 1, 0, NULL, 0, 0, 0),
(351, 'pcj', 3385765638, 1, 0, NULL, 0, 0, 0),
(352, 'penetrator', 2536829930, 1, 0, NULL, 0, 0, 0),
(353, 'penumbra', 3917501776, 1, 0, NULL, 0, 0, 0),
(354, 'peyote', 1830407356, 1, 0, NULL, 0, 0, 0),
(355, 'pfister811', 2465164804, 1, 0, NULL, 0, 0, 0),
(356, 'phantom', 2157618379, 1, 0, NULL, 0, 0, 0),
(357, 'phantom2', 2645431192, 1, 0, NULL, 0, 0, 0),
(358, 'phantom3', 177270108, 1, 0, NULL, 0, 0, 0),
(359, 'phoenix', 2199527893, 1, 0, NULL, 0, 0, 0),
(360, 'picador', 1507916787, 1, 0, NULL, 0, 0, 0),
(361, 'pigalle', 1078682497, 1, 0, NULL, 0, 0, 0),
(362, 'police', 2046537925, 23, 0, 1, 75, 0.99, 1),
(363, 'police2', 2667966721, 28, 0, 1, 75, 1.2, 1),
(364, 'police3', 1912215274, 44, 0, 1, 80, 1.8, 1),
(365, 'police4', 2321795001, 1, 0, NULL, 0, 0, 0),
(366, 'policeb', 4260343491, 1, 0, NULL, 0, 0, 0),
(367, 'policeold1', 2758042359, 1, 0, NULL, 0, 0, 0),
(368, 'policeold2', 2515846680, 1, 0, NULL, 0, 0, 0),
(369, 'policet', 456714581, 1, 0, NULL, 0, 0, 0),
(370, 'polmav', 353883353, 1, 0, NULL, 0, 0, 0),
(371, 'pony', 4175309224, 1, 0, 1, 80, 1.1, 1),
(372, 'pony2', 943752001, 1, 0, 1, 75, 1.1, 1),
(373, 'pounder', 2112052861, 1, 0, 2, 480, 4.1, 1),
(374, 'pounder2', 1653666139, 1, 0, NULL, 0, 0, 0),
(375, 'prairie', 2844316578, 1, 0, NULL, 0, 0, 0),
(376, 'pranger', 741586030, 1, 0, NULL, 0, 0, 0),
(377, 'predator', 3806844075, 1, 0, NULL, 0, 0, 0),
(378, 'premier', 2411098011, 1, 0, NULL, 0, 0, 0),
(379, 'primo', 3144368207, 1, 0, NULL, 0, 0, 0),
(380, 'primo2', 2254540506, 1, 0, NULL, 0, 0, 0),
(381, 'proptrailer', 356391690, 1, 0, NULL, 0, 0, 0),
(382, 'prototipo', 2123327359, 1, 0, NULL, 0, 0, 0),
(383, 'pyro', 2908775872, 1, 0, NULL, 0, 0, 0),
(384, 'radi', 2643899483, 1, 0, NULL, 0, 0, 0),
(385, 'raiden', 2765724541, 20, 0, 1, 70, 1.77, 1),
(386, 'raketrailer', 390902130, 1, 0, NULL, 0, 0, 0),
(387, 'rallytruck', 2191146052, 1, 0, NULL, 0, 0, 0),
(388, 'rancherxl', 1645267888, 1, 0, NULL, 0, 0, 0),
(389, 'rancherxl2', 1933662059, 1, 0, NULL, 0, 0, 0),
(390, 'rapidgt', 2360515092, 1, 0, NULL, 0, 0, 0),
(391, 'rapidgt2', 1737773231, 1, 0, NULL, 0, 0, 0),
(392, 'rapidgt3', 2049897956, 1, 0, NULL, 0, 0, 0),
(393, 'raptor', 3620039993, 1, 0, NULL, 0, 0, 0),
(394, 'ratbike', 1873600305, 1, 0, NULL, 0, 0, 0),
(395, 'ratloader', 3627815886, 1, 0, NULL, 0, 0, 0),
(396, 'ratloader2', 3705788919, 1, 0, NULL, 0, 0, 0),
(397, 'rcbandito', 4008920556, 1, 0, NULL, 0, 0, 0),
(398, 'reaper', 234062309, 1, 0, NULL, 0, 0, 0),
(399, 'rebel', 3087195462, 1, 0, NULL, 0, 0, 0),
(400, 'rebel2', 2249373259, 1, 0, NULL, 0, 0, 0),
(401, 'regina', 4280472072, 1, 0, NULL, 0, 0, 0),
(402, 'rentalbus', 3196165219, 1, 0, NULL, 0, 0, 0),
(403, 'retinue', 1841130506, 1, 0, NULL, 0, 0, 0),
(404, 'revolter', 3884762073, 1, 0, NULL, 0, 0, 0),
(405, 'rhapsody', 841808271, 1, 0, NULL, 0, 0, 0),
(406, 'rhino', 782665360, 1, 0, NULL, 0, 0, 0),
(407, 'riata', 2762269779, 1, 0, NULL, 0, 0, 0),
(408, 'riot', 3089277354, 1, 0, NULL, 0, 0, 0),
(409, 'riot2', 2601952180, 1, 0, NULL, 0, 0, 0),
(410, 'ripley', 3448987385, 1, 0, NULL, 0, 0, 0),
(411, 'rocoto', 2136773105, 1, 0, NULL, 0, 0, 0),
(412, 'rogue', 3319621991, 1, 0, NULL, 0, 0, 0),
(413, 'romero', 627094268, 1, 0, NULL, 0, 0, 0),
(414, 'rubble', 2589662668, 1, 0, 2, 360, 3.9, 1),
(415, 'ruffian', 3401388520, 1, 0, NULL, 0, 0, 0),
(416, 'ruiner', 4067225593, 1, 0, NULL, 0, 0, 0),
(417, 'ruiner2', 941494461, 1, 0, NULL, 0, 0, 0),
(418, 'ruiner3', 777714999, 1, 0, NULL, 0, 0, 0),
(419, 'rumpo', 1162065741, 1, 0, NULL, 0, 0, 0),
(420, 'rumpo2', 2518351607, 1, 0, NULL, 0, 0, 0),
(421, 'rumpo3', 1475773103, 1, 0, 1, 90, 1.2, 1),
(422, 'ruston', 719660200, 1, 0, NULL, 0, 0, 0),
(423, 'sabregt', 2609945748, 1, 0, NULL, 0, 0, 0),
(424, 'sabregt2', 223258115, 1, 0, NULL, 0, 0, 0),
(425, 'sadler', 3695398481, 1, 0, NULL, 0, 0, 0),
(426, 'sadler2', 734217681, 1, 0, NULL, 0, 0, 0),
(427, 'sanchez2', 2841686334, 1, 0, NULL, 0, 0, 0),
(428, 'sanctus', 1491277511, 1, 0, NULL, 0, 0, 0),
(429, 'sandking', 3105951696, 1, 0, NULL, 0, 0, 0),
(430, 'sandking2', 989381445, 1, 0, NULL, 0, 0, 0),
(431, 'savage', 4212341271, 1, 0, NULL, 0, 0, 0),
(432, 'savestra', 903794909, 1, 0, NULL, 0, 0, 0),
(433, 'sc1', 1352136073, 1, 0, NULL, 0, 0, 0),
(434, 'scarab', 3147997943, 1, 0, NULL, 0, 0, 0),
(435, 'scarab2', 1542143200, 1, 0, NULL, 0, 0, 0),
(436, 'scarab3', 3715219435, 1, 0, NULL, 0, 0, 0),
(437, 'schafter2', 3039514899, 1, 0, NULL, 0, 0, 0),
(438, 'schafter3', 2809443750, 1, 0, NULL, 0, 0, 0),
(439, 'schafter4', 1489967196, 1, 0, NULL, 0, 0, 0),
(440, 'schafter5', 3406724313, 1, 0, NULL, 0, 0, 0),
(441, 'schafter6', 1922255844, 1, 0, NULL, 0, 0, 0),
(442, 'schlagen', 3787471536, 1, 0, NULL, 0, 0, 0),
(443, 'schwarzer', 3548084598, 1, 0, NULL, 0, 0, 0),
(444, 'scorcher', 4108429845, 1, 0, NULL, 0, 0, 0),
(445, 'scramjet', 3656405053, 1, 0, NULL, 0, 0, 0),
(446, 'scrap', 2594165727, 1, 0, 1, 54, 1.2, 1),
(447, 'seabreeze', 3902291871, 1, 0, NULL, 0, 0, 0),
(448, 'seashark', 3264692260, 1, 0, NULL, 0, 0, 0),
(449, 'seashark2', 3678636260, 1, 0, NULL, 0, 0, 0),
(450, 'seashark3', 3983945033, 1, 0, NULL, 0, 0, 0),
(451, 'seasparrow', 3568198617, 1, 0, NULL, 0, 0, 0),
(452, 'seminole', 1221512915, 1, 0, NULL, 0, 0, 0),
(453, 'sentinel', 1349725314, 1, 0, NULL, 0, 0, 0),
(454, 'sentinel2', 873639469, 1, 0, NULL, 0, 0, 0),
(455, 'sentinel3', 1104234922, 1, 0, NULL, 0, 0, 0),
(456, 'serrano', 1337041428, 1, 0, NULL, 0, 0, 0),
(457, 'seven70', 2537130571, 1, 0, NULL, 0, 0, 0),
(458, 'shamal', 3080461301, 1, 0, NULL, 0, 0, 0),
(459, 'sheava', 819197656, 1, 0, NULL, 0, 0, 0),
(460, 'sheriff', 2611638396, 1, 0, NULL, 0, 0, 0),
(461, 'sheriff2', 1922257928, 1, 0, NULL, 0, 0, 0),
(462, 'shotaro', 3889340782, 1, 0, NULL, 0, 0, 0),
(463, 'skylift', 1044954915, 1, 0, NULL, 0, 0, 0),
(464, 'slamvan', 729783779, 1, 0, NULL, 0, 0, 0),
(465, 'slamvan2', 833469436, 1, 0, NULL, 0, 0, 0),
(466, 'slamvan3', 1119641113, 1, 0, NULL, 0, 0, 0),
(467, 'slamvan4', 2233918197, 1, 0, NULL, 0, 0, 0),
(468, 'slamvan5', 373261600, 1, 0, NULL, 0, 0, 0),
(469, 'slamvan6', 1742022738, 1, 0, NULL, 0, 0, 0),
(470, 'sovereign', 743478836, 15, 0, 1, 16, 0.68, 1),
(471, 'specter', 1886268224, 1, 0, NULL, 0, 0, 0),
(472, 'specter2', 1074745671, 1, 0, NULL, 0, 0, 0),
(473, 'speeder', 231083307, 1, 0, NULL, 0, 0, 0),
(474, 'speeder2', 437538602, 1, 0, NULL, 0, 0, 0),
(475, 'speedo', 3484649228, 1, 0, 1, 68, 1.3, 1),
(476, 'speedo2', 728614474, 1, 0, NULL, 0, 0, 0),
(477, 'speedo4', 219613597, 1, 0, NULL, 0, 0, 0),
(478, 'squalo', 400514754, 1, 0, NULL, 0, 0, 0),
(479, 'stafford', 321186144, 1, 0, NULL, 0, 0, 0),
(480, 'stalion', 1923400478, 1, 0, NULL, 0, 0, 0),
(481, 'stalion2', 3893323758, 1, 0, NULL, 0, 0, 0),
(482, 'stanier', 2817386317, 1, 0, NULL, 0, 0, 0),
(483, 'starling', 2594093022, 1, 0, NULL, 0, 0, 0),
(484, 'stinger', 1545842587, 1, 0, NULL, 0, 0, 0),
(485, 'stingergt', 2196019706, 1, 0, NULL, 0, 0, 0),
(486, 'stockade', 1747439474, 1, 0, NULL, 0, 0, 0),
(487, 'stockade3', 4080511798, 1, 0, NULL, 0, 0, 0),
(488, 'stratum', 1723137093, 1, 0, NULL, 0, 0, 0),
(489, 'streiter', 1741861769, 1, 0, NULL, 0, 0, 0),
(490, 'stretch', 2333339779, 1, 0, NULL, 0, 0, 0),
(491, 'strikeforce', 1692272545, 1, 0, NULL, 0, 0, 0),
(492, 'stromberg', 886810209, 1, 0, NULL, 0, 0, 0),
(493, 'stunt', 2172210288, 1, 0, NULL, 0, 0, 0),
(494, 'submersible', 771711535, 1, 0, NULL, 0, 0, 0),
(495, 'submersible2', 3228633070, 1, 0, NULL, 0, 0, 0),
(496, 'sultan', 970598228, 1, 0, NULL, 0, 0, 0),
(497, 'sultanrs', 3999278268, 1, 0, NULL, 0, 0, 0),
(498, 'suntrap', 4012021193, 1, 0, NULL, 0, 0, 0),
(499, 'superd', 1123216662, 1, 0, NULL, 0, 0, 0),
(500, 'supervolito', 710198397, 1, 0, NULL, 0, 0, 0),
(501, 'supervolito2', 2623428164, 1, 0, NULL, 0, 0, 0),
(502, 'surano', 384071873, 1, 0, NULL, 0, 0, 0),
(503, 'surfer', 699456151, 1, 0, NULL, 0, 0, 0),
(504, 'surfer2', 2983726598, 1, 0, 1, 66, 1.33, 1),
(505, 'surge', 2400073108, 1, 0, NULL, 0, 0, 0),
(506, 'swift', 3955379698, 1, 0, NULL, 0, 0, 0),
(507, 'swift2', 1075432268, 1, 0, NULL, 0, 0, 0),
(508, 'swinger', 500482303, 1, 0, NULL, 0, 0, 0),
(509, 't20', 1663218586, 1, 0, NULL, 0, 0, 0),
(510, 'taco', 1951180813, 1, 0, NULL, 0, 0, 0),
(511, 'tailgater', 3286105550, 1, 0, NULL, 0, 0, 0),
(512, 'tampa', 972671128, 1, 0, NULL, 0, 0, 0),
(513, 'tampa2', 3223586949, 1, 0, NULL, 0, 0, 0),
(514, 'tampa3', 3084515313, 1, 0, NULL, 0, 0, 0),
(515, 'tanker', 3564062519, 1, 0, NULL, 0, 0, 0),
(516, 'tanker2', 1956216962, 1, 0, NULL, 0, 0, 0),
(517, 'tankercar', 586013744, 1, 0, NULL, 0, 0, 0),
(518, 'taxi', 3338918751, 1, 0, NULL, 0, 0, 0),
(519, 'technical', 2198148358, 1, 0, NULL, 0, 0, 0),
(520, 'technical2', 1180875963, 1, 0, NULL, 0, 0, 0),
(521, 'technical3', 1356124575, 1, 0, NULL, 0, 0, 0),
(522, 'tempesta', 272929391, 1, 0, NULL, 0, 0, 0),
(523, 'terbyte', 2306538597, 1, 0, NULL, 0, 0, 0),
(524, 'thrust', 1836027715, 15, 0, 1, 16, 0.56, 1),
(525, 'thruster', 1489874736, 1, 0, NULL, 0, 0, 0),
(526, 'tiptruck', 48339065, 1, 0, 1, 120, 1.99, 1),
(527, 'tiptruck2', 3347205726, 1, 0, NULL, 0, 0, 0),
(528, 'titan', 1981688531, 1, 0, NULL, 0, 0, 0),
(529, 'torero', 1504306544, 1, 0, NULL, 0, 0, 0),
(530, 'tornado', 464687292, 1, 0, NULL, 0, 0, 0),
(531, 'tornado2', 1531094468, 1, 0, NULL, 0, 0, 0),
(532, 'tornado3', 1762279763, 1, 0, NULL, 0, 0, 0),
(533, 'tornado4', 2261744861, 1, 0, NULL, 0, 0, 0),
(534, 'tornado5', 2497353967, 1, 0, NULL, 0, 0, 0),
(535, 'tornado6', 2736567667, 1, 0, NULL, 0, 0, 0),
(536, 'toro', 1070967343, 1, 0, NULL, 0, 0, 0),
(537, 'toro2', 908897389, 1, 0, NULL, 0, 0, 0),
(538, 'toros', 3126015148, 1, 0, NULL, 0, 0, 0),
(539, 'tourbus', 1941029835, 1, 0, NULL, 0, 0, 0),
(540, 'towtruck', 2971866336, 1, 0, 2, 100, 1.8, 0),
(541, 'towtruck2', 3852654278, 1, 0, 2, 100, 1.8, 0),
(542, 'tr2', 2078290630, 1, 0, NULL, 0, 0, 0),
(543, 'tr3', 1784254509, 1, 0, NULL, 0, 0, 0),
(544, 'tr4', 2091594960, 1, 0, NULL, 0, 0, 0),
(545, 'tractor', 1641462412, 1, 0, 1, 20, 2, 1),
(546, 'tractor2', 2218488798, 1, 0, NULL, 0, 0, 0),
(547, 'tractor3', 1445631933, 1, 0, NULL, 0, 0, 0),
(548, 'trailerlogs', 2016027501, 1, 0, NULL, 0, 0, 0),
(549, 'trailers', 3417488910, 1, 0, NULL, 0, 0, 0),
(550, 'trailers2', 2715434129, 1, 0, NULL, 0, 0, 0),
(551, 'trailers3', 2236089197, 1, 0, NULL, 0, 0, 0),
(552, 'trailersmall', 712162987, 1, 0, NULL, 0, 0, 0),
(553, 'trailersmall2', 2413121211, 1, 0, NULL, 0, 0, 0),
(554, 'trash', 1917016601, 1, 0, NULL, 0, 0, 0),
(555, 'trash2', 3039269212, 1, 0, NULL, 0, 0, 0),
(556, 'trflat', 2942498482, 1, 0, NULL, 0, 0, 0),
(557, 'tribike', 1127861609, 1, 0, NULL, 0, 0, 0),
(558, 'tribike2', 3061159916, 1, 0, NULL, 0, 0, 0),
(559, 'tribike3', 3894672200, 1, 0, NULL, 0, 0, 0),
(560, 'trophytruck', 101905590, 1, 0, NULL, 0, 0, 0),
(561, 'trophytruck2', 3631668194, 1, 0, NULL, 0, 0, 0),
(562, 'tropic', 290013743, 1, 0, NULL, 0, 0, 0),
(563, 'tropic2', 1448677353, 1, 0, NULL, 0, 0, 0),
(564, 'tropos', 1887331236, 1, 0, NULL, 0, 0, 0),
(565, 'tug', 2194326579, 1, 0, NULL, 0, 0, 0),
(566, 'tula', 1043222410, 1, 0, NULL, 0, 0, 0),
(567, 'tulip', 1456744817, 1, 0, NULL, 0, 0, 0),
(568, 'turismo2', 3312836369, 1, 0, NULL, 0, 0, 0),
(569, 'turismor', 408192225, 1, 0, NULL, 0, 0, 0),
(570, 'tvtrailer', 2524324030, 1, 0, NULL, 0, 0, 0),
(571, 'tyrus', 2067820283, 1, 0, NULL, 0, 0, 0),
(572, 'utillitruck', 516990260, 1, 0, NULL, 0, 0, 0),
(573, 'utillitruck2', 887537515, 1, 0, NULL, 0, 0, 0),
(574, 'utillitruck3', 2132890591, 1, 0, NULL, 0, 0, 0),
(575, 'vacca', 338562499, 1, 0, NULL, 0, 0, 0),
(576, 'vader', 4154065143, 1, 0, NULL, 0, 0, 0),
(577, 'vagner', 1939284556, 46, 0, 1, 80, 2.2, 1),
(578, 'valkyrie', 2694714877, 1, 0, NULL, 0, 0, 0),
(579, 'valkyrie2', 1543134283, 1, 0, NULL, 0, 0, 0),
(580, 'vamos', 4245851645, 1, 0, NULL, 0, 0, 0),
(581, 'velum', 2621610858, 1, 0, NULL, 0, 0, 0),
(582, 'velum2', 1077420264, 1, 0, NULL, 0, 0, 0),
(583, 'verlierer2', 1102544804, 1, 0, NULL, 0, 0, 0),
(584, 'vestra', 1341619767, 1, 0, NULL, 0, 0, 0),
(585, 'vigero', 3469130167, 1, 0, NULL, 0, 0, 0),
(586, 'vigilante', 3052358707, 1, 0, NULL, 0, 0, 0),
(587, 'vindicator', 2941886209, 1, 0, NULL, 0, 0, 0),
(588, 'virgo', 3796912450, 1, 0, NULL, 0, 0, 0),
(589, 'virgo2', 3395457658, 1, 0, NULL, 0, 0, 0),
(590, 'virgo3', 16646064, 1, 0, NULL, 0, 0, 0),
(591, 'viseris', 3903371924, 1, 0, NULL, 0, 0, 0),
(592, 'visione', 3296789504, 1, 0, NULL, 0, 0, 0),
(593, 'volatol', 447548909, 1, 0, NULL, 0, 0, 0),
(594, 'volatus', 2449479409, 1, 0, NULL, 0, 0, 0),
(595, 'voltic', 2672523198, 1, 0, NULL, 0, 0, 0),
(596, 'voltic2', 989294410, 1, 0, NULL, 0, 0, 0),
(597, 'voodoo', 2006667053, 1, 0, NULL, 0, 0, 0),
(598, 'voodoo2', 523724515, 1, 0, NULL, 0, 0, 0),
(599, 'vortex', 3685342204, 1, 0, NULL, 0, 0, 0),
(600, 'warrener', 1373123368, 1, 0, NULL, 0, 0, 0),
(601, 'washington', 1777363799, 1, 0, NULL, 0, 0, 0),
(602, 'wastelander', 2382949506, 1, 0, NULL, 0, 0, 0),
(603, 'windsor', 1581459400, 1, 0, NULL, 0, 0, 0),
(604, 'windsor2', 2364918497, 1, 0, NULL, 0, 0, 0),
(605, 'wolfsbane', 3676349299, 20, 0, 1, 14, 0.7, 1),
(606, 'xa21', 917809321, 40, 0, NULL, 0, 0, 0),
(607, 'xls', 1203490606, 1, 0, NULL, 0, 0, 0),
(608, 'xls2', 3862958888, 1, 0, NULL, 0, 0, 0),
(609, 'yosemite', 1871995513, 1, 0, NULL, 0, 0, 0),
(610, 'youga', 65402552, 1, 0, 1, 75, 0.88, 1),
(611, 'youga2', 1026149675, 1, 0, NULL, 0, 0, 0),
(612, 'zentorno', 2891838741, 45, 0, 1, 75, 2.3, 1),
(613, 'zion', 3172678083, 1, 0, NULL, 0, 0, 0),
(614, 'zion2', 3101863448, 1, 0, NULL, 0, 0, 0),
(615, 'zombiea', 3285698347, 1, 0, NULL, 0, 0, 0),
(616, 'zombieb', 3724934023, 1, 0, NULL, 0, 0, 0),
(617, 'zr380', 540101442, 1, 0, NULL, 0, 0, 0),
(618, 'zr3802', 3188846534, 1, 0, NULL, 0, 0, 0),
(619, 'zr3803', 2816263004, 1, 0, NULL, 0, 0, 0),
(620, 'ztype', 758895617, 1, 0, NULL, 0, 0, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cfg_vehicles_type`
--

CREATE TABLE `cfg_vehicles_type` (
  `id` tinyint(3) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Daten für Tabelle `cfg_vehicles_type`
--

INSERT INTO `cfg_vehicles_type` (`id`, `name`) VALUES
(1, 'PKW'),
(2, 'LKW'),
(3, 'Boot'),
(4, 'Helikopter'),
(5, 'Flugzeug');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `characters`
--

CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `admin` int(11) NOT NULL DEFAULT 0,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `cash` int(255) NOT NULL,
  `dim` int(11) NOT NULL,
  `last_pos_x` float NOT NULL,
  `last_pos_y` float NOT NULL,
  `last_pos_z` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(1, 'index', 'Startseite', 'homepage', '1', 0),
(2, 'create', 'Charakter erstellen', 'homepage', '1', 0);

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

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `cfg_vehicle_id` int(11) NOT NULL,
  `character_id` int(11) NOT NULL,
  `engine` tinyint(1) NOT NULL,
  `alive` tinyint(1) NOT NULL DEFAULT 1,
  `locked` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `p_x` float NOT NULL,
  `p_y` float NOT NULL,
  `p_z` float NOT NULL,
  `r` float NOT NULL,
  `dim` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `insurance` tinyint(3) NOT NULL DEFAULT 0,
  `c` int(11) NOT NULL DEFAULT 0,
  `c_r` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `c_g` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `c_b` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `s` int(11) NOT NULL DEFAULT 0,
  `s_r` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `s_g` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `s_b` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `hp` float NOT NULL DEFAULT 100,
  `km` float NOT NULL DEFAULT 0,
  `fuel` float NOT NULL DEFAULT 0,
  `last_used` timestamp NOT NULL DEFAULT current_timestamp(),
  `insert` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_owner_change` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
-- Indizes für die Tabelle `cfg_vehicles`
--
ALTER TABLE `cfg_vehicles`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `name` (`name`) USING BTREE,
  ADD KEY `FK_cfg_vehicles_cfg_vehicles_type` (`type`) USING BTREE;

--
-- Indizes für die Tabelle `cfg_vehicles_type`
--
ALTER TABLE `cfg_vehicles_type`
  ADD PRIMARY KEY (`id`) USING BTREE;

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
-- Indizes für die Tabelle `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `accounts_socialclub`
--
ALTER TABLE `accounts_socialclub`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `bans_socialclub`
--
ALTER TABLE `bans_socialclub`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `cfg_vehicles`
--
ALTER TABLE `cfg_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=622;

--
-- AUTO_INCREMENT für Tabelle `cfg_vehicles_type`
--
ALTER TABLE `cfg_vehicles_type`
  MODIFY `id` tinyint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `characters`
--
ALTER TABLE `characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `characters_clothes`
--
ALTER TABLE `characters_clothes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `characters_customization`
--
ALTER TABLE `characters_customization`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `cms_pages`
--
ALTER TABLE `cms_pages`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `house`
--
ALTER TABLE `house`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
