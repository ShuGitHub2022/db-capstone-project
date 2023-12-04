# db-capstone-project
This project is Meta Database Engineer course final capstone project. 
# Scenario
Little lemon need to set up a booking system to keep track of which guests are visiting the restaruant and at what times. I need to:

    Set up a repository, or local directory to house the code.  
    Record all changes made within the system as they are implemented.  
    Allow other to view, review and add to my code.

How to use Git to set up a repository:
Initialize the repo using:

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

END

