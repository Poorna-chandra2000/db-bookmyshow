-- ============================================
-- BOOKMYSHOW DATABASE ASSIGNMENT
-- ============================================

-- ============================================
-- DROP DATABASE IF EXISTS
-- ============================================

DROP DATABASE IF EXISTS bookmyshow_db;

-- ============================================
-- CREATE DATABASE
-- ============================================

CREATE DATABASE bookmyshow_db;

USE bookmyshow_db;

-- ============================================
-- TABLE 1 : THEATRE
-- ============================================

CREATE TABLE Theatre (
    theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- ============================================
-- TABLE 2 : SCREEN
-- ============================================

CREATE TABLE Screen (
    screen_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_id INT NOT NULL,
    screen_name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,

    CONSTRAINT fk_screen_theatre
    FOREIGN KEY (theatre_id)
    REFERENCES Theatre(theatre_id)
);

-- ============================================
-- TABLE 3 : MOVIE
-- ============================================

CREATE TABLE Movie (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_name VARCHAR(100) NOT NULL,
    language VARCHAR(30) NOT NULL,
    duration_minutes INT NOT NULL,
    certificate VARCHAR(10) NOT NULL
);

-- ============================================
-- TABLE 4 : SHOW_MASTER
-- ============================================

CREATE TABLE Show_Master (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT NOT NULL,
    screen_id INT NOT NULL,
    show_date DATE NOT NULL,
    show_time TIME NOT NULL,

    CONSTRAINT fk_show_movie
    FOREIGN KEY (movie_id)
    REFERENCES Movie(movie_id),

    CONSTRAINT fk_show_screen
    FOREIGN KEY (screen_id)
    REFERENCES Screen(screen_id)
);

-- ============================================
-- INSERT THEATRES
-- ============================================

INSERT INTO Theatre
(theatre_name, city, address)
VALUES
('PVR Nexus', 'Bangalore', 'Koramangala Bangalore'),
('INOX Forum Mall', 'Bangalore', 'Forum Mall Bangalore'),
('Cinepolis', 'Bangalore', 'Royal Meenakshi Mall');

-- ============================================
-- INSERT SCREENS
-- ============================================

INSERT INTO Screen
(theatre_id, screen_name, capacity)
VALUES
(1,'Screen 1',200),
(1,'Screen 2',180),
(1,'Screen 3',250),

(2,'Screen 1',220),
(2,'Screen 2',180),

(3,'Screen 1',150),
(3,'Screen 2',170);

-- ============================================
-- INSERT MOVIES
-- ============================================

INSERT INTO Movie
(movie_name, language, duration_minutes, certificate)
VALUES
('Dasara','Telugu',156,'U/A'),
('Kisi Ka Bhai Kisi Ki Jaan','Hindi',145,'U/A'),
('Tu Jhoothi Main Makkaar','Hindi',159,'U/A'),
('Avatar: The Way of Water','English',192,'U/A'),
('Pushpa 2','Telugu',180,'U/A');

-- ============================================
-- INSERT SHOWS
-- ============================================

INSERT INTO Show_Master
(movie_id,screen_id,show_date,show_time)
VALUES

(1,1,'2025-04-25','12:15:00'),

(2,2,'2025-04-25','01:00:00'),
(2,2,'2025-04-25','04:10:00'),
(2,2,'2025-04-25','06:20:00'),
(2,2,'2025-04-25','07:20:00'),
(2,2,'2025-04-25','10:30:00'),

(3,3,'2025-04-25','01:15:00'),

(4,1,'2025-04-25','01:20:00'),

(5,4,'2025-04-25','11:00:00'),
(5,4,'2025-04-25','03:00:00'),

(1,5,'2025-04-26','12:00:00'),
(2,6,'2025-04-26','02:00:00'),
(3,7,'2025-04-26','05:00:00');

-- ============================================
-- VERIFY DATA
-- ============================================

SELECT * FROM Theatre;

SELECT * FROM Screen;

SELECT * FROM Movie;

SELECT * FROM Show_Master;

-- ============================================
-- P2 QUERY
-- LIST ALL SHOWS FOR A GIVEN
-- THEATRE AND DATE
-- ============================================

SELECT
    t.theatre_name,
    m.movie_name,
    m.language,
    s.show_date,
    s.show_time,
    sc.screen_name
FROM Show_Master s
JOIN Movie m
    ON s.movie_id = m.movie_id
JOIN Screen sc
    ON s.screen_id = sc.screen_id
JOIN Theatre t
    ON sc.theatre_id = t.theatre_id
WHERE t.theatre_name = 'PVR Nexus'
AND s.show_date = '2025-04-25'
ORDER BY m.movie_name, s.show_time;

-- ============================================
-- ADDITIONAL USEFUL QUERIES
-- ============================================

-- List all movies

SELECT * FROM Movie;

-- List all theatres

SELECT * FROM Theatre;

-- List all screens in a theatre

SELECT
    t.theatre_name,
    sc.screen_name,
    sc.capacity
FROM Screen sc
JOIN Theatre t
ON sc.theatre_id = t.theatre_id;

-- Count shows per movie

SELECT
    m.movie_name,
    COUNT(*) AS total_shows
FROM Show_Master s
JOIN Movie m
ON s.movie_id = m.movie_id
GROUP BY m.movie_name;

-- Shows on a specific date

SELECT
    m.movie_name,
    s.show_time
FROM Show_Master s
JOIN Movie m
ON s.movie_id = m.movie_id
WHERE s.show_date='2025-04-25';

-- ============================================
-- END OF SCRIPT
-- ============================================
