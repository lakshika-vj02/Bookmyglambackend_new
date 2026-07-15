-- ============================================================
--  BookMyGlam — Complete MySQL Database Schema
--  Database : bookmyglam
--  Generated from source-code analysis
-- ============================================================

CREATE DATABASE IF NOT EXISTS `bookmyglam`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `bookmyglam`;

-- ============================================================
-- TABLE 1: users
-- Auth: login / signup  (authService.js)
-- Fields: name, email, password, gender, phone_no, role
-- ============================================================
CREATE TABLE IF NOT EXISTS `users` (
  `id`         INT            NOT NULL AUTO_INCREMENT,
  `name`       VARCHAR(100)   NOT NULL,
  `email`      VARCHAR(150)   NOT NULL UNIQUE,
  `password`   VARCHAR(255)   NOT NULL,
  `gender`     VARCHAR(20)    NOT NULL,
  `phone_no`   VARCHAR(20)    NOT NULL,
  `role`       ENUM('user','artist','admin') NOT NULL DEFAULT 'user',
  `created_at` TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABLE 2: services
-- serviceController.js → SELECT * FROM services WHERE category = ?
-- Fields: id, name, description, category, price, image, duration
-- ============================================================
CREATE TABLE IF NOT EXISTS `services` (
  `id`          INT            NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(150)   NOT NULL,
  `description` TEXT,
  `category`    VARCHAR(100)   NOT NULL,
  `price`       DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
  `image`       VARCHAR(255),
  `duration`    INT            COMMENT 'Duration in minutes',
  `active`      TINYINT(1)     NOT NULL DEFAULT 1,
  `created_at`  TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_services_category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABLE 3: artists
-- artistRoutes.js → SELECT * FROM artists
-- Fields: id, name, email, phone, gender, specialty, bio,
--         profile_image, rating, experience_years, active
-- ============================================================
CREATE TABLE IF NOT EXISTS `artists` (
  `id`               INT           NOT NULL AUTO_INCREMENT,
  `name`             VARCHAR(100)  NOT NULL,
  `email`            VARCHAR(150)  UNIQUE,
  `phone`            VARCHAR(20),
  `gender`           VARCHAR(20),
  `specialty`        VARCHAR(150)  COMMENT 'e.g. Bridal Makeup, Hair Styling',
  `bio`              TEXT,
  `profile_image`    VARCHAR(255),
  `rating`           DECIMAL(3,2)  DEFAULT 0.00,
  `experience_years` INT           DEFAULT 0,
  `user_id`          INT           COMMENT 'FK → users.id (if artist has login)',
  `active`           TINYINT(1)    NOT NULL DEFAULT 1,
  `created_at`       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_artists_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABLE 4: bookings
-- Core booking table (user books a service with an artist)
-- ============================================================
CREATE TABLE IF NOT EXISTS `bookings` (
  `id`           INT            NOT NULL AUTO_INCREMENT,
  `user_id`      INT            NOT NULL COMMENT 'FK → users.id',
  `artist_id`    INT                     COMMENT 'FK → artists.id',
  `service_id`   INT            NOT NULL COMMENT 'FK → services.id',
  `booking_date` DATE           NOT NULL,
  `time_slot`    VARCHAR(20)             COMMENT 'e.g. 10:00 AM',
  `address`      TEXT                    COMMENT 'Home/location address',
  `status`       ENUM('pending','confirmed','completed','cancelled') NOT NULL DEFAULT 'pending',
  `total_price`  DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
  `notes`        TEXT,
  `created_at`   TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at`   TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_bookings_user_id`    (`user_id`),
  INDEX `idx_bookings_artist_id`  (`artist_id`),
  INDEX `idx_bookings_service_id` (`service_id`),
  INDEX `idx_bookings_date`       (`booking_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABLE 5: reviews
-- User reviews/ratings for artists/services
-- ============================================================
CREATE TABLE IF NOT EXISTS `reviews` (
  `id`          INT        NOT NULL AUTO_INCREMENT,
  `user_id`     INT        NOT NULL COMMENT 'FK → users.id',
  `artist_id`   INT                 COMMENT 'FK → artists.id',
  `service_id`  INT                 COMMENT 'FK → services.id',
  `booking_id`  INT                 COMMENT 'FK → bookings.id',
  `rating`      TINYINT    NOT NULL DEFAULT 5 COMMENT '1 to 5 stars',
  `comment`     TEXT,
  `created_at`  TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_reviews_user_id`   (`user_id`),
  INDEX `idx_reviews_artist_id` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABLE 6: categories
-- Service categories shown in frontend filter
-- ============================================================
CREATE TABLE IF NOT EXISTS `categories` (
  `id`          INT           NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(100)  NOT NULL UNIQUE,
  `description` TEXT,
  `image`       VARCHAR(255),
  `active`      TINYINT(1)    NOT NULL DEFAULT 1,
  `created_at`  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABLE 7: artist_services
-- Many-to-many: which artist offers which service
-- ============================================================
CREATE TABLE IF NOT EXISTS `artist_services` (
  `id`         INT  NOT NULL AUTO_INCREMENT,
  `artist_id`  INT  NOT NULL COMMENT 'FK → artists.id',
  `service_id` INT  NOT NULL COMMENT 'FK → services.id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_artist_service` (`artist_id`, `service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- TABLE 8: payments
-- Payment records for bookings
-- ============================================================
CREATE TABLE IF NOT EXISTS `payments` (
  `id`             INT            NOT NULL AUTO_INCREMENT,
  `booking_id`     INT            NOT NULL COMMENT 'FK → bookings.id',
  `user_id`        INT            NOT NULL COMMENT 'FK → users.id',
  `amount`         DECIMAL(10,2)  NOT NULL,
  `payment_mode`   ENUM('cash','online','card','upi') NOT NULL DEFAULT 'online',
  `payment_status` ENUM('pending','success','failed','refunded') NOT NULL DEFAULT 'pending',
  `transaction_id` VARCHAR(200),
  `paid_at`        TIMESTAMP      NULL DEFAULT NULL,
  `created_at`     TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_payments_booking_id` (`booking_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ============================================================
-- SEED DATA — with correct image paths
-- ============================================================

-- Default Admin User
INSERT INTO `users` (`name`, `email`, `password`, `gender`, `phone_no`, `role`)
VALUES ('Admin', 'admin@bookmyglam.com', 'admin123', 'male', '9999999999', 'admin');

-- Sample Categories
INSERT INTO `categories` (`name`, `description`) VALUES
  ('Bridal Makeup',  'Complete bridal makeup packages'),
  ('Hair Styling',   'Haircut, coloring, and styling'),
  ('Skin Care',      'Facials, cleanups, and skin treatments'),
  ('Nail Art',       'Manicure, pedicure, and nail art'),
  ('Mehendi',        'Bridal and festive mehendi designs'),
  ('Waxing',         'Full body and threading services');

-- ✅ Services WITH actual image filenames (from /images folder in backend)
INSERT INTO `services` (`name`, `description`, `category`, `price`, `image`, `duration`) VALUES
  ('Bridal Makeup',       'HD Bridal Makeup with trial',      'Bridal Makeup', 8000.00, 'bridal.jpg',       180),
  ('Party Makeup',        'Glam party makeup look',           'Bridal Makeup', 2500.00, 'party.jpg',         90),
  ('HD Makeup',           'High definition flawless makeup',  'Bridal Makeup', 3500.00, 'hd.jpg',            60),
  ('Hair Cut & Styling',  'Haircut with blow dry',            'Hair Styling',   800.00, 'hair.jpg',          45),
  ('Hair Color',          'Full head global hair coloring',   'Hair Styling',  3000.00, 'haircolor.jpg',    120),
  ('Hair Straightening',  'Permanent hair straightening',     'Hair Styling',  4000.00, 'hairstraight.jpg', 150),
  ('Facial',              'Deep cleansing facial',            'Skin Care',     1200.00, NULL,                60),
  ('Manicure - French',   'Classic french manicure',         'Nail Art',       600.00, 'french.jpg',        45),
  ('Manicure - Gel',      'Long lasting gel nail polish',    'Nail Art',       800.00, 'gel.jpg',            60),
  ('Nail Art - Gold',     'Premium gold nail art designs',   'Nail Art',      1200.00, 'Nail Gold Designs.jpg', 75),
  ('Bridal Mehendi',      'Full hands bridal mehendi',       'Mehendi',       3500.00, NULL,                120),
  ('Waxing - Full Body',  'Full body chocolate waxing',      'Waxing',        1500.00, NULL,                 90);

-- ✅ Artists WITH actual image filenames (from /images folder in backend)
INSERT INTO `artists` (`name`, `email`, `phone`, `gender`, `specialty`, `profile_image`, `experience_years`, `rating`) VALUES
  ('Priya Sharma',   'priya@bookmyglam.com',   '9876543210', 'female', 'Bridal Makeup',  'artist1.jpg', 5, 4.80),
  ('Neha Kapoor',    'neha@bookmyglam.com',    '9876543211', 'female', 'Hair Styling',   'artist2.jpg', 7, 4.70),
  ('Anjali Singh',   'anjali@bookmyglam.com',  '9876543212', 'female', 'Skin Care',      'artist3.jpg', 4, 4.60),
  ('Pooja Mehta',    'pooja@bookmyglam.com',   '9876543213', 'female', 'Nail Art',       'artist4.jpg', 3, 4.50),
  ('Ritika Gupta',   'ritika@bookmyglam.com',  '9876543214', 'female', 'Mehendi',        'artist5.jpg', 6, 4.90),
  ('Simran Kaur',    'simran@bookmyglam.com',  '9876543215', 'female', 'Bridal Makeup',  'artist6.jpg', 8, 4.75);


-- ✅ Artist–Service Mappings
-- Services IDs: 1=Bridal Makeup, 2=Party Makeup, 3=HD Makeup,
--               4=Hair Cut, 5=Hair Color, 6=Hair Straightening,
--               7=Facial, 8=Manicure-French, 9=Manicure-Gel,
--              10=Nail Gold, 11=Bridal Mehendi, 12=Waxing
-- Artists IDs: 1=Priya(Bridal), 2=Neha(Hair), 3=Anjali(Skin),
--              4=Pooja(Nail), 5=Ritika(Mehendi), 6=Simran(Bridal)
INSERT IGNORE INTO `artist_services` (`artist_id`, `service_id`) VALUES
  -- Priya Sharma — Bridal Makeup specialist
  (1, 1), (1, 2), (1, 3),
  -- Neha Kapoor — Hair Styling specialist
  (2, 4), (2, 5), (2, 6),
  -- Anjali Singh — Skin Care specialist
  (3, 7), (3, 2), (3, 3),
  -- Pooja Mehta — Nail Art specialist
  (4, 8), (4, 9), (4, 10),
  -- Ritika Gupta — Mehendi specialist
  (5, 11), (5, 1),
  -- Simran Kaur — Bridal Makeup specialist
  (6, 1), (6, 2), (6, 3), (6, 7);

-- ============================================================
-- TABLE 9: service_subcategory
-- Each service (like Bridal Makeup) has multiple subcategories
-- ============================================================
CREATE TABLE IF NOT EXISTS `service_subcategory` (
  `id`               INT            NOT NULL AUTO_INCREMENT,
  `service_id`       INT            NOT NULL COMMENT 'FK → services.id',
  `subcategory_name` VARCHAR(150)   NOT NULL,
  `description`      TEXT,
  `price`            DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
  `image`            VARCHAR(255),
  `duration`         INT            COMMENT 'Duration in minutes',
  `active`           TINYINT(1)     NOT NULL DEFAULT 1,
  `created_at`       TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_ssc_service_id` (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ✅ service_subcategory SEED DATA
-- service_id 1 = Bridal Makeup
INSERT INTO `service_subcategory` (`service_id`, `subcategory_name`, `description`, `price`, `image`, `duration`) VALUES
  (1, 'HD Bridal Makeup',       'High definition airbrush bridal makeup',  12000.00, 'bridal.jpg',   240),
  (1, 'Airbrush Bridal Makeup', 'Long lasting airbrush makeup for brides',  9000.00, 'bridal.jpg',   180),
  (1, 'Party Makeup',           'Glam party makeup look',                   2500.00, 'party.jpg',     90),
  (1, 'HD Makeup',              'High definition flawless makeup',           3500.00, 'hd.jpg',        60);

-- service_id 2 = Party Makeup (sub-options)
INSERT INTO `service_subcategory` (`service_id`, `subcategory_name`, `description`, `price`, `image`, `duration`) VALUES
  (2, 'Cocktail Party Makeup',  'Bold and glamorous cocktail look',          3000.00, 'party.jpg',     60),
  (2, 'Reception Makeup',       'Elegant reception evening look',            3500.00, 'party.jpg',     75);

-- service_id 3 = HD Makeup
INSERT INTO `service_subcategory` (`service_id`, `subcategory_name`, `description`, `price`, `image`, `duration`) VALUES
  (3, 'HD Camera Makeup',       'Perfect for photography and video shoots',  4000.00, 'hd.jpg',        60),
  (3, 'HD Engagement Makeup',   'Flawless HD makeup for engagement ceremony',3500.00, 'hd.jpg',        75);

-- service_id 4 = Hair Styling
INSERT INTO `service_subcategory` (`service_id`, `subcategory_name`, `description`, `price`, `image`, `duration`) VALUES
  (4, 'Haircut & Blow Dry',     'Precision haircut with blow dry finish',     800.00, 'hair.jpg',      45),
  (4, 'Keratin Treatment',      'Smooth and frizz-free hair treatment',      5000.00, 'hair.jpg',     120);

-- service_id 5 = Hair Color
INSERT INTO `service_subcategory` (`service_id`, `subcategory_name`, `description`, `price`, `image`, `duration`) VALUES
  (5, 'Global Hair Color',      'Full head single color application',        3000.00, 'haircolor.jpg', 120),
  (5, 'Highlights & Balayage',  'Natural sun-kissed highlights',             4500.00, 'haircolor.jpg', 150),
  (5, 'Ombre Color',            'Gradient color from root to tip',           4000.00, 'haircolor.jpg', 135);

-- service_id 8 = Manicure French
INSERT INTO `service_subcategory` (`service_id`, `subcategory_name`, `description`, `price`, `image`, `duration`) VALUES
  (8, 'Classic French Manicure','Traditional white tip french manicure',      600.00, 'french.jpg',    45),
  (8, 'French Pedicure',        'French pedicure with foot massage',          800.00, 'french.jpg',    60);

-- service_id 9 = Manicure Gel
INSERT INTO `service_subcategory` (`service_id`, `subcategory_name`, `description`, `price`, `image`, `duration`) VALUES
  (9, 'Gel Manicure',           'Long lasting gel nail polish',               800.00, 'gel.jpg',       60),
  (9, 'Gel Pedicure',           'Gel polish pedicure with spa treatment',    1000.00, 'gel.jpg',       75);

-- ============================================================
-- END OF SCHEMA
-- ============================================================
