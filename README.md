# HeySloth

HeySloth is an open source project for collecting, managing and building a wall of **testimonials** so that you can showcase why your users love your product 💜.

**Please notice that you will need to self host it**

Some of the features that HeySloth offers include:

 - Link a Twitter account to view timeline
 - Search Tweet by specific URL
 - Create a custom form that you can send to your users to collect their testimonial
 - API for fetching metadata of collected testimonials
 - Embeddable ***iframe***  of your collected testimonials
 - Toggle testimonials individually to showcase or not
 - Admin dashboard


## Deploying app for self hosting

For self hosting the app it's recommended to use Heroku for simplicity. A more detailed guide for deploying a Ruby on Rails app can be found [here](https://devcenter.heroku.com/articles/getting-started-with-rails6).

In summary you will need to:

- Install the Heroku CLI and login
- run `$ heroku create`
- run `$ git push heroku main`
- run `$ heroku run rake db:migrate`

After this you should have a self hosted instance of HeySloth!

## Contributing
Improvements are always welcome, you can help by:

- Fixing bugs
- Adding new features
- Improving features
- Improve documentation
- Add more tests

## How to initiate instance of HeySloth locally

To run a local instance of HeySloth it's recommended to build & run it using a Docker container. For this make sure the Docker daemon is running and simply run:

    $ docker-compose up

This will install all required dependencies for the project to run. Then you can simply visit **localhost:3000** and you should have a local instance of HeySloth running.

To run tests simply run in the command line :

    $ rspec
