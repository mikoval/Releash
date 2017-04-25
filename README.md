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

Optional
User’s Guide Information

Dashboard
Animals
People
In the People page, you can create new:
Users
	Users have typ
Upcoming Events

What are Non Users?
Non Users are accounts but they cannot log-in. Only Admins can add Non-User accounts. These accounts were made so that they can be fosters and/or adopters of animals. 
At the time of creation of these accounts, they have the same attributes as a regular user except a password.
If you want to make them available as a Foster and/or Adopters, Navigate to People → Click Edit on the desired Non-User → Once on the edit page click on the check boxes for Foster and/Adopter
Now they are added to the Foster and/or Adopter Table
Animal Tracking Manual
Tracking is divided into Status, Sub-Status and Marketing
Where can I change the current Status?
In the Animal Edit Page
Also, all the new Entry modals (pop - up) for each respective status by clicking the “Make current Entry”. This will change the current status and sub-status.
Statuses are: 
Intake
This is when the animal first comes into the organization
Foster
This is when the animal is in Foster Care
In Training
This is when animal is in care of a Trainer
Vetting
This is when the animal is at a vet for some medical condition
With Adopter
Animal is with adopter
Sub-Statuses:
The sub-statuses don’t have any attributes related to them, they work like flags to let you know something is wrong/needed with the animal.
Current sub-statuses are: Medical, Transfer, Foster to Adopt, Pending Application, Not Available, Pending Contract, Boarding
What is Marketing?
Marketing options are where you stand in marketing the animal. This can be changed in the Basic Characteristic section of the Animal’s Page
Current Marketing Options are: Need Pic/Bio, Not Online, Web & PF, Web Only, Needs Updates
What can I do with Tracking
With tracking you can go in each status by clicking on their respective tabs to add entries. When you first add an animal you can only add one entry per status.
You must select a status when you first add an animal and must select a Marketing Status
When first adding an animal if you just select the current status and/or substatus without selecting anything the tracking portion, an empty entry with Today’s date will be added so you can go back and edit it later
Once the animal is added, you can go back in the Edit page and add more. So if there are multiple events and/or changes while in a certain status you can keep track of it.
There are tabs for all the Statuses in the Animal’s Profile page in Tracking Tab, there is also a All tab which shows all the events for an Animal (essentially their whole history)
Veterinarians, Trainers, Animal Facilities can be added in the People Page.
Animal Filtering Manual
Filtering can be done with Name, Breed, Status, Age, and Visibility.
Filtered result is automatically sorted by Sub-Status and Status
Filtered list of animals can be downloaded into a clearly formatted CSV file for later use.
Same results can be re-generated by copy and pasting the url after filtering is done.
