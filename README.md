# cmsc-23-project-PERSEUS-1337
## Author
Aron Resty Ramillano
2020-01721
CMSC 23 - D3L

## App Description
The project is a Flutter mobile application composed of a sign in, sign-up and a shared todo list features with a user’s friends. The database that will be used is Firebase.

### Features
 - **Sign-up**
	 -  When signing-up, the user must provide the following:
		- Name
		- Birthdate
		- Location
		- Username
		- Password
	- Must have a validator for each field
	-   Username should be unique
	-   Password must be at least 8 characters long with at least a number, a special character, and both uppercase and lowercase letters.
	-   ID is auto-generated.
- **Login/Logout**
	- User Firebase Authentication using username and password.
	-   Must have a validator for each field.
-   **User Profile**
	-   Shows the ID, Name, Bdate, Location, and Bio
-   **Friend Feature**
	-   Must show the list of friends and friend requests.
	-   When the user clicks one friend in the friends list, the profile should be shown.
	-   The profile is composed of ID, Name, Bdate, Location, and Bio.
-   **Search Friend**
	-   Search bar that finds users containing the search string. The user don’t necessarily need to type the whole username to find a match.
	-   Each output searched users must have an add friend button (unless the searched user is already a friend).
-   **Shared Todo**
	-   All friends can see your todo and you can also see your friend’s todo list.
	-   Add a todo.
		-   Only the owner can create a todo.
		-   Composed of Title, Description, Status, Deadline, Notifications.
	-   Edit todo
		-   User and friends can edit the todo, must show the name of last edit and timestamp.
	-   Delete todo
		-   Only the owner can delete a todo.
	-   Status Change
		-   Only owner can change the status.
	-   Todo Notifications
		-   Using notifications
		-   Bonus if connected to the phone calendar.

### Project Schedule
After the discussions in the laboratory, you are required to start with the project. Here is the table schedule with expected minimum output for the milestones. These milestones will be checked during lab hours. Each milestone is equivalent to 5 points for the project.

| Date | Milestone  | Minimum Expected Output
|--|--|--|
| 21 Nov - 25 Nov | Milestone 01 | Create firebase, fetch/add information in firebase




## Screenshots
<img  src="./images/Screenshot 2022-10-07 165850.png">

## Things you did in code (logic , solutions)

## Challenges faced when developing the app

## Test Cases

### Happy Paths

### Unhappy paths

# Resources
