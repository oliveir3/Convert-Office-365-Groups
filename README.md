# Convert-Office-365-Groups

Convert Unified Groups to Distribution Lists [Data Loss Warning!]

I recently got a lot of requests for converting Unified Groups (New Office365 Groups) back to Distribution lists. There is an option in the Exchange Admin Center to convert Distribution lists to New Office 365 Groups. That’s a nice option however …… what if Unified Groups are not the right option for my tenant. How do I convert this back to a distribution list?

About the Script:

The only way to do this is to get a list of members from the Unified Group > delete the Unified Group and then create new Distribution Lists with those members.
This can be quite a Task!
Feel free to use this script to automate that process of converting Unified Groups back to Distribution Lists.
Remember the warning in the Title about DATA LOSS. I have added this warning because when a Unified Group is created there is a Calendar, OneNote, SharePoint Online site and a OneDrive for business Storage added to it. If your users start using this feature, then the data within those locations will be deleted.
I suggest having a chat with your end users before executing this script to see if they have data in those locations. Back up the data before executing the script. 
 
Script Execution:

Once you run the script you will be prompted with 2 choices:

•	One Group: use this if you want to just convert one Unified group to a Distribution List (Good for testing)

•	All Groups: use this if you want to convert all Unified Groups to Distribution Lists

NOTE: I have added a 30 second sleep action in the script to give time for the Unified Groups to get deleted. If you get any errors for a few groups, it is because those groups need more time to get deleted before the distribution lists get created. You can restore those Deleted Unified Groups from the Portal and then re-run the script for those individual groups. 
The Distribution list will use the PrimarySmtpAddress attribute of the Unified Group to get created.

About the Script. (how does it work):

To get a breakdown of the script and find out how the script works feel free to visit my blog Post: https://o365inside.com/uncategorized/convert-unified-groups-back-to-distribution-lists/
