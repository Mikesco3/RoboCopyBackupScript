README: Robocopy Backup Script

This Script is basically just to copy content from one folder to the other.
The idea is that I can create a backup to mirror data from one or several 
sources to a destination.

What is special about this script is that the sources and destinations are set in two ini files and it can take multiple sources and each source can be named a certain backup task and then that folder gets created at the destination and the files copied over.

To set a source: 
 Edit the BackpOrig.ini file 
 Comments start with a # (lines starting with # will be ignored)
 then immediately after set a backup source name and it's path
 separated by a comma, for ex:

 Accounting,c:\users\Bob\Doccuments\Accounting Files

To set a destination:
 Edit BackpDest.ini file and enther the desired path where the files should be copied to. Lines that start with # are ignored, therefore useful for commenting the file.

Other than that, the script can either be run manually or set via scheduler.

I'd recommend for example setting a backup to occurr once a day for 6 days, so just copy the script into 6 folders (one for each day and rename the destination for each day)
then the same for weekly and monthly.