-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 04 mars 2024 à 10:21
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `supercar`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetClientsByCarBrand` (IN `carBrand` VARCHAR(50))   BEGIN
 SELECT c.*
 FROM client c
 INNER JOIN demande_essai de ON c.id = de.id_client
 INNER JOIN voiture v ON de.id_voiture = v.id_voiture
 WHERE v.marque COLLATE utf8mb4_general_ci = carBrand COLLATE utf8mb4_general_ci;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `nom_admin` varchar(255) NOT NULL,
  `username_admin` varchar(255) NOT NULL,
  `motdepasse_admin` varchar(255) NOT NULL,
  `acces` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`id_admin`, `nom_admin`, `username_admin`, `motdepasse_admin`, `acces`) VALUES
(1, 'Kim', 'admin', 'admin', 1),
(2, 'admin2', 'admin2', 'admin2*2224', 1);

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `prenom` varchar(128) NOT NULL,
  `telephone` int(11) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `name`, `prenom`, `telephone`, `adresse`, `email`, `password_hash`) VALUES
(3, 'Ratomahenina', 'Kim', 52740595, 'Quatre Bornes', 'kimstevine6@gmail.com', '3333'),
(5, 'Brayan', 'Loïc', 56452047, 'Bassin', 'Bilagnge@gmail.com', '4444'),
(6, 'RATOMAHENINA', 'Dimbihasimbola Stevine Kim', 52740595, '1 Avenue Doyen Quatre-Bornes', 'kimstevine777@gmail.com', 'Azerty11.'),
(9, 'RATOMAHENINA', 'Dimbihasimbola Stevine Kim', 52740595, '1 Avenue Doyen Quatre-Bornes', 'dratomahenina@gmail.com', 'Azerty11');

--
-- Déclencheurs `client`
--
DELIMITER $$
CREATE TRIGGER `after_login_trigger` AFTER INSERT ON `client` FOR EACH ROW BEGIN
    DECLARE user_id INT;
    DECLARE login_date TIMESTAMP;
    -- Récupérer les données de la nouvelle ligne insérée
    SET user_id = NEW.id;
    SET login_date = NOW();
    -- Insérer dans la table du journal
    INSERT INTO `journal_connexion` (`id_utilisateur`, `date_connexion`)
    VALUES (user_id, login_date);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

CREATE TABLE `contact` (
  `id_contact` int(11) NOT NULL,
  `message` text NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_client` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `contact`
--

INSERT INTO `contact` (`id_contact`, `message`, `date_created`, `id_client`) VALUES
(45, 'THIS IS SIMPLE CONTACT', '2023-11-27 06:34:03', 5);

-- --------------------------------------------------------

--
-- Structure de la table `debug_info`
--

