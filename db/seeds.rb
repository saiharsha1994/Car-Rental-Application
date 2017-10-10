# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

=begin
User.create(:name=> "Admin","email" =>"admin@ncsu.edu",:password=> "123456",:user_type =>"admin")
User.create(:name=> "SuperAdmin","email" =>"sadmin@ncsu.edu",:password=> "123456",:user_type =>"superadmin")
=end
User.create!(name:  "SuperAdmin",
             email: "superadmin@ncsu.com",
             password:              "superadmin1",
             user_type: "superadmin")

User.create!(name:  "Admin",
             email: "admin@ncsu.com",
             password:              "adminncsu1",
             user_type: "admin")

User.create!(name:  "Username",
             email: "user@ncsu.com",
             password:              "userncsu1",
             user_type: "user")


User.create!(name:  "Usernames",
             email: "users@ncsu.com",
             password:              "userncsu2",
             user_type: "user")

User.create!(name:  "Saiharsha",
             email: "ssuryad3@ncsu.com",
             password:              "userncsu2",
             user_type: "user")


Car.create!(model: "Alto",
            manufacturer: "Suzuki",
            status: "Avaliable",
            lic_no: "MH1241",
            hourly_rate: "35",
            style: "SUV",
            location: "Raleigh")

Car.create!(model: "Nano",
            manufacturer: "Tata",
            status: "Avaliable",
            lic_no: "MH1243",
            hourly_rate: "35",
            style: "Sedane",
            location: "Raleigh")

Car.create!(model: "Santro",
            manufacturer: "Hundai",
            status: "Avaliable",
            lic_no: "MH1242",
            hourly_rate: "35",
            style: "LUV",
            location: "New York")

Car.create!(model: "Xylo",
            manufacturer: "Mahindra",
            status: "Avaliable",
            lic_no: "MH1244",
            hourly_rate: "35",
            style: "SUV",
            location: "San Jose")

Car.create!(model: "Ritz",
            manufacturer: "Ford",
            status: "Avaliable",
            lic_no: "MH1245",
            hourly_rate: "35",
            style: "Sedane",
            location: "New York")
