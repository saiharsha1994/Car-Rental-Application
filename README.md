# Car Rental Web Application

## Visit our app live on https://secret-mountain-75781.herokuapp.com/

### Super Admin Login details:
```
Email: superadmin@ncsu.com    
Password: superadmin1
```
### Admin login details:
```
Email: admin@ncsu.com
Password: adminncsu1
```
### Sample User details:
```
Email: user@ncsu.com
Password: userncsu1
```
### Application Features:

### USER
1)A user can log in and make a reservation

2)An admin can log in and perform CRUD operations on a reservation or user or car.

3)A super admin can log in and perform CRUD operations on a reservation or user or car or admins.

A normal user can be created using "Sign Up" button. Password must ATLEAST BE 6 DIGITS, MUST have a letter and a digit.
After a user gets created (s)he can login using "Login" button.

### After Logging in: 
A user can rent a car. (S)he can also filter the search for a car on the basis of "type", "location" and "Manufacturer".
After successful booking, a user can view the booking status on the "Home" page.
He/She can check out his reserved car or can return if already in use. 

User can post suggestions to add new cars to the database. The admin can view the suggestion and edit it before accepting the suggestion and adding that as a new car to the database. He can also decline/destroy the suggestion. 

The user can also ask to NOTIFY him/her automatically via email when a reserved car becomes available.
The user must click on NOTIFY on the "Make Reservation" page. After this, An automatic email is sent to him/her about the car availability when the user with the reserved car RETURNS the car.


### ADMIN
View/Create/Update and Delete cars,reservations and users.
Can also add new admins.

### SUPERADMIN
View/Create/Update and Delete admins,cars,reservations and users.
Can also add new superadmins.
