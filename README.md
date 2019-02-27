[![Build Status](https://travis-ci.org/le3ah/thirsty_plants.svg?branch=master)](https://travis-ci.org/le3ah/thirsty_plants)

[![Waffle.io - Columns and their card count](https://badge.waffle.io/le3ah/thirsty_plants.svg?columns=all)](https://waffle.io/le3ah/thirsty_plants)

# README
## Description

Thirsty Plants is an 11-day, five-person project during Mod 3 of 4, for Turing School's Backend Engineering Program.

Our challenge was to create a web application from idea to inception. Project requirements include: authentication with a third-party service, consuming an api, and solving a real-world problem.

Thus, Thirsty Plants was born. Thirsty Plants is a web application designed to assist users in keep tracking of watering their gardens, in accordance with the precipitation in their local area. The application utilizes the languages of Ruby, Javascript, HTML, CSS, Bootstrap, the web framework of Rails, and authentication via Google OAuth. The Dark Sky weather API is utilized to consume precipitation data.

#### [**_View Thirsty Plants in Production_**](https://thirsty-plants.herokuapp.com/)


<img width="1389" alt="screen shot 2019-02-20 at 4 55 26 pm" src="https://user-images.githubusercontent.com/42391567/53133442-6a526d80-3530-11e9-893b-c10d2ea0fff4.png">

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
#### Setup your environment variables:

##### Sign Up on the following API's:
* [Dark Sky](https://darksky.net/dev)
* [Twillio](https://www.twilio.com/)
* [Google](https://console.cloud.google.com/apis/credentials)
* [Google Maps](https://developers.google.com/maps/documentation/javascript/get-api-key)


Add the following code snippet to your `config/application.yml` file. Make sure to insert the key/secret without the alligator clips ( < > ).
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
* Factory Bot
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
* Twillio
* Sidekiq
* New Relic
* Paperclip
* ImageMagick

## Rubric/Project Description
http://backend.turing.io/module3/projects/terrificus

## Authors

* [Mackenzie Frey](https://github.com/Mackenzie-Frey)
* [Ali Benetka](https://github.com/abenetka)
* [Leah K. Miller](https://github.com/le3ah)
* [Ben Lee](https://github.com/bendelonlee)
* [Anna Smolentzov](https://github.com/asmolentzov)

## Teamwork Makes the Dream Work
<img width="754" alt="screen shot 2019-02-20 at 5 39 39 pm" src="https://user-images.githubusercontent.com/42391567/53135010-c0c2aa80-3536-11e9-8695-3ca446dbc015.png">

## Acknowledgments

* [Sal Espinosa](https://github.com/s-espinosa)
* [Mike Dao](https://github.com/mikedao)
