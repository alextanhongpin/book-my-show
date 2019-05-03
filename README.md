# go-book

BookMyShow system design.


## Actors

- **User** can book shows, cancel booking, pay for the show, and watch the show.
- **Ops** can manage the shows showing in the cinema and manage bookings
- **Booking System** can process bookings, and ensure bo double-booking can happen


## Use Cases

- User view iterinary
- User book show
- User pay for show
- User cancel show
- Ops manage show (create, update, delete)
- Ops manage booking


### User view iterinary
1. User visits the main page
2. The system returns the MovieList that shows movies that are valid. Movies showing today is marked with the label Showing Today.
  - Business Rule: If the Movie has all seats available, show Available.
  - Business Rule: If the Movie has partial seats available, show Available.
  - Business Rule: If the Movie has less than 10 seats, show Selling Fast.
3. User selects a Movie from the Movie List.
4. System displays the Movie Information, the display time, number of seats available and the price.


## Other notes

User
- user must have at least an email in order to purchase in order to receive the invoice
- Account does not need to be created - the purchase can be separated from user account

user {
	id (PK) = 1
	name = john
	password = xxx
	email = john.doe@mail.com
	phone = 0123456789
}

Movie
- how to ensure movies are unique?
- ops can add new movies
movie {
	id (PK) = 1
	name = Titanic
	description = Ship sank because it hits an iceberg
	release_date = 2019-01-01
	language = Singapore
}

Cinema
- the cinema can be in different location

cinema {
	id (PK) = 1 	name = ABC Plaza
}


CinemaHall
- one cinema can have many halls
- each halls can have a limited number of seats
- the cinema hall can hold the number of seats if it is fixed
- query: getHallsByCinema
- query: getHallsCountByCinema

cinema_hall {
	id (PK) = 1
	cinema_id (FK) = 1
	name = Hall A
	seats_count = 20
}

SeatType 
- each seats can be of different category (bronze, silver, gold)
- the pricing could be different for different seat type
- each seats will have a location (for the Frontend to display the seat selection)

seat_type {
	id (PK) = 1
	name = bronze
}
seat_type {
	id (PK) = 2
	name = silver
}
seat_type {
	id (PK) = 2
	name = gold
}

CinemaHallSeat
- each hall have a limited number of seats
- the rows are usually numbered as A-Z
- the columns are usually numbered 1-n, where n is the maximum number of seats per row
- each seats may have a category (premium, back, couple)
- the seats category may be charged separately
- query: getSeatsByCinemaHall
- query: getSeatsCountByCinemaHall

cinema_hall_seat {
	seat_id (PK)(UID) = a1
	cinema_hall_id (FK)(UID) = 1
	seat_type_id = 1 (bronze)
}

Showtime
- each cinema can screen a movie on specific date and time
- the screening time cannot collide between movies
- the same movie can be screen at different times on the same day
- the same movie can be screening at the same time in different halls
- query: getMoviesScreeningByCinema
- screening date may have different pricing on different days
- pricing might be different for different seats

showtime {
	id (PK) = 1
	cinema_id (FK)(UID) = 1
	cinema_hall_id (FK) (UID) = 1
	movie_id (FK)(UID) = 1
	start_at (UID)
	end_at
	// Virtual
	// duration_in_hours: is computed from the difference between end and start 
}

Booking
- the booking must be unique (cannot be double booked), and hence the criteria for booking should be (movieID, cinemaID, screenTime, seatID)
- the booking can have a status (pending) and will locked the seats for 5 minutes, unless the user cancels it

booking {
	id (PK) = 1
	showtime_id (FK) = 1
	user_id (FK) (UID) = 1
	type = phone/online/person
	paid = true
	reserved = true
}

booking_seat {
	booking_id (PK)(UID)
	seat_id (FK)(UID) = A1
}

concurrency
- user can select a seat 
- the seat can be chosen by another user at the same time
- the user should be informed that the seat is already locked
- the user should be able to retry it after the locked period
- what if there are multiple users aiming for the same seat 
- they should be placed in the queue so that it follows the first come first serve principle


https://www.vertabelo.com/blog/technical-articles/a-database-model-for-a-movie-theater-reservation-system
https://medium.com/@narengowda/bookmyshow-system-design-e268fefb56f5
https://www.quora.com/How-can-we-design-an-online-movie-ticket-booking-system
https://www.linkedin.com/pulse/designing-back-end-system-bookmyshow-saral-saxena
https://www.checkfront.com/how-to-setup-your-booking-system
