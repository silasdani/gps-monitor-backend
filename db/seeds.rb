User.create!(name: "GM Silas",
             email: "admin@yahoo.com",
             password: "password",
             password_confirmation: "password",
             admin: true,
             activated: true)
User.create!(name: "M Silas",
             email: "manager@yahoo.com",
             password: "password",
             password_confirmation: "password",
             manager: true,
             activated: true)
User.create!(name: "Silas Daniel",
             email: "user@yahoo.com",
             password: "password",
             password_confirmation: "password",
             activated: true)


# Generate a bunch of additional users.
15.times do |n|
  name = Faker::Name.name
  email = "user-#{n + 1}@yahoo.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true)
end

# Generate jogging tracks for a subset of users.
users = User.order(:created_at).take(10)  
users.each { |user|
  5.times do
    date = Faker::Time.between_dates(from: Date.today.prev_month - 1, to: Date.today, period: :day) #=> "2014-09-19 08:07:52 -0700"
    distance = Faker::Number.between(from: 2.0, to: 8.0).round(2)
    time = Faker::Number.within(range: 600..2000) # seconds
    location = Faker::Address.full_address
    user.tracks.create!(date: date, distance: distance, time: time, location: location)
    
    address = Faker::Address
    lat = Faker::Number.between(from: 46.76, to: 46.78)
    lng = Faker::Number.between(from: 23.55, to: 23.69)
    user.locations.create!(location_title: address.full_address, street_number:  address.building_number, locality: address.city, postal_code: address.zip_code, latitude: lat, longitude: lng, place_id: address.secondary_address, facility_name: address.community)
  end
}
