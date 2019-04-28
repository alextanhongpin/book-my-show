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