CREATE TABLE `debug_info` (
  `id` int(11) NOT NULL,
  `message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `demande_essai`
--

CREATE TABLE `demande_essai` (
  `id_demande` int(11) NOT NULL,
  `id_voiture` int(11) NOT NULL,
  `date_debut` date NOT NULL,
  `heure` time NOT NULL,
  `commentaire` text DEFAULT NULL,
  `id_client` int(11) DEFAULT NULL,
  `statut` varchar(20) DEFAULT 'En cours'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `demande_essai`
--

INSERT INTO `demande_essai` (`id_demande`, `id_voiture`, `date_debut`, `heure`, `commentaire`, `id_client`, `statut`) VALUES
(2, 8, '2023-05-23', '10:00:00', 'Bonjour, ', 3, 'Validé'),
(5, 4, '2023-09-29', '10:30:00', 'cc', 3, 'En cours'),
(6, 1, '2023-09-28', '13:00:00', 'Appelez au moment de la livraison', 3, 'Validé'),
(11, 4, '2023-09-30', '12:00:00', 'Test', 3, 'Validé'),
(16, 10, '2023-10-18', '14:00:00', 'RAS', 5, 'En cours'),
(17, 5, '2024-01-18', '12:40:00', 'Je voudrais passer un essai pour cette voiture', 5, 'En cours'),
(18, 2, '2023-11-23', '13:12:00', 'Je voudrais essayer celle ci', 5, 'En cours'),
(19, 4, '2023-11-24', '16:19:00', 'et celle ci aussi', 5, 'En cours'),
(22, 3, '2023-11-29', '14:32:00', 'IO', 5, 'En cours'),
(23, 10, '2023-12-12', '12:15:00', 'Wesh', 3, 'En cours');

-- --------------------------------------------------------

--
-- Structure de la table `evenements`
--

CREATE TABLE `evenements` (
  `id_evenements` int(11) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `heure` time NOT NULL,
  `image` varchar(255) NOT NULL,
  `details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `evenements`
--

INSERT INTO `evenements` (`id_evenements`, `titre`, `type`, `date`, `heure`, `image`, `details`) VALUES
(1, 'Journée portes ouvertes', 'Exposition de Voitures', '2023-11-15', '10:00:00', 'supercar-showroom.jpg', 'Une journée spéciale pour découvrir les derniers modèles de voitures. Vous aurez l\'opportunité d\'essayer différentes voitures et de discuter avec nos experts sur les caractéristiques avancées de nos véhicules.'),
(2, 'Lancement de la nouvelle gamme de TESLA', 'Lancement de Produit', '2023-12-10', '19:00:00', 'NouveauTesla.jpg', 'Soirée de lancement pour notre nouvelle gamme pour essai automobile, de la marque \"TESLA\". Soyez parmi les premiers à découvrir ses caractéristiques révolutionnaires et de pouvoir la demander en essai.'),
(3, 'Concours de Photographie', 'Concours', '2023-12-31', '14:30:00', 'Concours.jpg', 'Participez à notre concours de photographie automobile. Capturez la beauté de nos voitures et gagnez des prix incroyables, y compris un week-end de rêve en voiture.'),
(4, 'Séminaire sur la Sécurité Routière', 'Éducation Routière', '2024-01-15', '09:30:00', 'Séminaire.jpg', 'Apprenez à conduire en toute sécurité lors de notre séminaire de deux jours. Les experts en sécurité routière vous enseigneront les règles de la route, la prévention des accidents et les techniques de conduite sûre.');

-- --------------------------------------------------------

--
-- Structure de la table `journal_connexion`
--

CREATE TABLE `journal_connexion` (
  `id` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `date_connexion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `marque`
--

CREATE TABLE `marque` (
  `id_marque` int(11) NOT NULL,
  `nom_marque` varchar(255) NOT NULL,
  `logo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `marque`
--

INSERT INTO `marque` (`id_marque`, `nom_marque`, `logo`) VALUES
(1, 'AUDI', 'AUDI.png'),
(2, 'BENTLEY', 'BENTLEY.png'),
(3, 'BMW', 'BMW.png'),
(4, 'FERRARI', 'FERRARI.png'),
(5, 'LAMBORGHINI', 'LAMBORGHINI.png'),
(6, 'MERCEDES-BENZ', 'MERCEDES-BENZ.png'),
(7, 'PORSCHE', 'PORSCHE.png');

-- --------------------------------------------------------

--
-- Structure de la table `voiture`
--

CREATE TABLE `voiture` (
  `id_voiture` int(11) NOT NULL,
  `marque` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `modele` varchar(50) NOT NULL,
  `annee` int(11) NOT NULL,
  `image1` varchar(255) NOT NULL,
  `image2` varchar(255) NOT NULL,
  `image3` varchar(255) NOT NULL,
  `image4` varchar(255) NOT NULL,
  `description` varchar(2000) NOT NULL,
  `prix` int(11) NOT NULL DEFAULT 0,
  `rating` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `voiture`
--

INSERT INTO `voiture` (`id_voiture`, `marque`, `type`, `modele`, `annee`, `image1`, `image2`, `image3`, `image4`, `description`, `prix`, `rating`) VALUES
(1, 'AUDI', 'Berline', 'RS7 SPORTBACK', 2013, '651b3b3b6b577.png', '651b3b3b7b8c1.jpg', '651b3b3b83514.jpg', '651b3b3b89314.jpg', '<ul>\r\n  <li>Moteur : V8 biturbo de 4,0 litres</li>\r\n  <li>Puissance : 600 chevaux</li>\r\n  <li>Couple : 800 Nm</li>\r\n  <li>Transmission : Quattro (transmission intégrale)</li>\r\n  <li>Accélération : 0 à 100 km/h en 3,6 secondes</li>\r\n  <li>Vitesse maximale : 305 km/h</li>\r\n  <li>Freins : Freins en céramique</li>\r\n  <li>Suspension : Suspension pneumatique adaptative</li>\r\n  <li>Intérieur : Sièges sport en cuir, système audio Bang & Olufsen, écran tactile MMI</li>\r\n</ul>', 625000, 4),
(2, 'AUDI', 'Coupé', 'R8', 2019, '651b3b5c8229f.jpg', '651b3b5c94a7e.jpg', '651b3b5c9bf0b.jpg', '651b3b5ca48b3.jpg', '<ul>\r\n  <li>Moteur : V10 de 5,2 litres</li>\r\n  <li>Puissance : jusqu\'à 602 chevaux</li>\r\n  <li>Couple : jusqu\'à 560 Nm</li>\r\n  <li>Transmission : Quattro (transmission intégrale)</li>\r\n  <li>Accélération : 0 à 100 km/h en 3,2 secondes</li>\r\n  <li>Vitesse maximale : 330 km/h</li>\r\n  <li>Freins : Freins en céramique</li>\r\n  <li>Suspension : Suspension magnétique adaptative</li>\r\n  <li>Intérieur : Sièges sport en cuir, système audio Bang & Olufsen, Virtual Cockpit d\'Audi</li>\r\n</ul>', 867188, 5),
(3, 'AUDI', 'Berline', 'S8 PLUS', 2020, '651b3ccaaee9c.jpg', '651b3ccabd67e.jpg', '651b3ccac53ce.jpg', '651b3ccae3510.jpg', '<ul>\r\n  <li>Moteur : V8 biturbo de 4,0 litres</li>\r\n  <li>Puissance : 605 chevaux</li>\r\n  <li>Couple : 750 Nm</li>\r\n  <li>Transmission : Quattro (transmission intégrale)</li>\r\n  <li>Accélération : 0 à 100 km/h en 3,8 secondes</li>\r\n  <li>Vitesse maximale : 305 km/h</li>\r\n  <li>Freins : Freins en céramique</li>\r\n  <li>Suspension : Suspension pneumatique adaptative</li>\r\n  <li>Intérieur : Sièges sport en cuir, système audio Bang & Olufsen, écran tactile MMI</li>\r\n</ul>', 4112500, 3),
(4, 'AUDI', 'SUV', 'Q5', 2021, '651b3cec46e09.jpg', '651b3cec56225.jpg', '651b3cec5bb6c.jpg', '651b3cec61078.jpg', '<ul>\r\n  <li>Moteur : 4 cylindres en ligne de 2,0 litres ou V6 de 3,0 litres</li>\r\n  <li>Puissance : jusqu\'à 362 chevaux pour le modèle SQ5</li>\r\n  <li>Couple : jusqu\'à 500 Nm pour le modèle SQ5</li>\r\n  <li>Transmission : Quattro (transmission intégrale)</li>\r\n  <li>Accélération : 0 à 100 km/h en 5,8 secondes pour le modèle SQ5</li>\r\n  <li>Vitesse maximale : 250 km/h pour le modèle SQ5</li>\r\n  <li>Freins : Freins à disque ventilés</li>\r\n  <li>Suspension : Suspension sport ou suspension pneumatique adaptative en option</li>\r\n  <li>Intérieur : Sièges en cuir, système audio Bang & Olufsen en option, écran tactile MMI</li>\r\n</ul>', 3112147, 4),
(5, 'BENTLEY', 'Coupé', 'Continental GT', 2021, '651b3d1e14cfa.jpg', '651b3d1e2ae06.jpg', '651b3d1e35edc.jpg', '651b3d1e40589.jpg', '<ul>\r\n  <li>Moteur : W12 biturbo de 6,0 litres</li>\r\n  <li>Puissance : 626 chevaux</li>\r\n  <li>Couple : 900 Nm</li>\r\n  <li>Transmission : Automatique à 8 vitesses</li>\r\n  <li>Accélération : 0 à 100 km/h en 3,7 secondes</li>\r\n  <li>Vitesse maximale : 333 km/h</li>\r\n  <li>Freins : Freins en céramique</li>\r\n  <li>Suspension : Suspension pneumatique adaptative</li>\r\n  <li>Intérieur : Sièges en cuir, système audio Naim, écran tactile MMI</li>\r\n</ul>', 17000000, 5),
(6, 'BENTLEY', 'SUV', 'Bentayga', 2021, '651b3d41cdc23.jpg', '651b3d41dacb6.jpg', '651b3d41e0373.jpg', '651b3d41e583a.jpg', '<ul>\r\n  <li>Moteur : W12 biturbo de 6,0 litres ou V8 biturbo de 4,0 litres</li>\r\n  <li>Puissance : jusqu\'à 626 chevaux pour le modèle W12</li>\r\n  <li>Couple : jusqu\'à 900 Nm pour le modèle W12</li>\r\n  <li>Transmission : Automatique à 8 vitesses</li>\r\n  <li>Accélération : 0 à 100 km/h en 3,9 secondes pour le modèle W12</li>\r\n  <li>Vitesse maximale : 301 km/h pour le modèle W12</li>\r\n  <li>Freins : Freins en céramique en option</li>\r\n  <li>Suspension : Suspension pneumatique adaptative</li>\r\n  <li>Intérieur : Sièges en cuir, système audio Naim, écran tactile MMI</li>\r\n</ul>', 7936680, 3),
(7, 'BENTLEY', 'Berline', 'Flying Spur', 2021, '651b3d5d15ac3.jpg', '651b3d5d2d640.jpg', '651b3d5d32aca.jpg', '651b3d5d38eb4.jpg', '<ul>\r\n  <li>Moteur : W12 biturbo de 6,0 litres</li>\r\n  <li>Puissance : 626 chevaux</li>\r\n  <li>Couple : 900 Nm</li>\r\n  <li>Transmission : Automatique à 8 vitesses</li>\r\n  <li>Accélération : 0 à 100 km/h en 3,8 secondes</li>\r\n  <li>Vitesse maximale : 333 km/h</li>\r\n  <li>Freins : Freins en céramique en option</li>\r\n  <li>Suspension : Suspension pneumatique adaptative</li>\r\n  <li>Intérieur : Sièges en cuir, système audio Naim, écran tactile MMI</li>\r\n</ul>', 10093500, 4),
(8, 'BENTLEY', 'Limousine', 'Mulsanne', 2021, '651b38452f3f9.jpg', '651b3adf8e4e8.jpg', '651b3adf9ea6c.jpg', '651b3adfa46b3.jpg', '<ul>\r\n  <li>Moteur : W12 biturbo de 6,0 litres</li>\r\n  <li>Puissance : 626 chevaux</li>\r\n  <li>Couple : 900 Nm</li>\r\n  <li>Transmission : Automatique à 8 vitesses</li>\r\n  <li>Accélération : 0 à 100 km/h en 3,8 secondes</li>\r\n  <li>Vitesse maximale : 333 km/h</li>\r\n  <li>Freins : Freins en céramique en option</li>\r\n  <li>Suspension : Suspension pneumatique adaptative</li>\r\n  <li>Intérieur : Sièges en cuir, système audio Naim, écran tactile MMI</li>\r\n</ul>', 13936272, 3),
(10, 'BMW', 'Berline', 'Série 7', 2020, '651b44840c739.jpg', '651b44840c9d3.jpg', '651b448410040.jpg', '6523c2b594b83.jpg', 'Pour 2020, la grande berline de BMW s’offre de légers changements esthétiques ainsi qu’une bonification de l’équipement technologique et l’ajout d’une conduite semi-autonome. Le choix de motorisations varie d’une hybride rechargeable de 389 chevaux à un V12 biturbo de 6,0 litres produisant 600 chevaux, et la transmission intégrale figure de série dans tous les cas. L’habitacle luxueux mise sur une riche sélection de boiseries, de cuirs et de garnitures, que l’on peut rehausser en optant pour l’ensemble BMW Individual.', 5777207, 4);

--
-- Déclencheurs `voiture`
--
DELIMITER $$
CREATE TRIGGER `before_update_prix_trigger` BEFORE UPDATE ON `voiture` FOR EACH ROW BEGIN
    -- Calculer le nouveau prix après la mise à jour
    DECLARE new_price DECIMAL(10, 2);
    SET new_price = COALESCE(NEW.prix, 0); -- Gestion des valeurs NULL ou initiales à 0
    -- Afficher des messages de débogage
    INSERT INTO DEBUG_INFO(message) VALUES (CONCAT('new_price avant la vérification : ', CAST(new_price AS CHAR)));
 
    -- Vérifier si l'augmentation de prix dépasse 25%
    IF COALESCE(new_price, 0) > COALESCE(OLD.prix, 0) * 1.25 THEN
        -- Définir le prix pour qu'il n'augmente pas de plus de 25%
        SET new_price = COALESCE(OLD.prix, 0) * 1.25;
 
        -- Set a session variable to indicate that the price has been adjusted
        SET @price_adjusted = 1;
    ELSE
        -- Set the session variable to 0 if no adjustment is made
        SET @price_adjusted = 0;
    END IF;
 
    -- Afficher des messages de débogage
    INSERT INTO DEBUG_INFO(message) VALUES (CONCAT('new_price après la vérification : ', CAST(new_price AS CHAR)));
 
    -- Mettre à jour la colonne prix
    SET NEW.prix = new_price;
END
$$
DELIMITER ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id_contact`),
  ADD KEY `id_client` (`id_client`);

--
-- Index pour la table `debug_info`
--
ALTER TABLE `debug_info`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `demande_essai`
--
ALTER TABLE `demande_essai`
  ADD PRIMARY KEY (`id_demande`),
  ADD KEY `id_voiture` (`id_voiture`),
  ADD KEY `fk_contact_client` (`id_client`);

--
-- Index pour la table `evenements`
--
ALTER TABLE `evenements`
  ADD PRIMARY KEY (`id_evenements`);

--
-- Index pour la table `journal_connexion`
--
ALTER TABLE `journal_connexion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `marque`
--
ALTER TABLE `marque`
  ADD PRIMARY KEY (`id_marque`);

--
-- Index pour la table `voiture`
--
ALTER TABLE `voiture`
  ADD PRIMARY KEY (`id_voiture`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `contact`
--
ALTER TABLE `contact`
  MODIFY `id_contact` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT pour la table `debug_info`
--
ALTER TABLE `debug_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `demande_essai`
--
ALTER TABLE `demande_essai`
  MODIFY `id_demande` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `evenements`
--
ALTER TABLE `evenements`
  MODIFY `id_evenements` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `journal_connexion`
--
ALTER TABLE `journal_connexion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `marque`
--
ALTER TABLE `marque`
  MODIFY `id_marque` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `voiture`
--
ALTER TABLE `voiture`
  MODIFY `id_voiture` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `contact`
--
ALTER TABLE `contact`
  ADD CONSTRAINT `contact_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `client` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `demande_essai`
--
ALTER TABLE `demande_essai`
  ADD CONSTRAINT `fk_contact_client` FOREIGN KEY (`id_client`) REFERENCES `client` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_demande_essai_voiture` FOREIGN KEY (`id_voiture`) REFERENCES `voiture` (`id_voiture`) ON DELETE CASCADE;

--
-- Contraintes pour la table `journal_connexion`
--
ALTER TABLE `journal_connexion`
  ADD CONSTRAINT `fk_id_utilisateur` FOREIGN KEY (`id_utilisateur`) REFERENCES `client` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
