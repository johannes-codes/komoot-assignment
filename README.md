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

# #3 Introduce Location Manager
The location manager holds the reference to the CLLocationManager and handles the beginning and end of tracking, as well as location access and state. The next step will be to calculate the distance between the updated locations and to send an event to the delegate once the threshold of 100 meters is passed.

# #4 Create Coordinator
I figured that a coordinator would be helpful for the communication between the location manager and the service that follows. The calculation for the distance was introduced, and for now, I've loaded the coordinates into the ScrollView to test UI and actual location update, both of which work.

# #5 Introduce Flicker Service
So I got my personal API key from Flickr and presumably called the right API. The response is unfortunately XML, which I'll need to parse in the next step.

# #6 Create custom XML parser for Flicker Response
Unfortunately, the Flickr API response is XML, which requires a custom parser instead of JSON. This has cost me a bit more time. Now the image URL is constructed, and in the next step, I'll attempt to load those images in the ScrollView.

# #7 Load images into ScrollView
The images are now loading into the scroll view with the help of Apple's great AsyncImage. The handlers for loading and error state are very minimal but are the starting point for a potential improvement in the future. I also found that some images appear twice, which is a bug that needs addressing.

# #8 Fix the Flicker Service for unique photos
The image service occasionally returned duplicated images. Since the ScrollView and for each operation relied on the image as an identifier, the duplicated images caused issues.

# #9 Register for Background activities
Register the app so it can receive location updates in the background and is allowed to make network calls so that images get loaded while the phone is locked. According to the settings, images should load in the background - but it seems, looking at the network logs, that they load once the app is active again. I will work on that at the end once I'm done with everything else.