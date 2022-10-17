## Local Development Setup

Clone this repo by running `git clone https://github.com/sahilLikes2Code/simply-coach-assignment.git`.

Install [ruby](https://www.ruby-lang.org/en/) version `v2.7.2` which is specified inside the `.ruby-version` file.

```bash
bundle install
```

Start the server by executing either of the following commands:

```bash
bundle exec rails server
```
or
```bash
./bin/dev
```
If you intended to make play around with tailwind-css classes and want them reloaded without re-starting the app repeatedly.

Visit http://localhost:3000 and verify everything is working fine.

## Features

### Registering a new user

![enter image description here](https://user-images.githubusercontent.com/40363532/196241030-7535d1a5-8382-41d1-800a-a3bf4c107d95.png)
Visit http://localhost:3000/sign_up and you will be prompted with a registration form which requires 4 mandatory fields including: 

**1. Name**

	-Must be present.
	-Must be 3 or more characters long.
	
**2. Email**

	-Must be present.
	-Must be valid 
	
	It should have a **prefix** and a **domain**
	
	The  **prefix**  appears to the  **left**  of the @ symbol.
	The  **domain**  appears to the  **right**  of the @ symbol.
	
	For example, in the address  'example@mail.com', "example" is the
	email prefix, and "mail.com" is the email domain.
**3. Password**

	-Must be present.
	-Must be 6 or more characters long.
**4. Password confirmation**

	-Must be present.
	-Must match value input in Password field.

### Logging in an existing user

![enter image description here](https://user-images.githubusercontent.com/40363532/196241221-ab115ecd-4e34-47ed-a4de-7918ad9fe69e.png)
Visit http://localhost:3000/login and you will be prompted with a login form which requires 2 fields including: 

**1. Email**

**2.Password**

	Note: New users upon successful registeration will be
	automatically logged in. Subsequent logins will require a valid
	email and password combination.


After a user has successfully registered and logged in, they will be redirected to http://localhost:3000/tasks root url. 

![enter image description here](https://user-images.githubusercontent.com/40363532/196241306-da5d047f-2375-48d3-9145-25bfe5325b71.png)

### Creating a new task

![enter image description here](https://user-images.githubusercontent.com/40363532/196241546-fc78d012-5610-4185-a509-57e61223b520.png)

After logging in, a user can create a new task by either visiting http://localhost:3000/tasks/new or by clicking the 'New Task' button which redirects to a form with two fields both of which are mandatory including:

*1. Name* 

	Should be atleast 3 characters long
	
*2.Due Date*

After creating a new task, the user is redirected to http://localhost:3000/tasks page which displays a list of all tasks.
![enter image description here](https://user-images.githubusercontent.com/40363532/196242276-8cc4aed6-c808-4cc8-8d76-c4285bcaf8a8.png)

After one or more tasks have been created, a section with *Original due date* is displayed with "Green" representing future due date and "Red" representing due date was in the past. 

The due date is displayed in respective colour right next to the task name in the list. Note: The coloured date doesn't signify whether a task has been completed or overdue. 

Tasks that have been marked complete by clicking the *pencil* icon and selecting a check box followed by updating are strike through to visually differentiate between complete and pending tasks.

### Editing/updating an existing task
![enter image description here](https://user-images.githubusercontent.com/40363532/196243701-8131f312-9764-433a-b983-67fbc41e2dfb.png)

In order to edit an existing task, the user can visit http://localhost:3000/tasks/:task_id/edit replace id with a valid task_id or by clicking the pencil icon of a respective task from list displayed on http://localhost:3000/tasks . One distinguishing feature present on this page is a checkbox with label completed, all newly created tasks are marked due by default.

### Deleting a task

Similar to the pencil icon used to edit a task, the *trash* icon can be clicked to delete a task which also removes it from the page.

### Marking a task as complete
As previously mentioned, when a task has been marked complete from update task page, a line is struck through it. In addition, when one or more completed tasks are present, another section is visible on the page which
![enter image description here](https://user-images.githubusercontent.com/40363532/196245214-5affed97-b32a-4604-b70f-ea4b3c2f67d1.png)

### Logging out a logged in user

The **Log Out** button displayed on top right of page when a user is logged in can be used to terminate the session. Clicking the button, logs out the user and redirects to **Login** page.

### Redirecting logged in users visiting http://localhost:3000/login or http://localhost:3000/sign_up

Logged in users who accidentally or intentionally visit, either of the urls mentioned above are automatically redirected to http://localhost:3000/tasks preventing any clash of session with existing user.

### Easter egg: Api to find max contiguous subarray from an array
![enter image description here](https://user-images.githubusercontent.com/40363532/196246539-41933e6a-9f58-4384-bcd4-abd9327e7c95.png)
The app also comes with an api that allows to find max contiguous subarray from an array which can be accessed by visiting http://localhost:3000/easter_egg. The input field takes an **array** of size greater than 1 such as '[3,9]'.

The array can have negative and positive integer values and finds the longest continuous array that has the highest sum. The response returned is of type json with keys either **max_sub_array** or **error** with first one having the max contiguous subarray or 'invalid input' error. 