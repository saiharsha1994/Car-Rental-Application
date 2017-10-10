README

Car Rental Web Application

Visit our app live on https://secret-mountain-75781.herokuapp.com/

Super Admin Login details:
Email: superadmin@ncsu.com    
Password: superadmin1

Admin login details:
Email: admin@ncsu.com
Password: adminncsu1

Sample User details:
Email: user@ncsu.com
Password: userncsu1

Application Features:

USER-->
1)A user can log in and make a reservation
2)An admin can log in and perform CRUD operations on a reservation or user or car.
3)A super admin can log in and perform CRUD operations on a reservation or user or car or admins.

A normal user can be created using "Sign Up" button. Password must ATLEAST BE 6 DIGITS, MUST have a letter and a digit.
After a user gets created (s)he can login using "Login" button.

After Logging in: 
A user can rent a car. (S)he can also filter the search for a car on the basis of "type", "location" and "Manufacturer".
After successful booking, a user can view the booking status on the "Home" page.
He/She can check out his reserved car or can return if already in use. 

BONUS:
The user can also ask to NOTIFY him/her automatically via email when a reserved car becomes available.
The user must click on NOTIFY on the "Make Reservation" page. After this, An automatic email is sent to him/her about the car availability when the user with the reserved car RETURNS the car.

ADMIN-->
View/Create/Update and Delete cars,reservations and users.
Can also add new admins.

SUPERADMIN-->
View/Create/Update and Delete admins,cars,reservations and users.
Can also add new superadmins.

LIST OF TESTS: (YES/NO with explanations wherever necessary)

1) Can an admin log in? 
YES
2) Can (s)he edit his profile name and password?
YES
3) Can (s)he log out?
YES

Checking the functionalities for admin below and see if they all work:

1) Can an admin create other admins?
YES
2) Can an admin view the list of other admins?
YES
3) Can an admin view the details (except password) of another admin?
YES
4) Can an admin check out a car for an user?
YES. After clicking RESERVE from the Make Reservation page.
5) Can an admin delete other admins other than him/herself and the preconfigured admin?
YES
6) Can (s)he view the reservation of a user?
YES

Checking the functionalities for admins below and see if they all work:

1) Can an admin view the list of all the users?
YES
2) Can an admin view the checkout history details (e.g. model, style, check out time, return time) of a user?
YES
3) Can an admin edit the details of a reservation or checkout history? - Admin should be able to edit pending reservations for a user.
NO

Checking the functionalities for users below and see if they all work:
1) Can a user sign up?
YES
2) Can (s)he log in after signing up?
YES
3) Can (s)he edit his/her profile name and password?
YES
4) Can (s)he log out?
YES

Checking the functionalities for users below and see if they all work:

1) Can a user search cars using keywords?
SEARCH CAN BE DONE BY APPLYING FILTERS
2) Can a user view the attributes of a car?
YES
3) Can a user reserve or check out a car?
YES
4) Can a user return a checked-out car?
YES
5) Can a user view his/her own checkout history?
YES
6) Can (s)he cancel a pending reservation?
NO

The admin should be able to delete a car from the system. Checking the functionalities for admin below:

1) Can an admin delete a car from the system?
YES
2) See what happens to the reservation attached to the car. Is it intuitive or, otherwise, described in the README file?
-
3) See what happens when a car that is not yet returned is deleted. Will the system allow such deletions? Is it intuitive or described in the README file?
-
4) What happens to the checkout history of a user when one of the cars (s)he once checked out is deleted? Is it intuitive or described in the README file?
-
The admin should be able to delete a user. Checking the functionalities for admin below:
1) Can an admin delete a user?
YES
2) See what happens to the history of the checkouts and reservations. Is it intuitive or described in the README file?
-
3) See what happens when a user who currently checked out a car is deleted. Will the system allow such deletions? Is it intuitive or described in the README file?
-

Extra Features Checking:
1) Can a customer register to receive a notification email when the car becomes available?
YES. The user must click on NOTIFY on the "Make Reservation" page. After this, An automatic email is sent to him/her about the car availability when the user with the reserved car RETURNS the car.
2) Can an admin view and approve the suggestion from customer that add they a new car to the system?
-
