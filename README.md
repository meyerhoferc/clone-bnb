# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 5.0

* System dependencies

* Configuration
Run in your terminal:
$ bundle

* Database creation and initialization:
Run in your terminal:
1. $ rake db:create
2. $ rake db:migrate
3. $ rake db:seed

* How to run the test suite
Run in your terminal:
1. $ rake db:test_prepare
2. $ rspec

* Heroku link: https://clonebnb1.herokuapp.com/

* How to run the project locally:
1. Run in your terminal:
$ rails s
2. Type in your browser and start navigating: http://localhost:3000/

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* API Endpoints:
- Get a user’s account data **
- Get a listing’s data
  * get /api/v1/listings/find?
      * title
      * street addresss & city
- Get all listing data
  * get /api/v1/listings/find_all?
      * city
      * state
      * zipcode
      * all
      * list_type
      * max_occupancy
      * cost_per_night (do this in a range)

* API Relationship Endpoints: **
    Get all of the messages for a user
    Get all of the reviews a user has posted
    Get all trips for a user
    Get all reservations for a user
    Get all listings for a host user
    Get all reviews for a host’s listings

* API Analysis Endpoints:
    Cities with a count of how many listings are in that city
    * get /api/v1/listings/count/?
        * city=“”
    Cities most frequently visited
    * get /api/v1/reservations/complete/ranked_by_cities (prob could be better named)
    Listings ranked by most visited, give a limit
    * get /api/v1/listings/most_visited?
        * limit=num
    Listings ranked by highest rated, give a limit
    * get /api/v1/listings/highest_rated?
        * limit=num
    Listings ranked by most visited for a city, give limit
    * get /api/v1/listings/most_visited?
        * city=“”
        * limit=num
    Listings ranked by highest rated for a city, give limit
    * get /api/v1/listings/highest_rated?
        * city = “”
        * limit=num
    Listing with most revenue
    * get api/v1/listings/most_revenue
