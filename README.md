# README
[![Build Status](https://travis-ci.org/le3ah/thirsty_plants.svg?branch=master)](https://travis-ci.org/le3ah/thirsty_plants) [![Waffle.io - Columns and their card count](https://badge.waffle.io/le3ah/thirsty_plants.svg?columns=all)](https://waffle.io/le3ah/thirsty_plants)
## Description

Thirsty Plants is an 11-day, five-person project during Mod 3 of 4, for Turing School's Back-End Engineering Program.

Our challenge was to create a web application from idea to inception. Project requirements included: authentication with a third-party service, consuming an API, and solving a real-world problem.

Thus, Thirsty Plants was born. Thirsty Plants is an application that assists users in keeping track of watering their gardens, in accordance with the precipitation in their local area. The application utilizes Ruby on Rails, JavaScript, HTML, CSS, Bootstrap, and authentication via Google OAuth. The Dark Sky weather API is consumed for precipitation data.

## [View Thirsty Plants in Production](https://thirsty-plants.herokuapp.com/)

<img width="1389" alt="Thirsty Plants Landing Page" src="https://user-images.githubusercontent.com/42391567/53133442-6a526d80-3530-11e9-893b-c10d2ea0fff4.png">

## Schema
![Alt text](./public/schema.png?raw=true "Schema")

## Getting Started

To run Thirsty Plants on your local machine, navigate to the directory in which you would like the project to be located, then execute the following commands:

```
$ git clone git@github.com:le3ah/thirsty_plants.git
$ cd thirsty_plants
$ bundle
$ rails g rspec:install
$ rails db:create
$ rails db:migrate
$ bundle exec figaro install
```
## Environment Variable Setup:

##### Sign Up for the following API's:
* [Dark Sky](https://darksky.net/dev)
* [Twilio](https://www.twilio.com/)
* [Google](https://console.cloud.google.com/apis/credentials)
* [Google Maps](https://developers.google.com/maps/documentation/javascript/get-api-key)


Add the following code snippet to the `config/application.yml` file. Make sure to insert the key/secret without the alligator clips ( < > ).
```
GOOGLE_CLIENT_ID: <insert>
GOOGLE_SECRET: <insert>

darksky_api_secret: <insert>
google_maps_api_key: <insert>

TWILLIO_ACCOUNT_SID: <insert>
TWILLIO_AUTH_TOKEN: <insert>

ADMIN_PHONE_NUMBER: '<insert number associated with your Twillio account>'

```

## Running Tests

To run the test suite, execute the following command:
`redis-server`. While that server is running, open a new terminal tab,
run `rspec`.


## Deployment

To view Thirsty Plants in development, execute the following command from the project directory: `rails s`. In a browser, visit `localhost:3000`, to view the application.

To view the application in production, from the project directory, execute the following commands:
```
$ createuser -s -r thirsty_plants
$ RAILS_ENV=production rake db:{drop,create,migrate}
$ rake assets:precompile
$ rails s -e production
```

## Tools

* Travis CI
* Figaro
* Faraday
* Shoulda-Matchers
* Google OAuth
* Bootstrap
* Dark Sky
* Waffle.io
* GitHub
* FactoryBot
* RSpec
* Capybara
* Pry
* Launchy
* SimpleCov
* PostgreSQL
* Chrome Dev Tools
* Twilio
* Sidekiq
* New Relic
* Paperclip
* ImageMagick

## Authors
* [Mackenzie Frey](https://github.com/Mackenzie-Frey)
* [Ali Benetka](https://github.com/abenetka)
* [Leah K. Miller](https://github.com/le3ah)
* [Ben Lee](https://github.com/bendelonlee)
* [Anna Smolentzov](https://github.com/asmolentzov)

## Acknowledgments
* [Sal Espinosa](https://github.com/s-espinosa)
* [Mike Dao](https://github.com/mikedao)

### [Project Specifications](http://backend.turing.io/module3/projects/terrificus)
