# cmsc-23-project-PERSEUS-1337

## Author
Aron Resty Ramillano
2020-01721
CMSC 23 - D3L

## App Description
The project is a Flutter mobile application composed of a sign in, sign-up and a shared todo list features with a user’s friends. The database that will be used is Firebase.

## Features

 - **Sign-up**
	 - 
	 - When signing-up, the user must provide the following:
		 - Name
		 - Birthdate
		 - Location
		 - Username
		 - Password
	 - Must have a validator for each field
	 - Username should be unique
	 - Password must be at least 8 characters long with at least a number, a special character, and both uppercase and lowercase letters.
	 - ID is auto-generated.
 - **Login/Logout**
	 - 
	 - User Firebase Authentication using username and password.
	 - Must have a validator for each field.
- **User Profile**
	- 
	- Shows the ID, Name, Bdate, Location, and Bio
 - **Friend Feature**
	 - 
	 - Must show the list of friends and friend requests.
	 - The profile is composed of ID, Name, Bdate, Location, and Bio.

 - **Shared Todo**
	 - 
	 - All friends can see your todo and you can also see your friend’s todo list.
	 - Add a todo.
		 - Only the owner can create a todo.
		 - Composed of Title, Description, Status, Deadline, Notifications.
	 - Edit todo
		 - User and friends can edit the todo, must show the name of last edit and timestamp.
	 - Delete todo
		 - Only the owner can delete a todo.
	 - Status Change
		 - Only owner can change the status.

## Project Schedule
After the discussions in the laboratory, you are required to start with the project. Here is the table schedule with expected minimum output for the milestones. These milestones will be checked during lab hours. Each milestone is equivalent to 5 points for the project.
| Date | Milestone | Minimum Expected Output
|--|--|--|
| 21 Nov - 25 Nov | Milestone 01 | Create firebase, fetch/add information in firebase |
| 28 Nov - 02 Dec | Milestone 02 | UI and Navigation |
| 05 Dec - 09 Dec | Milestone 03 | Add, Search, Todo |
| 12 Dec - 14 Dec | Finalize Project

## Project Deadline
The deadline for the project is on December 14, 2022, Wednesday. All changes after the said date will not be considered.
The start of the project presentation is on December 15,2022 until December 21, 2022, during laboratory hours.

## Project Grading Scale
Here is the table for the point equivalents for each feature
| # | Feature | Points
|--|--|--|
| 1 | Signup, Login, Logout via Firebase | 10 points
| 2 | Add, View, and Search Friends | 30 points
| 3 | Shared Todo List | 25 points

## Screenshots

<img src="../screenshots/login.png">
<img src="../screenshots/signup.png">
<img src="../screenshots/homepage.png">
<img src="../screenshots/users.png">
<img src="../screenshots/friends.png">
<img src="../screenshots/friendrequest.png">
<img src="../screenshots/drawer.png">
<img src="../screenshots/todopage.png">
<img src="../screenshots/todoedit.png">
<img src="../screenshots/todoadd.png">

## Things you did in code (logic , solutions)
The first thing I thought of was trying to make my app look good without too much effort. This is where the terminal-based design came in because, I was also spending much of my time staring at terminals because of CMSC 124 and CMSC 125 and especially in Linux, that it felt right to use that kind of design and, it worked out great. It looked really good and simple.

I implemented a way to reuse the code in such a way that it uses switch cases to determine when to render something based on a given stream. For example, I first determined which different streams I would use for my main page, which is where the main user, the other users, and the friends will be shown. Since there are three main streams that will be used, it would not be good for me to just copy paste code just to accommodate the three. Instead I tried to integrate them into one with the code being reusable as much as possible, thus reducing the lines and making my code cleaner, and more standardized.

I used the same philosophy when implementing my todopage. Same style for the main user and the other user's todo, with just adjustments to whether or not it is a user's todo or another's todo.

Another thing is that, for my firebase Api's, providers, it is where the magic happens too since clever querying and usage of flutter Bases features helped me achieve the features that I thought was impossible, or very complicated to deal with in the future. Especially the filtering of the users, firebase's commands came in clutch
## Challenges faced when developing the app
Particularly the search. It is hard for me to wrap my head around how to return a certain user using a search query. It may have been because of time pressure also.
Second, it was hard for me to try and implement the "users" page that excludes people that is already added or had a friend request sent already.
Third, flutter's documentation on firebase is not that well documented in some parts, it's hard to see other commands and such that may definitely help my case and you need to scour hours on the internet to get that specific function.
Fourth, the notifications. I was not able to study them because of time constraints and it's really hard to cram those kinds of information into my brain when there is a lot to implement and to think of.

## Test Cases
No test cases because I was not able to implement the testing phase of the app
### Happy Paths
### Unhappy paths

# Resources

- https://www.topcoder.com/thrive/articles/form-validation-in-flutter
- https://firebase.flutter.dev/docs/auth/usage/
- https://blog.logrocket.com/how-to-add-navigation-drawer-flutter/#:~:text=The%20navigation%20drawer%20in%20Flutter,icon%20in%20the%20app%20bar.
- https://www.kindacode.com/snippet/dart-how-to-update-a-map/
- https://stackoverflow.com/questions/59268817/flutter-how-to-remove-a-specific-array-data-in-firebase#:~:text=Firestore%20does%20not%20provide%20a,to%20make%20the%20update%20atomic.
- https://firebase.flutter.dev/docs/firestore/usage/
- https://stackoverflow.com/questions/51400549/how-to-wrap-a-streambuilder-class-with-a-column-or-listview-class-in-flutter
- https://pub.dev/packages/syncfusion_flutter_datepicker
- https://mobikul.com/date-picker-in-flutter/#:~:text=DatePicker%20is%20a%20material%20widget,by%20calling%20flutter's%20inbuilt%20function.z
- https://www.fluttercampus.com/guide/39/how-to-show-date-picker-on-textfield-tap-and-get-formatted-date/
- https://devsheet.com/how-to-get-current-date-in-flutter-dart/
- https://api.flutter.dev/flutter/intl/DateFormat-class.html
- https://stackoverflow.com/questions/56253787/how-to-handle-textfield-validation-in-password-in-flutter