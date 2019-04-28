```mysql
-- The user that performs the booking.
CREATE TABLE IF NOT EXISTS user (
	id INT UNSIGNED AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL DEFAULT '', 
	-- password
	-- email
	-- phone
	PRIMARY KEY (id)
);

INSERT INTO user (name) VALUES ('john'), ('jane');

-- The movie showing in the cinema.
CREATE TABLE IF NOT EXISTS movie (
	id INT UNSIGNED AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL DEFAULT '',
	description VARCHAR(255) NOT NULL DEFAULT '',
	-- language
	-- genre
	-- duration_in_hours
	-- release_date
	PRIMARY KEY (id)
);

INSERT INTO movie (name, description) VALUES 
('Titanic', 'Ship sank because it hits iceberg');

-- The cinemas in different location.
CREATE TABLE IF NOT EXISTS cinema (
	id INT UNSIGNED AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL DEFAULT '',
	PRIMARY KEY (id)
);
INSERT INTO cinema (name) VALUES ('ABC Plaza');

-- Cinema hall represents the halls in the cinema. 
CREATE TABLE IF NOT EXISTS cinema_hall (
	id INT UNSIGNED AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL DEFAULT '',
	cinema_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (cinema_id) REFERENCES cinema(id)
);
INSERT INTO cinema_hall (name, cinema_id) VALUES 
("Hall A", 1),
("Hall B", 1);

CREATE TABLE IF NOT EXISTS seat_type (
	id INT UNSIGNED AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL DEFAULT '',
	PRIMARY KEY (id)
);
INSERT INTO seat_type (name) VALUES 
('bronze'),
('silver'),
('gold');

CREATE TABLE IF NOT EXISTS cinema_hall_seat (
	id INT UNSIGNED AUTO_INCREMENT,
	seat_id VARCHAR(4) NOT NULL DEFAULT '',
	cinema_hall_id INT UNSIGNED NOT NULL,
	seat_type_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (cinema_hall_id) REFERENCES cinema_hall(id),
	FOREIGN KEY (seat_type_id) REFERENCES seat_type(id),
	UNIQUE (cinema_hall_id, seat_id)
);

INSERT INTO cinema_hall_seat (seat_id, cinema_hall_id, seat_type_id) VALUES 
('A1', 1, 1),
('A2', 1, 1),
('A3', 1, 1),
('B1', 1, 1),
('B2', 1, 1),
('B3', 1, 1),
('C1', 1, 1),
('C2', 1, 1),
('C3', 1, 1);

CREATE TABLE IF NOT EXISTS showtime (
	id INT UNSIGNED AUTO_INCREMENT,
	-- better to separate cinema and hall?
	-- This answers the query: what movies are showing in the cinema?
	cinema_id INT UNSIGNED NOT NULL,
	cinema_hall_id INT UNSIGNED NOT NULL,
	movie_id INT UNSIGNED NOT NULL,
	start_at DATETIME NOT NULL,
	end_at DATETIME NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (cinema_id) REFERENCES cinema(id),
	FOREIGN KEY (cinema_hall_id) REFERENCES cinema_hall(id),
	FOREIGN KEY (movie_id) REFERENCES movie(id),
	UNIQUE (cinema_hall_id, movie_id, start_at)
);

-- NOTE: The date time should not overlap.
INSERT INTO showtime (cinema_hall_id, movie_id, start_at, end_at) VALUES 
(1, 1, '2019-04-28 08:00', DATE_ADD('2019-04-28 08:00', INTERVAL 90 MINUTE)),
(1, 1, '2019-04-28 10:00', DATE_ADD('2019-04-28 08:00', INTERVAL 3 HOUR));

CREATE TABLE IF NOT EXISTS booking (
	id INT UNSIGNED AUTO_INCREMENT,
	cinema_hall_seat_id INT UNSIGNED NOT NULL,
	showtime_id INT UNSIGNED NOT NULL,
	user_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (cinema_hall_seat_id) REFERENCES cinema_hall_seat(id),
	FOREIGN KEY (showtime_id) REFERENCES showtime(id),
	FOREIGN KEY (user_id) REFERENCES user(id),
	UNIQUE (cinema_hall_seat_id, showtime_id, user_id)
);

INSERT INTO booking (cinema_hall_seat_id, showtime_id, user_id) VALUES 
(1, 1, 1);
```
