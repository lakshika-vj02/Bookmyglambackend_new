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
  `base_price`       DECIMAL(10,2) DEFAULT 0.00 COMMENT 'Artist custom starting price',
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
VALUES ('Admin', 'admin5@bookmyglam.com', 'admin123', 'male', '9999999999', 'admin');

-- 4 Main Service Categories
INSERT INTO `categories` (`name`, `description`) VALUES
  ('Hair',     'Haircut, coloring, keratin and all hair services'),
  ('Nail',     'Manicure, pedicure, nail art and gel services'),
  ('Skincare', 'Facials, cleanups, tan removal and skin treatments'),
  ('Makeup',   'Bridal, party, HD and airbrush makeup services');

-- ✅ 4 Main Services (one per category)
INSERT INTO `services` (`name`, `description`, `category`, `price`, `image`, `duration`) VALUES
  ('Hair',     'Complete hair care — haircut, color, keratin and more',     'Hair',     800.00,  'hair.jpg',    45),
  ('Nail',     'Manicure, pedicure, gel nails and nail art services',       'Nail',     400.00,  'gel.jpg',     30),
  ('Skincare', 'Facials, tan removal, bleach and skin care treatments',     'Skincare', 1200.00, NULL,          60),
  ('Makeup',   'Bridal, party, HD and airbrush professional makeup looks',  'Makeup',   2500.00, 'bridal.jpg',  90);

-- ✅ Artists WITH actual image filenames (from /images folder in backend)
INSERT INTO `artists` (`name`, `email`, `phone`, `gender`, `specialty`, `profile_image`, `experience_years`, `rating`) VALUES
  ('Priya Sharma',   'priya@bookmyglam.com',   '9876543210', 'female', 'Makeup',   'artist1.jpg', 5, 4.80),
  ('Neha Kapoor',    'neha@bookmyglam.com',    '9876543211', 'female', 'Hair',     'artist2.jpg', 7, 4.70),
  ('Anjali Singh',   'anjali@bookmyglam.com',  '9876543212', 'female', 'Skincare', 'artist3.jpg', 4, 4.60),
  ('Pooja Mehta',    'pooja@bookmyglam.com',   '9876543213', 'female', 'Nail',     'artist4.jpg', 3, 4.50),
  ('Ritika Gupta',   'ritika@bookmyglam.com',  '9876543214', 'female', 'Makeup',   'artist5.jpg', 6, 4.90),
  ('Simran Kaur',    'simran@bookmyglam.com',  '9876543215', 'female', 'Hair',     'artist6.jpg', 8, 4.75);


-- ✅ Artist–Service Mappings (service_id: 1=Hair, 2=Nail, 3=Skincare, 4=Makeup)
INSERT IGNORE INTO `artist_services` (`artist_id`, `service_id`) VALUES
  -- Priya Sharma — Makeup specialist
  (1, 4), (1, 3),
  -- Neha Kapoor — Hair specialist
  (2, 1), (2, 3),
  -- Anjali Singh — Skincare specialist
  (3, 3), (3, 4),
  -- Pooja Mehta — Nail specialist
  (4, 2), (4, 3),
  -- Ritika Gupta — Makeup specialist
  (5, 4), (5, 1),
  -- Simran Kaur — Hair specialist
  (6, 1), (6, 4), (6, 3);

