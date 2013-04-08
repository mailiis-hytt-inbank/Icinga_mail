Download
--------
	https://github.com/mailiish/Icinga_mail


Introduction
------------

Icin_mail.rb  is a script to find out if email has given lines adn if they are correct.


How to use
----------

1. Open icin_mail.yaml and fill all necessary fields.
2. start icin_mail.rb
	Script reads necessary variables from yaml file, that have to be put in before using.
	Finds all emails sent from given sender and gets email date.
	Converts all necessary dates to UTC. 
	Checks if email date is between earliest time( date after the email must be arrived ) and latest time ( date before what the email must be arrived). 
	If email date is between earliest and latest time, then program loops through every line in email and also loops through words, that are needed to find.
	If line includes words then prints lines and increases number_failed if the number at the end of line is bigger than 0.
	If number_failed is not 0 then program returns 1 and if it is 0 then returns 0.  
