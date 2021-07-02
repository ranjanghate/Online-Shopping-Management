# README

### Versions

 - RVM - 1.29.12 
 - Ruby - 3.0.0
 -  Rails - 6.1.3 
 - PostgreSQL - 12.6
 - git -2.25.1 
  - yarn - 1.22.5

### System dependencies
Add this following gems in your Gemfile 

   - **pg** -> Use postgresql as the database for Active Record

   - **sass-rails** -> Use SCSS for stylesheets

   - **bcrypt** -> Use Active Model has_secure_password

   - **bootstrap** -> For bootstrap integration to your rails application

   - **jquery-rails** -> For jquery integration to your rails application


### Configuration

  * **Installing RVM**
  
	 Run this command in your terminal to install stable version of RVM      
			

		$ \curl -sSL https://get.rvm.io | bash -s stable

* **Installing Ruby**
    
    Run this command in your terminal to install ruby
    

		 $ rvm install ruby_version ( put ruby version number in place of ruby_version)

 * **Installing Postgresql**
    
    Create the file repository configuration:

        sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt$(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

	Import the repository signing key:
	
	     $ wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc|sudoapt-key add -
	     $ Update the package lists:
	     $ sudo apt-get update

    Install the latest version of PostgreSQL.

	    $ sudo apt-get -y install postgresql

  * **Installing Git**

		 $ sudo apt install git-all

  * **Installing Yarn**
    
    Run the below command to enable yarn repository 

	    $ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

    Add the Yarn APT repository to your system
    
		$ echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

    Install Yarn
    
	    $ sudo apt update
	    $ sudo apt install yarn

  
### Cloning application
   
   Run the command to clone the git repo to your local

       $ git clone https://github.com/ranjanghate1/demo_application.git

### Database creation
  Run this command to create database (rails is the name of database) 
    

    CREATE DATABASE rails;

### Database initialisation
  Run this command to initialise the database

      $ initdb -D /usr/local/pgsql/data

### Setup rails Application
  Run following commands in rails application's folder
  
  Install gem required by the application

     bundle install

  Execute the database migration

    bundle exec rake db:setup

  Run rails server

    $ rails server

   Goto http://localhost:3000/ to check your  application

### Deployment instructions
Sign Up on heroku https://signup.heroku.com/

  Install heroku CLI
  
     $ sudo snap install --classic heroku

  Create heroku application

      $ heroku create

  To pull from github and deploy on heroku

      $ git push heroku master

  After that copy and save the URL generated from the terminal

  Create the database on heroku server

      $ heroku run rake db:migrate

### Heroku Application Link 
  [https://demoappgamma.herokuapp.com/ ](Application%20link)
