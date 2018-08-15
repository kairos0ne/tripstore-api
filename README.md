# README

This document shows the steps to get the application to run in docker 

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
