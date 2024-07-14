# komoot-assignment
iOS Developer Challenge

# #1 Preparations and Reading through the Challenge
The project should have a simple and minimal UI with some technical milestones:
-  Some sort of list to hold the images which updates itself
-  Access to the user's location, even in the background
-  Network access to a service which provides images based on input

The project could optionally maybe use some sort of short onboarding to communicate the request
of the location? Also, error handling could be good, since we have multiple points of failure
with the location request, the networking going wrong, or maybe not finding any results?

# #2 Project Setup and inital design
The project and app should not provide many options when it comes to the device it can run on and the orientations, 
which is why I disabled them from the beginning. For the first draft of the design, I chose a simple ScrollView to hold static images.