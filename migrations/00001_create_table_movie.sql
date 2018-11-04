-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE IF NOT EXISTS movie (
	id unsigned AUTO_INCREMENT,
	title NOT NULL varchar(120),
	created_at DATETIME NOT NULL default CURRENT_TIMESTAMP, 
	updated_at DATETIME NOT NULL default CURRENT_TIMESTAMP ON UPDATED CURRENT_TIMESTAMP,
	deleted_at DATETIME NOT NULL default '1900-01-01 00:00:00',
	start_at DATETIME NOT NULL,
	end_at DATETIME NOT NULL,
	description TEXT NOT NULL,
	rating int NOT NULL,
	genre int,
	original_language int,
	release_date DATETIME,
	status int,
	poster_url varchar(160),
	FOREIGN_KEY genre REFERENCES genre(id),
	PRIMARY KEY id
);

-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
DROP TABLE movie;
