-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 04. Apr 2020 um 05:13
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
(1, 1, 'Donald', 'Duck', 45786333, 0, -5.26175, 19.946, 71.1947);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `house`
--
ALTER TABLE `house`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
