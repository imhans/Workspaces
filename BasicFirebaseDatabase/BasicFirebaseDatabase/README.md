#  Basic Firebase Database in Swift

### Set-Up Process
1. Create Xcode project(App)
2. Create Firebase Project
3. Register the Swift app on Firebase console using Bundle Id
4. Add Firebase to the app (SDK/CocoaPods)
    1. Insert Info.plist into the root of Xcode project
    2. Add package dependency
5. Add AppDelegate.swift in order to connect Firebase when the app starts up

<https://console.firebase.google.com/project/basicdatabase-b62af/overview>


### Functions
## Create
1. Enter user information: Username, First Name, Last Name
2. Press +Add button to create a new user into the list and database
3. Alert pops up if no info is entered

## Read
1. The app automatically reads the changes of data and immediately recreate the view
2. Reflects Added/Changed/Removed data in database

## Update
1. Select a user(row) in the list and then get to the User Edit Page for the selected user 
2. Any changes of user information directly updates data in database
3. Back button navigates back to the main page(Users)

## Delete
1. Swipe left a row of the list and press the Delete button


