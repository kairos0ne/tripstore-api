# This will guess the User class
FactoryBot.define do
    
  factory :todo do
      title { Faker::Lorem.sentence }
      description { Faker::Lorem.paragraph }
      # trip nil
    end
  
    factory :user, class: User do
      name { Faker::Name.first_name }
      email  { Faker::Internet.email }
      password { "123456" }
      password_confirmation { "123456" }
      admin { false }
    end

    factory :admin, class: User do
        name { Faker::Name.first_name }
        email  { Faker::Internet.email }
        password { "123456" }
        password_confirmation { "123456" }
        admin { true }
      end

    # Create Trip with user ID of 1 
    factory :trip do 
        start_date { Time.zone.now.to_datetime }
        end_date { Time.zone.now.to_datetime }
        destination { Faker::Address.city }
        departure_airport_code { "GHJSY789" }
        arrival_airport_code {"HJKHJK78"}
        departure_time { Time.zone.now.to_datetime }
        arrival_time { Time.zone.now.to_datetime }
    end
end