-- ============================================================
-- TABLE 9: service_subcategories
-- Each service has multiple subcategories
-- NOTE: Table name is PLURAL → service_subcategories
-- ============================================================
CREATE TABLE IF NOT EXISTS `service_subcategories` (
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

-- ============================================================
-- SEED DATA — 4 Main Services with Subcategories
-- service_id 1 = Hair
-- service_id 2 = Nail
-- service_id 3 = Skincare
-- service_id 4 = Makeup
-- ============================================================

-- service_id 1 = Hair — Subcategories
INSERT INTO `service_subcategories` (`service_id`, `subcategory_name`, `description`, `price`, `image`, `duration`) VALUES
  (1, 'Haircut & Blow Dry',     'Precision haircut with salon blow dry finish',       800.00,  'hair.jpg',      45),
  (1, 'Global Hair Color',      'Full head single color application',               3000.00,  'haircolor.jpg', 120),
  (1, 'Highlights & Balayage',  'Natural sun-kissed highlights and balayage',       4500.00,  'haircolor.jpg', 150),
  (1, 'Keratin Treatment',      'Smooth, frizz-free keratin hair treatment',        5000.00,  'hair.jpg',      180),
  (1, 'Hair Smoothening',       'Semi-permanent smoothening for silky hair',        4500.00,  'hairstraight.jpg', 150),
  (1, 'Ombre Color',            'Gradient color from root to tip',                 4000.00,  'haircolor.jpg', 135);

-- service_id 2 = Nail — Subcategories
INSERT INTO `service_subcategories` (`service_id`, `subcategory_name`, `description`, `price`, `image`, `duration`) VALUES
  (2, 'Classic Manicure',       'Basic manicure with nail shaping and polish',       400.00,  'french.jpg',    30),
  (2, 'Gel Manicure',           'Long lasting gel nail polish with no chips',        800.00,  'gel.jpg',       60),
  (2, 'French Manicure',        'Classic white tip french manicure look',            600.00,  'french.jpg',    45),
  (2, 'Nail Art',               'Creative nail art designs and patterns',            800.00,  'Nail Gold Designs.jpg', 60),
  (2, 'Basic Pedicure',         'Foot soak, scrub and nail polish',                  500.00,  'french.jpg',    45),
  (2, 'Gel Pedicure',           'Gel polish pedicure with relaxing spa treatment',  1000.00,  'gel.jpg',       75);

-- service_id 3 = Skincare — Subcategories
INSERT INTO `service_subcategories` (`service_id`, `subcategory_name`, `description`, `price`, `image`, `duration`) VALUES
  (3, 'Deep Cleansing Facial',  'Deep pore cleansing facial for radiant skin',      1200.00,  NULL,            60),
  (3, 'Anti-Aging Facial',      'Anti-aging facial with collagen boost treatment',  2000.00,  NULL,            75),
  (3, 'Tan Removal',            'Full face tan removal treatment',                  1000.00,  NULL,            45),
  (3, 'Face Bleach',            'Brightening bleach for instant glow',               500.00,  NULL,            30),
  (3, 'Detan Pack',             'Effective detan pack for face and neck',            700.00,  NULL,            40),
  (3, 'Hydra Facial',           'Hydrating facial using advanced hydradermie',      2500.00,  NULL,            90);

-- service_id 4 = Makeup — Subcategories
INSERT INTO `service_subcategories` (`service_id`, `subcategory_name`, `description`, `price`, `image`, `duration`) VALUES
  (4, 'Bridal Makeup',          'Complete HD bridal makeup with trial session',    12000.00,  'bridal.jpg',   240),
  (4, 'Party Makeup',           'Bold and glamorous party makeup look',             2500.00,  'party.jpg',     90),
  (4, 'HD Makeup',              'High definition flawless makeup for events',       3500.00,  'hd.jpg',        60),
  (4, 'Airbrush Makeup',        'Long lasting airbrush makeup for brides',          9000.00,  'bridal.jpg',   180),
  (4, 'Engagement Makeup',      'Flawless HD makeup for engagement ceremony',       3500.00,  'hd.jpg',        75),
  (4, 'Reception Makeup',       'Elegant and glamorous reception evening look',     4000.00,  'party.jpg',     90);

-- ============================================================
-- TABLE 10: subcategory_items (Level 3)
-- Each subcategory (like Bridal Makeup) has multiple items
-- subcategory_id FK → service_subcategories.id
-- ============================================================
CREATE TABLE IF NOT EXISTS `subcategory_items` (
  `id`               INT            NOT NULL AUTO_INCREMENT,
  `subcategory_id`   INT            NOT NULL COMMENT 'FK → service_subcategories.id',
  `item_name`        VARCHAR(150)   NOT NULL,
  `description`      TEXT,
  `price`            DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
  `image`            VARCHAR(255),
  `duration`         INT            COMMENT 'Duration in minutes',
  `active`           TINYINT(1)     NOT NULL DEFAULT 1,
  `created_at`       TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_items_subcategory_id` (`subcategory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- SEED DATA — subcategory_items
-- NOTE: subcategory IDs follow the INSERT order above:
--
-- Hair subcategories (service_id=1):
--   1 = Haircut & Blow Dry
--   2 = Global Hair Color
--   3 = Highlights & Balayage
--   4 = Keratin Treatment
--   5 = Hair Smoothening
--   6 = Ombre Color
--
-- Nail subcategories (service_id=2):
--   7  = Classic Manicure
--   8  = Gel Manicure
--   9  = French Manicure
--   10 = Nail Art
--   11 = Basic Pedicure
--   12 = Gel Pedicure
--
-- Skincare subcategories (service_id=3):
--   13 = Deep Cleansing Facial
--   14 = Anti-Aging Facial
--   15 = Tan Removal
--   16 = Face Bleach
--   17 = Detan Pack
--   18 = Hydra Facial
--
-- Makeup subcategories (service_id=4):
--   19 = Bridal Makeup
--   20 = Party Makeup
--   21 = HD Makeup
--   22 = Airbrush Makeup
--   23 = Engagement Makeup
--   24 = Reception Makeup
-- ============================================================

-- ── HAIR ITEMS ────────────────────────────────────────────────

-- subcategory_id 1 = Haircut & Blow Dry
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (1, 'Basic Haircut',        'Simple clean haircut with blow dry',               600.00, 'hair.jpg',      30),
  (1, 'Layer Cut',            'Textured layer cut for volume and movement',        800.00, 'hair.jpg',      45),
  (1, 'Step Cut',             'Classic step cut with blow dry finish',             750.00, 'hair.jpg',      40),
  (1, 'U-Cut',                'Elegant U-shaped cut for long hair',               700.00, 'hair.jpg',      40),
  (1, 'V-Cut',                'Stylish V-shaped cut with styling',                750.00, 'hair.jpg',      40),
  (1, 'Bob Cut',              'Trendy bob haircut with blowout',                   900.00, 'hair.jpg',      50);

-- subcategory_id 2 = Global Hair Color
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (2, 'Black Color',          'Deep shine full head black hair color',            2500.00, 'haircolor.jpg', 90),
  (2, 'Brown Color',          'Rich chocolate or chestnut brown hair color',      3000.00, 'haircolor.jpg', 120),
  (2, 'Burgundy Color',       'Deep red-brown burgundy hair color',               3200.00, 'haircolor.jpg', 120),
  (2, 'Copper Color',         'Warm copper tone full head color',                 3500.00, 'haircolor.jpg', 120),
  (2, 'Mahogany Color',       'Luxurious mahogany red-brown shade',               3200.00, 'haircolor.jpg', 120),
  (2, 'Golden Brown',         'Warm golden brown global color',                   3000.00, 'haircolor.jpg', 120);

-- subcategory_id 3 = Highlights & Balayage
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (3, 'Blonde Highlights',    'Sun-kissed blonde highlights for natural glow',    4000.00, 'haircolor.jpg', 150),
  (3, 'Copper Balayage',      'Warm copper hand-painted balayage',                4500.00, 'haircolor.jpg', 150),
  (3, 'Brown Balayage',       'Natural brown to caramel balayage blend',          4200.00, 'haircolor.jpg', 150),
  (3, 'Peekaboo Highlights',  'Hidden color highlights for a surprise pop',       3500.00, 'haircolor.jpg', 120),
  (3, 'Global + Highlights',  'Full color with highlights combo',                 5500.00, 'haircolor.jpg', 180);

-- subcategory_id 4 = Keratin Treatment
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (4, 'Brazilian Keratin',    'Frizz-free Brazilian keratin smoothing treatment', 5000.00, 'hair.jpg',      180),
  (4, 'Nano Keratin',         'Advanced nano keratin for ultra smooth hair',      6000.00, 'hair.jpg',      180),
  (4, 'Soft Keratin',         'Soft keratin treatment for wavy hair',             4500.00, 'hair.jpg',      150);

-- subcategory_id 5 = Hair Smoothening
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (5, 'L'Oreal Smoothening',  'L Oreal professional hair smoothening treatment',  5000.00, 'hairstraight.jpg', 150),
  (5, 'Wella Smoothening',    'Wella Koleston smooth and shine treatment',         4800.00, 'hairstraight.jpg', 150),
  (5, 'Schwarzkopf Smooth',   'Schwarzkopf straight and repair treatment',        5500.00, 'hairstraight.jpg', 180);

-- subcategory_id 6 = Ombre Color
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (6, 'Dark to Light Ombre',  'Classic dark root to light ends ombre effect',    4000.00, 'haircolor.jpg', 135),
  (6, 'Brown Ombre',          'Rich brown gradient ombre color blend',            4000.00, 'haircolor.jpg', 135),
  (6, 'Copper Ombre',         'Stunning copper to blonde ombre transition',       4500.00, 'haircolor.jpg', 150),
  (6, 'Reverse Ombre',        'Light roots fading to dark ends ombre',            4200.00, 'haircolor.jpg', 135);

-- ── NAIL ITEMS ────────────────────────────────────────────────

-- subcategory_id 7 = Classic Manicure
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (7, 'Basic Manicure',       'Nail shaping, cuticle care and regular polish',     350.00, 'french.jpg',    25),
  (7, 'Spa Manicure',         'Classic manicure with relaxing hand spa',           500.00, 'french.jpg',    40),
  (7, 'Hot Oil Manicure',     'Nourishing hot oil manicure for dry hands',         450.00, 'french.jpg',    35),
  (7, 'Paraffin Manicure',    'Moisturizing paraffin wax manicure treatment',      600.00, 'french.jpg',    45);

-- subcategory_id 8 = Gel Manicure
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (8, 'Gel Polish Manicure',  'Long-lasting chip-free gel polish manicure',        800.00, 'gel.jpg',       60),
  (8, 'Gel Extension',        'Nail extensions with gel overlay for length',      1200.00, 'gel.jpg',       90),
  (8, 'Builder Gel',          'Strength building gel for damaged nails',          1000.00, 'gel.jpg',       75),
  (8, 'Gel Removal + Redo',   'Safe gel removal and fresh gel application',        900.00, 'gel.jpg',       75);

-- subcategory_id 9 = French Manicure
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (9, 'Classic French',       'Traditional white tip classic french manicure',     600.00, 'french.jpg',    45),
  (9, 'Gel French',           'Long lasting gel french manicure',                  900.00, 'french.jpg',    60),
  (9, 'Pink French',          'Soft pink base with white tip french look',         650.00, 'french.jpg',    45),
  (9, 'Colored French Tip',   'Colored tip variation of french manicure',          700.00, 'french.jpg',    50);

-- subcategory_id 10 = Nail Art
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (10, 'Floral Nail Art',     'Delicate floral design on gel or regular polish',   800.00, 'Nail Gold Designs.jpg', 60),
  (10, 'Gold Foil Art',       'Premium gold foil nail art designs',               1200.00, 'Nail Gold Designs.jpg', 75),
  (10, 'Ombre Nail Art',      'Beautiful ombre gradient nail art effect',          900.00, 'Nail Gold Designs.jpg', 60),
  (10, 'Marble Nail Art',     'Luxurious marble effect nail art design',          1000.00, 'Nail Gold Designs.jpg', 70),
  (10, 'Geometric Art',       'Clean geometric patterns on nails',                  850.00, 'Nail Gold Designs.jpg', 60);

-- subcategory_id 11 = Basic Pedicure
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (11, 'Basic Pedicure',      'Foot soak, scrub, nail shaping and regular polish', 450.00, 'french.jpg',    40),
  (11, 'Spa Pedicure',        'Relaxing spa pedicure with foot massage',           700.00, 'french.jpg',    60),
  (11, 'Fish Spa Pedicure',   'Natural fish spa pedicure for soft feet',           900.00, 'french.jpg',    60),
  (11, 'Paraffin Pedicure',   'Moisturizing paraffin pedicure with polish',        800.00, 'french.jpg',    60);

-- subcategory_id 12 = Gel Pedicure
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (12, 'Gel Polish Pedicure', 'Long lasting gel polish pedicure with spa',        1000.00, 'gel.jpg',       75),
  (12, 'Gel + Nail Art Pedi', 'Gel pedicure with nail art on toes',              1300.00, 'gel.jpg',       90),
  (12, 'French Gel Pedicure', 'French style gel pedicure with long lasting shine', 1100.00, 'gel.jpg',      80);

-- ── SKINCARE ITEMS ────────────────────────────────────────────

-- subcategory_id 13 = Deep Cleansing Facial
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (13, 'Basic Cleanup',       'Basic face cleanup for normal to oily skin',        600.00, NULL,            30),
  (13, 'Deep Pore Facial',    'Deep pore cleansing for clogged skin',            1200.00, NULL,            60),
  (13, 'Glow Facial',         'Brightening glow facial for dull skin',           1500.00, NULL,            60),
  (13, 'Charcoal Facial',     'Detoxifying charcoal deep cleansing facial',      1000.00, NULL,            50);

-- subcategory_id 14 = Anti-Aging Facial
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (14, 'Collagen Facial',     'Collagen boosting anti-aging facial treatment',   2000.00, NULL,            75),
  (14, 'Gold Facial',         'Luxurious 24K gold anti-aging facial',            2500.00, NULL,            75),
  (14, 'Vitamin C Facial',    'Brightening and anti-aging vitamin C facial',     1800.00, NULL,            60),
  (14, 'Retinol Facial',      'Retinol-infused anti-aging facial treatment',     2200.00, NULL,            70);

-- subcategory_id 15 = Tan Removal
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (15, 'Face Tan Removal',    'Effective tan removal treatment for face',        1000.00, NULL,            45),
  (15, 'Full Body Tan Removal','Complete body tan removal treatment',            3000.00, NULL,            90),
  (15, 'Arms & Neck Detan',   'Tan removal for arms, hands and neck area',      1500.00, NULL,            60),
  (15, 'Detan + Bleach Combo','Detan pack followed by face bleach combo',       1200.00, NULL,            60);

-- subcategory_id 16 = Face Bleach
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (16, 'Diamond Bleach',      'Premium diamond bleach for instant glow',          600.00, NULL,            30),
  (16, 'Gold Bleach',         'Luxury gold bleach for bridal glow',               700.00, NULL,            30),
  (16, 'Oxygen Bleach',       'Gentle oxygen bleach for sensitive skin',          550.00, NULL,            30),
  (16, 'Herbal Bleach',       'Natural herbal bleach for all skin types',         500.00, NULL,            30);

-- subcategory_id 17 = Detan Pack
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (17, 'Face Detan Pack',     'Instant tan reduction detan pack for face',        600.00, NULL,            35),
  (17, 'Face + Neck Detan',   'Detan pack covering face and neck area',           800.00, NULL,            40),
  (17, 'Detan + Massage',     'Detan pack with relaxing face massage',            900.00, NULL,            50);

-- subcategory_id 18 = Hydra Facial
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (18, 'Basic Hydra Facial',  'Hydrating facial with deep moisturization',       2000.00, NULL,            60),
  (18, 'Advanced Hydra Facial','Advanced hydradermie with serum infusion',       2500.00, NULL,            90),
  (18, 'Bridal Hydra Glow',   'Pre-bridal hydra glow facial for radiant skin',  3000.00, NULL,            90),
  (18, 'Anti-Dull Hydra',     'Hydra facial targeting dull and tired skin',      2200.00, NULL,            75);

-- ── MAKEUP ITEMS ──────────────────────────────────────────────

-- subcategory_id 19 = Bridal Makeup
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (19, 'HD Bridal Makeup',         'High definition full coverage bridal makeup',  12000.00, 'bridal.jpg',  240),
  (19, 'Traditional Bridal Makeup','Classic Indian traditional bridal makeup look', 8000.00, 'bridal.jpg',  180),
  (19, 'Airbrush Bridal Makeup',   'Long lasting airbrush finish bridal makeup',    9000.00, 'bridal.jpg',  180),
  (19, 'Mehendi Bridal Look',      'Light natural bridal look for mehendi ceremony',4000.00, 'bridal.jpg',  120),
  (19, 'South Indian Bridal',      'Traditional south Indian bridal makeup look',   7000.00, 'bridal.jpg',  180),
  (19, 'Rajasthani Bridal',        'Vibrant Rajasthani traditional bridal makeup',  7500.00, 'bridal.jpg',  180);

-- subcategory_id 20 = Party Makeup
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (20, 'Cocktail Party Makeup','Bold and glamorous cocktail party look',           3000.00, 'party.jpg',    60),
  (20, 'Birthday Glam Makeup', 'Fun and glam birthday celebration makeup',        2000.00, 'party.jpg',    45),
  (20, 'Reception Look',       'Elegant and classic reception party makeup',       2500.00, 'party.jpg',    60),
  (20, 'Night Out Glam',       'Smoky and sultry night out glam makeup',           2200.00, 'party.jpg',    50),
  (20, 'Festive Makeup',       'Bright and festive look for Diwali, Navratri',     1800.00, 'party.jpg',    45),
  (20, 'Sangeet Makeup',       'Vibrant and colorful sangeet ceremony makeup',     3000.00, 'party.jpg',    60);

-- subcategory_id 21 = HD Makeup
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (21, 'HD Camera Makeup',     'Perfect for photography and video shoots',         4000.00, 'hd.jpg',       60),
  (21, 'HD Engagement Makeup', 'Flawless HD makeup for engagement ceremony',       3500.00, 'hd.jpg',       75),
  (21, 'HD Anniversary Look',  'Stunning HD makeup for anniversary celebrations',  3000.00, 'hd.jpg',       60),
  (21, 'HD Corporate Makeup',  'Professional HD makeup for corporate events',      2500.00, 'hd.jpg',       45),
  (21, 'HD Fashion Makeup',    'Editorial fashion HD makeup for photoshoots',      5000.00, 'hd.jpg',       90);

-- subcategory_id 22 = Airbrush Makeup
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (22, 'Full Airbrush Bridal', 'Complete airbrush bridal makeup with trial',       9000.00, 'bridal.jpg',  180),
  (22, 'Light Airbrush Makeup','Natural airbrush makeup for everyday events',      4000.00, 'bridal.jpg',   90),
  (22, 'Airbrush Engagement',  'Flawless airbrush makeup for engagement ceremony', 6000.00, 'bridal.jpg',  120),
  (22, 'Airbrush Party Look',  'Glamorous airbrush finish for parties',             5000.00, 'bridal.jpg',  120);

-- subcategory_id 23 = Engagement Makeup
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (23, 'Simple Engagement',    'Elegant and understated engagement makeup look',   2500.00, 'hd.jpg',       60),
  (23, 'Heavy Engagement',     'Dramatic and bold heavy engagement makeup look',   4000.00, 'hd.jpg',       90),
  (23, 'HD Engagement',        'High definition flawless engagement makeup',       3500.00, 'hd.jpg',       75),
  (23, 'Airbrush Engagement',  'Long lasting airbrush engagement makeup',          6000.00, 'hd.jpg',      120),
  (23, 'Traditional Engagement','Classic Indian traditional engagement look',      3000.00, 'hd.jpg',       75);

-- subcategory_id 24 = Reception Makeup
INSERT INTO `subcategory_items` (`subcategory_id`, `item_name`, `description`, `price`, `image`, `duration`) VALUES
  (24, 'Classic Reception',    'Timeless classic reception evening makeup',        3500.00, 'party.jpg',    75),
  (24, 'Glam Reception',       'Over the top glamorous reception bridal look',     5000.00, 'party.jpg',    90),
  (24, 'Indo-Western Reception','Fusion Indo-western reception makeup style',       4000.00, 'party.jpg',    80),
  (24, 'Minimal Reception',    'Clean and fresh minimal look for reception',       2500.00, 'party.jpg',    60),
  (24, 'Airbrush Reception',   'Long lasting airbrush finish reception makeup',    6000.00, 'party.jpg',   120);

-- ============================================================
-- END OF SCHEMA
-- ============================================================
