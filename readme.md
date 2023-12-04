# db-capstone-project
This project is Meta Database Engineer course final capstone project. 
# Scenario
Little lemon need to set up a booking system to keep track of which guests are visiting the restaruant and at what times. I need to:

    Set up a repository, or local directory to house the code.  
    Record all changes made within the system as they are implemented.  
    Allow other to view, review and add to my code.

How to use Git to set up a repository:

Create a new repository in my GitHub account, and name it db-capstone-project. 

Initialize the repo using in my local project directory.

    git init
Create a readme.md file 

    git add readme.md
because I created readme.md file directly in GitHub, so I skipped this step.

Next, point the directory toward my git repository by using the git remote add command along with the destination URL. 
To get the destination URL select the code icon in the repo and copy the HTTPS address.

    git remote add origin https://github.com/ShuGitHub2022/db-capstone-project.git
Verify the remote URL:

    git remote -v
    
Push my repository:

    git push -u origin master

Note when commit change we need to config user.email to connect to the GitHub account

git config --global user.email "user email address"

After push change to the repository, I can see the updated readme.md file in the master branch in my repository.

After set up Git repository, it's time to set up database in MySQL Workbench. 

Database Setup

Create a new user. This is the most secure way to connect to MySQL database, as I can manage user roles and priviliges.

Create an instance of a MySQL server. This can be done in the MySQL workbench home screen. In the home screen side panel, select MySQL connections option to view or create instances of MySQL.

Use connections option to load, configure, group and view information about each of my MySQL connections. Select "Users and Privileges" user the "Management" menu to view a list of current database users.

Use MySQL connection to begin working with database schemas and SQL queries.

Now it's time to build and manage the database. 

Create a new branch on local repository

    git checkout –B branchA
a new branch branchA was created and switched to the new branch.

Add the project folder to the stage:

    git add . # add all files 

Check the status:

    get status

Commit the changes:

    git commit -u origin branchA

Push the changes to the GitHub repository

    git push -u origin branchA

