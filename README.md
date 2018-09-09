# README

This document shows the steps to get the application to run in docker for production and rails server for local developement. 

# Docker Setup 
# Step 1.

Clone this application 

# Step 2. 

Change directory to the application root 

# Step 3.

from the root run `docker-compose build`

# Step 4. 

run the following command to create the postgres db  `docker-compose run --rm web bin/rails db:create`

# Step 5. 

run the following command to run migrations on the db `docker-compose run --rm web bin/rails db:migrate`

# Step 6. 

run the following command if you wish to seed the db `docker-compose run --rm web bin/rails db:seed`

# Step 7. 

run the following command to start the application `docker-compose up -d`

# Local Development 

You'll need the latest rails gem and bundler to run the application locally. 

# Step 1. 

Clone this application 

# Step 2.

Change directory to the application root 

# Step 3. 

run `bundle install` to install the dependencies 

# Step 4. 

run `rails db:create` to create the db

# Step 5. 

run `rails db:migrate` to run all db migrations 

# Step 6. 

run `rails db:seed`to seed data to the database 

# Step 7. 

run `rails server`to run the server 

full API docs can be found at this location when running the app. http://localhost:3000/api

