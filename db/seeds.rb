#  this is where you put in values that you want in the database when created. 
# run 'rake db:seed'
Role.create([{title: 'Volunteer'}, {title: 'Employee'}, {title: 'Administrator '}])
User.create ({name: "Admin", email: "admin@releash.com", password: "password", password_confirmation: "password", role_id:3})
Species.create([{kind: 'Dog'}, {kind: 'Cat'}])
Characteristic.create(
	[
		{category: "Behavior", name: 'Fearful'}, {category: "Behavior", name: 'Good with Cats'},{category: "Behavior", name: 'Good with children'},
		{category: "Behavior", name: 'Housebroken'},{category: "Behavior", name: 'Social'},
		{category: "Attribute", name: 'Declawed'},{category: "Attribute", name: 'House Trained'},{category: "Attribute", name: 'Special Needs'}
	])
Breed.create([{name: 'Australian Cattle', species_id:1}, {name: 'Australian Shepherd', species_id:1},
			
			{name: 'Bearded Collie', species_id:1}, {name: 'Beauceron', species_id:1}, {name: 'Bergamasco', species_id:1},
			
			{name: 'Berger Picard', species_id:1}, {name: 'Border Collie', species_id:1}, {name: 'Bouvier des Flandres', species_id:1},
			
			{name: 'Briard', species_id:1}, {name: 'Canaan Dog', species_id:1}, {name: 'Cardigan Welsh Corgi', species_id:1},
			
			{name: 'Collie', species_id:1}, {name: 'Entlebucher Moutain', species_id:1}, {name: 'Finnish Lapphund', species_id:1},
			
			{name: 'German Shepherd Dog', species_id:1}, {name: 'Icelandic Sheepdog', species_id:1}, {name: 'Miniature American Shepherd', species_id:1},

			{name: 'Norwegian Buhund', species_id:1}, {name: 'Old English Sheepdog', species_id:1}, {name: 'Pembroke Welsh Corgi', species_id:1},

			{name: 'Polish Lowland Sheepdog', species_id:1}, {name: 'Puli', species_id:1}, {name: 'Pumi', species_id:1},
			
			{name: 'Pyrenean Sheepdog', species_id:1}, {name: 'Shetland Sheepdog', species_id:1}, {name: 'Spanish Water Dog', species_id:1},
			#End of Herding Group                      Start of Hound Group
			{name: 'Swedish Vallhund', species_id:1}, {name: 'Afghan Hound', species_id:1}, {name: 'American English Coonhound', species_id:1},
			
			{name: 'American Foxhound', species_id:1}, {name: 'Basenji', species_id:1}, {name: 'Basset Hound', species_id:1},

			{name: 'Beagle', species_id:1}, {name: 'Black and Tan Coonhound', species_id:1}, {name: 'Bloodhound', species_id:1},
			
			{name: 'Bluetick Coonhound', species_id:1}, {name: 'Borzoi', species_id:1}, {name: 'Cirneco Dell’Etna', species_id:1},
			
			{name: 'Dachshund', species_id:1}, {name: 'English Foxhound', species_id:1}, {name: 'Greyhound', species_id:1},
			
			{name: 'Harrier', species_id:1}, {name: 'Ibizan Hound', species_id:1}, {name: 'Irish Wolfhound', species_id:1},

			{name: 'Norwegian Elkhound', species_id:1}, {name: 'Otterhound', species_id:1}, {name: 'Petit Basset Griffon Vendeen', species_id:1},
			
			{name: 'Pharaoh Hound', species_id:1}, {name: 'Plott', species_id:1}, {name: 'Portuguese Podengo Pequeno', species_id:1},

			{name: 'Redbone Coonhound', species_id:1}, {name: 'Rhodesian Ridgeback', species_id:1}, {name: 'Saluki', species_id:1},

			{name: 'Scottish Deerhound', species_id:1}, {name: 'Sloughi', species_id:1}, {name: 'Treeing Walker Coonhound', species_id:1},
			#End Hound Group                 Start Toy Group
			{name: 'Whippet', species_id:1}, {name: 'Affenpinscher', species_id:1}, {name: 'Brussels Griffon', species_id:1},
			
			{name: 'Cavalier King Charles Spaniel', species_id:1}, {name: 'Chihuahua', species_id:1}, {name: 'Chinese Crested', species_id:1},

			{name: 'English Toy Spaniel', species_id:1}, {name: 'Havanese', species_id:1}, {name: 'Italian Greyhound', species_id:1},
			
			{name: 'Japanese Chin', species_id:1}, {name: 'Maltese', species_id:1}, {name: 'Manchester Terrier', species_id:1},
			
			{name: 'Miniature Pinscher', species_id:1}, {name: 'Papillon', species_id:1}, {name: 'Pekingese', species_id:1},

			{name: 'Pomeranian', species_id:1}, {name: 'Poodle (Toy)', species_id:1}, {name: 'Pug', species_id:1},
			
			{name: 'Shih Tzu', species_id:1}, {name: 'Silky Terrier', species_id:1}, {name: 'Toy Fox Terrier', species_id:1},
			#End toy group                              Start Non sporting group
			{name: 'Yorkshire Terrier', species_id:1}, {name: 'American Eskimo Dog', species_id:1}, {name: 'Bichon Frise', species_id:1},

			{name: 'Boston Terrier', species_id:1}, {name: 'Bulldog', species_id:1}, {name: 'Chinese Shar-Pei', species_id:1},
			
			{name: 'Chow Chow', species_id:1}, {name: 'Coton De Tulear', species_id:1}, {name: 'Dalmatian', species_id:1},
			
			{name: 'Finish Spitz', species_id:1}, {name: 'French Bulldog', species_id:1}, {name: 'Keeshond', species_id:1},

			{name: 'Lhasa Apso', species_id:1}, {name: 'Lowchen', species_id:1}, {name: 'Norwegian Lundhund', species_id:1},
			
			{name: 'Poodle', species_id:1}, {name: 'Schipperke', species_id:1}, {name: 'Shiba Inu', species_id:1},
			
			{name: 'Tibetan Spaniel', species_id:1}, {name: 'Tibetan Terrier', species_id:1}, {name: 'Xoloitzcuintli', species_id:1},
			#End Non-sporting group                 Start sporting group
			{name: 'American Water Spaniel', species_id:1}, {name: 'Boykin Spaniel', species_id:1}, {name: 'Brittany', species_id:1},
			{name: 'Chesapeake Bay Retriever', species_id:1}, {name: 'Clumber Spaniel', species_id:1}, {name: 'Cocker Spaniel', species_id:1},
			{name: 'Curly-Coated Retriever', species_id:1}, {name: 'English Cocker Spaniel', species_id:1}, {name: 'English Setter', species_id:1},

			{name: 'English Springer Spaniel', species_id:1}, {name: 'Field Spaniel', species_id:1}, {name: 'Flat-Coated Retriever', species_id:1},
			{name: 'German Shorthaired Pointer', species_id:1}, {name: 'German Wirehaired Pointer', species_id:1}, {name: 'Golden Retriever', species_id:1},
			{name: 'Gordon Setter', species_id:1}, {name: 'Irish Red and White Setter', species_id:1}, {name: 'Irish Setter', species_id:1},

			{name: 'Irish Water Spaniel', species_id:1}, {name: 'Labrador Retriever', species_id:1}, {name: 'Lagotto Romagnolo', species_id:1},
			
			{name: 'Nova Scotia Duck Tolling Retriever', species_id:1}, {name: 'Pointer', species_id:1}, {name: 'Spinone Italiano', species_id:1},
			{name: 'Sussex Spaniel', species_id:1}, {name: 'Vizsla', species_id:1}, {name: 'Weimaraner', species_id:1},

			{name: 'Welsh Springer Spaniel', species_id:1}, {name: 'Wirehaired Pointing Griffon', species_id:1}, {name: 'Wirehaired Vizsla', species_id:1},
			#Start Terrier Group
			{name: 'Airedale Terrier', species_id:1}, {name: 'American Hairless Terrier', species_id:1}, {name: 'American Staffordshire Terrier', species_id:1},
			{name: 'Australian Terrier', species_id:1}, {name: 'Bedlington Terrier', species_id:1}, {name: 'Border Terrier', species_id:1},

			{name: 'Bull Terrier', species_id:1}, {name: 'Cairn Terrier', species_id:1}, {name: 'Cesky Terrier', species_id:1},
			{name: 'Dandie Dinmont Terrier', species_id:1}, {name: 'Glen of Imaal Terrier', species_id:1}, {name: 'Irish Terrier', species_id:1},
			{name: 'Kerry Blue Terrier', species_id:1}, {name: 'Lakeland Terrier', species_id:1}, {name: 'Manchester Terrier', species_id:1},

			{name: 'Miniature Bull Terrier', species_id:1}, {name: 'Miniature Schnauzer', species_id:1}, {name: 'Norfolk Terrier', species_id:1},
			{name: 'Norwich Terrier', species_id:1}, {name: 'Parson Russell Terrier', species_id:1}, {name: 'Rat Terrier', species_id:1},
			{name: 'Russell Terrier', species_id:1}, {name: 'Scottish Terrier', species_id:1}, {name: 'Sealyham Terrier', species_id:1},
			{name: 'Skye Terrier', species_id:1}, {name: 'Smooth Fox Terrier', species_id:1}, {name: 'Staffordshire Bull Terrier', species_id:1},
			{name: 'Welsh Terrier', species_id:1}, {name: 'West Highland White Terrier', species_id:1}, {name: 'Wire Fox Terrier', species_id:1},
			#Start Working Group
			{name: 'Akita', species_id:1}, {name: 'Alaskan Malamute', species_id:1}, {name: 'Anatolian Shepherd Dog', species_id:1},
			{name: 'Bernese Mountain Dog', species_id:1}, {name: 'Black Russian Terrier', species_id:1}, {name: 'Boerboel', species_id:1},
			{name: 'Boxer', species_id:1}, {name: 'Bullmastiff', species_id:1}, {name: 'Cane Corso', species_id:1},

			{name: 'Chinook', species_id:1}, {name: 'Doberman Pinscher', species_id:1}, {name: 'Dogue de Bordeaux', species_id:1},
			{name: 'German Pinscher', species_id:1}, {name: 'Giant Schnauzer', species_id:1}, {name: 'Great Dane', species_id:1},
			{name: 'Great Pyrenees', species_id:1}, {name: 'Greater Swiss Mountain Dog', species_id:1}, {name: 'Komondor', species_id:1},

			{name: 'Kuvasz', species_id:1}, {name: 'Leonberger', species_id:1}, {name: 'Mastiff', species_id:1},
			{name: 'Neapolitan Mastiff', species_id:1}, {name: 'Newfoundland', species_id:1}, {name: 'Portuguese Water Dog', species_id:1},

			{name: 'Rottweiler', species_id:1}, {name: 'Samoyed', species_id:1}, {name: 'Siberian Husky', species_id:1},
			
			{name: 'Standard Schnauzer', species_id:1}, {name: 'Tibetan Mastiff', species_id:1}, {name: 'St. Bernard', species_id:1},
			#others
			{name: 'Azawakh', species_id:1}, {name: 'Belgian Laekenois', species_id:1}, {name: 'Dogo Argentino', species_id:1},

			{name: 'Grand Basset Griffon Vendeen', species_id:1}, {name: 'Nederlandse Kooikerhondje', species_id:1}, {name: 'Norrbottenspets', species_id:1},
			
			{name: 'Peruvian Inca Orchid', species_id:1}, {name: 'Portuguese Podengo', species_id:1}])


