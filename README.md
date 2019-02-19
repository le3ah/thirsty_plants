Travis CI badge: [![Build Status](https://travis-ci.org/le3ah/thirsty_plants.svg?branch=master)](https://travis-ci.org/le3ah/thirsty_plants)
We'll need to credit the icon author

<!-- <div>Icons made by <a href="https://www.freepik.com/" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" 			    title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" 			    title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div> -->


# README

## Description

Thirsty Plants is an 11 day, 5 person project during Mod 3 of 4, for Turing School's Backend Engineering Program.

We were challenged to create a web application from idea to inception. Project requirements include: authentication with a third-party service, consuming an api, and solving a real-world problem.

And thus Thirsty Plants was born. Thirsty Plants is a web application in which users create accounts via Google OAuth, and are able to

utilize the Dark Sky weather API to

## [Thirsty Plants](https://thirsty-plants.herokuapp.com/)


![Alt Text](public/welcome-page.png?raw=true "Welcome Page")

### Getting Started

To run Thirsty Plants on your local machine, navigate to the directory you would like the project to be located in, then execute the following commands in the terminal:

```
$ git clone git@github.com:le3ah/thirsty_plants.git
$ cd
$ bundle
$ rails g rspec:install
$ rails db:create
$ rails db:migrate
```

Sign Up on the following Apps for
Sign up on github for a key.
Adds this to your config/application.yml file.
```
GOOGLE_CLIENT_ID: <insert>
GOOGLE_SECRET: <insert>

darksky_api_secret: <insert>
google_maps_api_key: <insert>

TWILLIO_ACCOUNT_SID: <insert>
TWILLIO_AUTH_TOKEN: <insert>

ADMIN_PHONE_NUMBER: '<insert phone number associated with your Twillio account>'

```

A step by step series of examples that tell you how to get a development env running




- Summary about the project, what it is intended for
- Instructions for how to set it up on a local machine
- Prerequisites and the versions
- How to run tests
- Recognition for contributors
- Link to a production version if applicable

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

To run the test suite:
`redis-server`
open a new tab in the terminal
run `rspec`


To view on local host:
`rails s`
In a browser, visit `localhost:3000`

## Deployment

Add additional notes about how to deploy this on a live system

2. In your terminal, in your little shop directory, run:
* `$ createuser -s -r little_shop`
* `$ RAILS_ENV=production rake db:{drop,create,migrate,seed}`
* `$ rake assets:precompile`

3. Instead of running `rails s` which would start your server in development mode, run: `rails s -e production`

## Tools

* Travis CI
* Figaro
* Faraday
* Shoulda-Matchers
* Factory Bot
* Google OAuth
* Bootstap
* Dark Sky
* [Waffle.io](https://waffle.io) - Project Management
* [GitHub](github.com) - Version Control
* [FactoryBot](https://github.com/thoughtbot/factory_bot)
* RSpec
* Capybara
* Pry
* Launchy
* SimpleCov
* Yarn
* PostrgeSQL
* Chrome Dev Tools
* Twillio
* Sidekiq
* New Relic - Speed Analytics


## Rubric and Project Description
http://backend.turing.io/module3/projects/terrificus

## Authors

* [Mackenzie Frey](https://github.com/Mackenzie-Frey)
* [Ali Benetka](https://github.com/abenetka)
* [Leah K. Miller](https://github.com/le3ah)
* [Ben Lee](https://github.com/bendelonlee)
* [Anna Smolentzov](https://github.com/asmolentzov)

## Acknowledgments

* [Sal Espinosa](https://github.com/s-espinosa)
* [Mike Dao](https://github.com/mikedao)
