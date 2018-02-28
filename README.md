# Tasktrackr2

## Design Decisions in tasktracker1:
	* Clicking submit on the registration page takes the user back to the login page
	* Clicking back on the registration page takes the user back to the login page
	* Login is done by Name only
	* On logging in, the first page that opens is the your assigned tasks page, here only those tasks can be
	  seen which have been assigned to the logged in(current user).
	* Only the person who has been assigned the task can edit and delete the task, the other users may only view the task 	in the 'All Tasks' page.
	* Time taken cannot be left empty while creating a task, some value needs to be entered, if beginning a task, enter 0 	to mark the beginning.
	* The task creator is also not allowed to edit or delete the tasks, only the assigned user may edit and delete and no one else.
	* Deleting of users is not allowed in the application.
	* On clicking "New User" on the "Your friends" page takes the user to registration page and then clicking on the submit button takes the user to login page.
	* Input of any number other than a multiple of 15 in the time taken field of a new/edit task would result in an error message of "Invalit input, not a multiple of 15".
	* Leaving the completed field empty means the task is incomplete.
	
## Design Decisions in tasktracker2:
	* The Profile page is empty for users who are not managers and thus, no underlings too.
	* Only those users can be managed who do not have a manager already
	* User cannot assign a task, unless he is the manager
	* The task report page is empty for the users who are not managers.
	* The add timeblock link is only available to the tasks where you are the manager or have been assigned the task
	* The add timeblock link is only available on the "your assigned tasks" page
	* Reloading is necessary to see the changes made in the add timeblocks page
	* Deleting the user would be reflected on reload.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
