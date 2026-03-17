-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mar. 17 mars 2026 à 17:33
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
-- Doublure de structure pour la vue `v_inventory_details`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `v_inventory_details` (
`product_name` varchar(100)
,`category_name` varchar(100)
,`warehouse_name` varchar(100)
,`current_stock` int(11)
,`unit_price` decimal(10,2)
,`total_value` decimal(20,2)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_low_stock`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `v_low_stock` (
`id_product` int(11)
,`product_name` varchar(100)
,`total_quantity` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_products_details`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `v_products_details` (
`id_product` int(11)
,`product_name` varchar(100)
,`category_name` varchar(100)
,`price` decimal(10,2)
,`volume_unit` int(11)
,`supplier_name` varchar(100)
,`supplier_city` varchar(255)
,`created_at` timestamp
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_warehouse_capacity`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `v_warehouse_capacity` (
`id_warehouse` int(11)
,`warehouse_name` varchar(100)
,`max_capacity` int(11)
,`used_capacity` decimal(42,0)
,`remaining_capacity` decimal(43,0)
);

-- --------------------------------------------------------

--
-- Structure de la vue `v_inventory_details`
--
DROP TABLE IF EXISTS `v_inventory_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_inventory_details`  AS SELECT `p`.`name` AS `product_name`, `c`.`name` AS `category_name`, `w`.`name` AS `warehouse_name`, `ws`.`quantity` AS `current_stock`, `p`.`price` AS `unit_price`, `ws`.`quantity`* `p`.`price` AS `total_value` FROM (((`warehouse_stock` `ws` join `products` `p` on(`ws`.`product` = `p`.`id_product`)) join `categories` `c` on(`p`.`categorie` = `c`.`id_categ`)) join `warehouses` `w` on(`ws`.`warehouse` = `w`.`id_warehouse`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `v_low_stock`
--
DROP TABLE IF EXISTS `v_low_stock`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_low_stock`  AS SELECT `p`.`id_product` AS `id_product`, `p`.`name` AS `product_name`, sum(`ws`.`quantity`) AS `total_quantity` FROM (`products` `p` left join `warehouse_stock` `ws` on(`p`.`id_product` = `ws`.`product`)) GROUP BY `p`.`id_product`, `p`.`name` HAVING `total_quantity` < 5 OR `total_quantity` is null ;

-- --------------------------------------------------------

--
-- Structure de la vue `v_products_details`
--
DROP TABLE IF EXISTS `v_products_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_products_details`  AS SELECT `p`.`id_product` AS `id_product`, `p`.`name` AS `product_name`, `c`.`name` AS `category_name`, `p`.`price` AS `price`, `p`.`volume_unit` AS `volume_unit`, `s`.`name` AS `supplier_name`, `s`.`localisation` AS `supplier_city`, `p`.`created_at` AS `created_at` FROM ((`products` `p` join `categories` `c` on(`p`.`categorie` = `c`.`id_categ`)) join `suppliers` `s` on(`p`.`supplier` = `s`.`id_supplier`)) ;

-- --------------------------------------------------------

--
-- Structure de la vue `v_warehouse_capacity`
--
DROP TABLE IF EXISTS `v_warehouse_capacity`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_warehouse_capacity`  AS SELECT `w`.`id_warehouse` AS `id_warehouse`, `w`.`name` AS `warehouse_name`, `w`.`stockage` AS `max_capacity`, ifnull(sum(`ws`.`quantity` * `p`.`volume_unit`),0) AS `used_capacity`, `w`.`stockage`- ifnull(sum(`ws`.`quantity` * `p`.`volume_unit`),0) AS `remaining_capacity` FROM ((`warehouses` `w` left join `warehouse_stock` `ws` on(`w`.`id_warehouse` = `ws`.`warehouse`)) left join `products` `p` on(`ws`.`product` = `p`.`id_product`)) GROUP BY `w`.`id_warehouse`, `w`.`name`, `w`.`stockage` ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
