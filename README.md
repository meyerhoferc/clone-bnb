# README

https://clonebnb1.herokuapp.com/

### Running the Project Locally
`bundle`

`rake db:create db:migrate db:seed`

`rails s`

Navigate to `localhost:3000`

### Running the Test Suite
`rspec`


### API Endpoints:

(all query params case insensitive)

#### Get a property's data data
`/api/v1/listings/find?`
query params:
      * title
      * street addresss
      * city

#### Get all property data meeting a criteria
`/api/v1/listings/find_all?`
      * city
      * state
      * zipcode
      * all
      * list_type
      * max_occupancy
      * cost_per_night

### Cities with a count of how many properties are in that city
`/api/v1/listings/count/?city=denver`

### Cities most frequently visited
`/api/v1/reservations/complete/ranked_by_cities`

### Properties ranked by most visited
`/api/v1/listings/most_visited?limit=num`

### Properties ranked by highest rated, give a limit
`/api/v1/listings/highest_rated?limit=num`

### Properties ranked by most visited for a city, give limit
`/api/v1/listings/most_visited?city=denver&limit=num`

### Properties ranked by highest rated for a city, give limit
`/api/v1/listings/highest_rated?city=denver&limit=num`
