Script reads necessary variables from yaml file.
	Finds all emails sent from given sender and gets email date.
	Converts all necessary dates to UTC. 
	Checks if email date is between earliest time( date after the email must be arrived ) and latest time ( date before what the email must be arrived). 
	If email date is between earliest and latest time, then program loops through every line in email and also loops through words, that are needed to find.
	If line includes words then prints lines and increases number_failed if the number at the end of line is bigger than 0.

	if number_failed is not 0 then program returns 1 and if it is 0 then returns 0.  
