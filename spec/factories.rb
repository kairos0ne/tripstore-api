# This will guess the User class
FactoryBot.define do
  
    factory :destination, class: Destination do
      title { Faker::Address.city }
      description { Faker::Address.full_address }
    end
    
    factory :todo, class: Todo do
      title { Faker::Lorem.sentence }
      description { Faker::Lorem.paragraph }
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
    factory :trip, class: Trip do 
        start_date { Time.zone.now.to_datetime }
        end_date { Time.zone.now.to_datetime }
        departure_airport_code { "GHJSY789" }
        arrival_airport_code {"HJKHJK78"}
        departure_time { Time.zone.now.to_datetime }
        arrival_time { Time.zone.now.to_datetime }
    end
end