# README

#### Instructions

* Clone repo
* Install ruby version 2.5.0p0
* Run the command `bundle install`
* Start the rails server using `rails s`
* Start sidekiq using `bundle exec sidekiq`
* Visit `localhost:3000` on browser or `curl localhost:3000`
* Run the tests `bundle exec rspec ` (Optional)

#### Description

* API for aggregating feeds from social medias at takehome.io
* Facebook, twitter, instagram feed aggregation
* Expected output from the takehome.io endpoint is a valid JSON for success case
* The response is parsed to: `{ twitter: [tweets], facebook: [statuses], instagram: [photos] }`
#### Approach

* More External services like fb, insta can be added & can have different functionalities. Hence, created separated services for each of them.
* As we are not sure, how much time a service can take to send the response. Every time a request is made, we cache it for a particular time & when request is errored, we retry the api call in background with sidekiq and store it in cache for a particular time period (1 minute). This way we reduce extensive api calls & also reduce the api response time.
* Posts are stored in cache for a very less time (< 1 minute) in order to provide near real time experience.
