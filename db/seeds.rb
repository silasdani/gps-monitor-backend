User.create!(name: "Admin",
             email: "admin@yahoo.com",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true)
User.create!(name: "Manager",
             email: "manager@yahoo.com",
             password: "foobar",
             password_confirmation: "foobar",
             manager: true,
             activated: true)
User.create!(name: "User",
             email: "user@yahoo.com",
             password: "foobar",
             password_confirmation: "foobar",
             activated: true)


# Generate a bunch of additional users.
27.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@yahoo.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true)
end

# Generate jogging tracks for a subset of users.
users = User.order(:created_at).take(25)
20.times do
  date = Faker::Time.between_dates(from: Date.today.prev_month - 1, to: Date.today, period: :day) #=> "2014-09-19 08:07:52 -0700"
  distance = Faker::Number.between(from: 2.0, to: 8.0).round(2)
  time = Faker::Number.within(range: 600..2000) # seconds
  location = Faker::Address.full_address

  # location_title: "La mine in sat" street_number: Faker:: locality postal_code:integer latitude longitude place_id country facility_name
  users.each { |user|
    user.tracks.create!(date: date, distance: distance, time: time, location: location)
    address = Faker::Address
    user.locations.create!(location_title: address.full_address, street_number:  address.building_number, locality: address.city, postal_code: address.zip_code, latitude: address.latitude, longitude: address.longitude, place_id: address.secondary_address, facility_name: address.community)
  }
end
