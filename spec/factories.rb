# This will guess the User class
FactoryBot.define do
    factory :parking, class: Parking do
      ArrivalDate { "2018-09-07" } 
      ArrivalTime { "20:31:06" }
      DepartDate { "2018-09-07" }
      DepartTime { "20:31:06"}
      NumberOfPax { 1 }
      Title  { "MyString" }
      Initial { "MyString" }
      Surname { "MyString" }
      Email { "MyString" }
      Waiver { "MyString" }
      Remarks { "MyString" }
    end
    
    
    factory :booking, class: Booking do
      ABTANumber {"MyString"}
      token {"MyString"}
      ArrivalDate "2018-09-07"
      Nights { 1 }
      RoomCode {"MyString"}
      Adults { 1 } 
      Children { 1 }
      ParkingDays { 1 }
      Title {"MyString"}
      Initial {"MyString"}
      Surname {"MyString"}
      Address { Faker::Address.full_address }
      Town { Faker::Address.city }
      County {"MyString"}
      PostCode {"MyString"}
      DayPhone { 1 }
      Email { Faker::Internet.email }
      CustomerRef {"MyString"}
      Remarks {"MyText"}
      Waiver { false }
      DataProtection {"MyString"}
      PriceCheckFlag {"MyString"}
      PriceCheckPrice  { 1.5 }
      System {"MyString"}
      lang {"MyString"}
    end
  
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