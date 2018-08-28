# This will guess the User class
FactoryBot.define do
    factory :user do
      name { "John" }
      email  { Faker::Internet.email }
      password { "123456" }
      password_confirmation { "123456" }
      admin { true }
    end
  
    # This will use the User class (Admin would have been guessed)
    factory :admin do
        name { "Stan" }
        email  { "admin@test.com" }
        password { "123456" }
        password_confirmation { "123456" }
        admin { true }
      end

    # Create Trip with user ID of 1 
    factory :trip do 
        start_date { Time.zone.now.to_datetime }
        end_date { Time.zone.now.to_datetime }
        destination {"Rome"}
        departure_airport_code { "GHJSY789" }
        arrival_airport_code {"HJKHJK78"}
        departure_time { Time.zone.now.to_datetime }
        arrival_time { Time.zone.now.to_datetime }
    end
end