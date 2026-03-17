-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mar. 17 mars 2026 à 14:26
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestock_db`
--
CREATE DATABASE IF NOT EXISTS `gestock_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `gestock_db`;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id_categ` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_categ`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `id_product` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `categorie` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `volume_unit` int(11) NOT NULL,
  `supplier` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_product`),
  KEY `fk_products_categories` (`categorie`),
  KEY `fk_products_suppliers` (`supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `stock_movements`
--

CREATE TABLE IF NOT EXISTS `stock_movements` (
  `id_movement` int(11) NOT NULL AUTO_INCREMENT,
  `product` int(11) NOT NULL,
  `warehouse` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `type` enum('INCOME','OUTCOME') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_movement`),
  KEY `fk_sm_warehouses` (`warehouse`),
  KEY `fk_sm_products` (`product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `suppliers`
--

CREATE TABLE IF NOT EXISTS `suppliers` (
  `id_supplier` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `localisation` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `warehouses`
--

CREATE TABLE IF NOT EXISTS `warehouses` (
  `id_warehouse` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `localisation` varchar(255) NOT NULL,
  `stockage` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_warehouse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `warehouse_stock`
--

CREATE TABLE IF NOT EXISTS `warehouse_stock` (
  `id_wh_stock` int(11) NOT NULL AUTO_INCREMENT,
  `warehouse` int(11) NOT NULL,
  `product` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_wh_stock`),
  KEY `fk_wh_stock_products` (`product`),
  KEY `fk_wh_stock_categories` (`warehouse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_categories` FOREIGN KEY (`categorie`) REFERENCES `categories` (`id_categ`),
  ADD CONSTRAINT `fk_products_suppliers` FOREIGN KEY (`supplier`) REFERENCES `suppliers` (`id_supplier`);

--
-- Contraintes pour la table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD CONSTRAINT `fk_sm_products` FOREIGN KEY (`product`) REFERENCES `products` (`id_product`),
  ADD CONSTRAINT `fk_sm_warehouses` FOREIGN KEY (`warehouse`) REFERENCES `warehouses` (`id_warehouse`);

--
-- Contraintes pour la table `warehouse_stock`
--
ALTER TABLE `warehouse_stock`
  ADD CONSTRAINT `fk_wh_stock_categories` FOREIGN KEY (`warehouse`) REFERENCES `warehouses` (`id_warehouse`),
  ADD CONSTRAINT `fk_wh_stock_products` FOREIGN KEY (`product`) REFERENCES `products` (`id_product`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
