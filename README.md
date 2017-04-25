# Releash
Release Notes version GoRescue 1.0

NEW FEATURES

Consistent styling across all pages
Ability to add new trainers and veterinarians
Animal Status Widget 	
Adoption applications can be added via profile

BUG FIXES

Behavior dropdown errors additions between profile and edit animal
Sidebar shifting mobile view and making pages unviewable
Uninitialized foster error from add animal to profile view

KNOWN BUGS

On mobile certain parts of application may not be responsive
Error visuals on tracking modals aside from intake not showing up properly
Fosters and Adopters cannot be removed

Install Guide  GoRescue 1.0

PRE-REQUISITES
 	You must Install Ruby on Rails version 5.0.1 or higher.  
	Windows and Mac OS:
		This link includes installation instructions
		http://railsinstaller.org/en

DEPENDENCIES
	No others besides Rails
DOWNLOAD
               git clone https://github.com/mikoval/Releash.git 
BUILD
	bundle install
	rake db:create
	rake db:migrate
	rake db:seed
	
  	
INSTALLATION
               
RUNNING APPLICATION

Open the command prompt or terminal. Navigate to the directory where the project folder is located. 
	cd Releash
Then in the command prompt or terminal enter the following lines pressing enter after each one	
	Navigate to the Releash directory
Launch command prompt or terminal and type “rails server” 
Open a web browser and enter the url given to you by the command prompt or terminal


User’s Guide Information

Dashboard
	The dashboard contains your widgets. Current the widgets available are List of Animals, List of Users, Status Count (Number of Animals in each status) and a list of assigned animals.

Animals
	In the Animals, page you will first see the list of Animals. You can filter this list in different ways. Filtering can be done with Name, Breed, Status, Age, and Visibility. Filtered result is automatically sorted by Sub-Status and Status. Filtered list of animals can be downloaded into a clearly formatted CSV file for later use. Same results can be re-generated by copy and pasting the url after filtering is done.
	You can also add new animals from here. 
	
	Animal Profile 
	
	In the animal's profile page you can edit an animal, view tracking, add/view alerts, and see a summary of the animals information.

	Tracking is divided into Status, Sub-Status and Marketing. You can change the current status in the Animal's edit page or through the respective modals in the tracking section by clicking the "Make Current Entry". This will change the current status and sub-status.

	The sub-statuses don’t have any attributes related to them, they work like flags to let you know something is wrong/needed with the animal.
	Current sub-statuses are: Medical, Transfer, Foster to Adopt, Pending Application, Not Available, Pending Contract, Boarding

	Marketing options are where you stand in marketing the animal. This can be changed in the Basic Characteristic section of the Animal’s Page
	Current Marketing Options are: Need Pic/Bio, Not Online, Web & PF, Web Only, 
	
	With tracking you can go in each status by clicking on their respective tabs to add entries. When you first add an animal you can only add one entry per status.
	You must select a status when you first add an animal and must select a Marketing Status
	
	When first adding an animal if you just select the current status and/or substatus without selecting anything the tracking portion, an empty entry with Today’s date will be added so you can go back and edit it later
	Once the animal is added, you can go back in the Edit page and add more. So if there are multiple events and/or changes while in a certain status you can keep track of it.
	
	There are tabs for all the Statuses in the Animal’s Profile page in Tracking Tab, there is also a All tab which shows all the events for an Animal (essentially their whole history)

	You can also track adoption applications in the Adoption application section. You can copy and paste the application or upload a document.


People

	In the People page, you can create new:
	Users, Non Users, Veterinarians, Trainers and Animal Facilities
	Users can be Administrators, Coordinators or Volunteers. 

	Non Users are accounts but they cannot log-in. Only Admins can add Non-User accounts. These accounts were made so that they can be fosters and/or adopters of animals. 
	At the time of creation of these accounts, they have the same attributes as a regular user except a password.
	If you want to make them available as a Foster and/or Adopters, Navigate to People → Click Edit on the desired Non-User → Once on the edit page click on the check boxes for Foster and/Adopter

Upcoming Events
