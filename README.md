
# **Software Design Description: App**

## Introduction
The application is created using the cross-platform framework Flutter, which allows an application to work in Android as well as IOS. Flutter uses the programming language dart, which is object-oriented and means that the app is modeled with classes. Furthermore, the app makes use of the Model View ViewModel (MVVM) design pattern. *Figure 1* displays the logic of MVVM design pattern.  


![App Design Pattern](https://github.com/Team-Tools-JU/mobile-app/blob/main/Design%20pattern.png)    
###### Figure 1: *MVVM design pattern*  



This makes it possible to abstract the view and thus reduces the amount of business logic required in the code behind it. It also makes it easier to test the ViewModel without any interaction from the view. *Figure 2* shows how the MVVM design pattern is structured in this project. With the names and details on which views are making use of the navigation view.


![App Design Pattern](https://github.com/Team-Tools-JU/mobile-app/blob/main/Design-Pattern-mobileApp.PNG)

###### Figure 2: *The applications implementation of MVVM design pattern*

## Dependencies 
This application is using multiple dependencies that makes the application work

* [Stacked](https://pub.dev/packages/stacked)
* [Material](https://pub.dev/packages/material)
* [Flutter Blue](https://pub.dev/packages/flutter_blue)
* [Get It](https://pub.dev/packages/get_it)
* [Lite Rolling Switch](https://pub.dev/packages/lite_rolling_switch)
* [Signal Strength Indicator](https://pub.dev/packages/signal_strength_indicator)
* [Font Awsome](https://pub.dev/packages/font_awesome_flutter)
* [Math](https://api.flutter.dev/flutter/dart-math/dart-math-library.html)
* [Android Intent](https://pub.dev/packages/android_intent)



## Models 


### Bluetooth
This class handles all bluetooth functionality and implements the interface BluetoothInterface. 
The class makes use of the package [FlutterBlue](https://pub.dev/packages/flutter_blue) 

#### FlutterBlue flutterBlue :
An instance of the FlutterBlue class.

#### BluetoothDevice selectedDevice :
The bluetooth device selected for connection.

#### BluetoothCharacteristic readChar :
The bluetooth characteristic for reading.

#### BluetoothCharacteristic writeChar :
The bluetooth characteristic for writing.

#### StreamController<String> reciever :
A StreamController for broadcasting incoming message.

#### bool isConnected :
Returns a bool informing if a connection is established to the selected bluetooth device.

#### Future<void> connect() async :
Attempts a connection to the selected device.

#### Future<List<BluetoothDevice>> scan(Duration duration) async :
Scans for devices over the duration specified. Returns a Future containing the list of said devices.
  
#### Future<void> disconnect() async :
Disconnects from the selected device.

#### Future<void> write(String message) async :
Encodes and writes the passed string using writeChar.

#### Future<void> listen() async : 
Listens for incoming messages using readChar.
  
  
### NavigationController
This very simple class is used to keep track of the current page selected in the navigation view.

#### int currentIndex :
The index corresponding to the current page.

### AndroidService
This class handles all android-specific service implementations.
  
#### Future<void> openLocationSetting() async :
Opens the location settings for the android device.

#### Future<void> openBluetoothSetting() async :
Opens the bluetooth settings for the android device.

  
### SettingsController
This simple class keeps track of settings between different views.
  
#### StreamController<bool> steeringEnabled :
A StreamController broadcasting when the current setting of manual steering is changed.
  
  
## Views
  
### HistoryView
This view displays previous mower session paths, including collision events.

### NavigationView
This view navigates to the different views depending on the user interaction.
  
### SettingsView
This view presents the user with the option to toggle manual steering and simulation mode.

### StartView
This view is the first view the user interacts with, who tries to connect to the mower.  
 
### SteeringView
This view displays steering options for the user and a collision indicator.  


## View Models
  
  
### HistoryViewModel
This viewModel handles the data recieved from the backend.
  
#### getPositions() :  
This function retrieves vectors from the backend and transform these into coordinates, that will be displayed as a path on the view. 
  
#### setSessionName() :
This function updates the mower session.
  
  
### NavigationViewModel
This viewModel keeps track on the current view index and can therefore navigate to the right view.
  
#### updateBluetoothStatusText() :
This function updates the bluetooth status text for the *settingsView*.
  
#### updateBluetoothSymbolText() :
This function updates the bluetooth status icon for the *settingsView*.
  
#### fetchIndex() :
This function retrieves the view index from *NavigationController*.
  
#### onBluetoothConnect() :
This function updates the bluetooth connect variable.
  
  
### SettingsViewModel
This viewModel handles the manual steering and simulation mode values and changes to steering view when needed.
  
#### activateSteering() :
This function activates the *steeringView*.
  
#### toggleAutoDrive() :
This function toggles the auto driving for the mower.
  
 
### SteeringViewModel () :
This viewModel handles data from and to the mower in terms of collison data and driving commands.
  
#### getSignalStrength() : 
This function retrieves data from the mower, how close to an object it currently is and updates the signalStrength variable accordingly. This in turn will update the collision icon. 
  
#### send() :
This function sends driving commands to the mower.
  
#### disableSteering() : 
This function removes the steering view and pushes a new view to display for the user. 
  
#### stopMower() :
This function stops the mower by sending specific command.
  

### StartViewModel
This viewModel handles the connection functionality to the mower.
  
#### connect() : 
This function tries to connect to the specific device. 

#### onScanResults() : 
This function finds the specific device and calls *connect*.
  
#### scan() : 
This function scans for devices in the area and returns the devices. Calls on *onScanResults*.
  
#### requestPermission() :
This method request permissions from the user.

#### showRequestDialog() : 
This function brings up a dialog window if Bluetooth or location services is not enabled, prompting the user to enable these things for the app to fully function. Calls on  *requestPermission*.

#### onPermissionGiven() : 
This function checks if the user has the required permissions and if they have start scanning for devices, if not then open Bluetooth settings. 

#### updateBluetoothStatus() : 
This function updates the bluetooth status text shown in the view.


## Requirements

### A1.1 The App shall establish a wireless connection with the Robot

Bluetooth has been implemented as a communication protocol between the app and mower.  

### A1.2 The App shall take user input and translate this to drive commands passed to the Robot

The app visualizes buttons for the user to press, that will steer the mower. This is done by calling the *send()* method describes previously, which will send data to the mower who will execute the commands.   

### A1.3: The App shall visualize sensor data from the collision avoidance sensor on the Mower

The app recieves data from the mower, by calling *getSignalStrength()* and updates the view, which visualizes how close the mower is to an object and tells the user if a collision has occurred.   


# Software Design Description: Database & Datahandler


The backend along with the application utilizes Firebase Realtime Database for storage and retrieval of the data sent from the Mower. Each of position covered by the Mower is stored in the database along with a unique ID, called sessionID which consists of the date and time of the session start.

Using the shared database, the stored information is retrieved and displayed in the mobile application. To handle the data about the positions, a separate class is created, *positionEvent*. The *positionEvent* object has a Boolean attribute which helps to determine if a collision has occurred in that position. Further reason for creating the class is for calculation of the X and Y coordinates, using the given vectors from the Mower. This calculation is done in withing the class and the coordinates set thereafter. 

To handle storage of the data and its retrieval, another class called *Database* is created. This class stores, deletes, and retrieves data from the Firebase database. The functions are written to distinguish between positions covered by the Mower and position in which collision has occurred. 


## PositionEvent Class
The PositionEvent Class contains the following methods. 

### PositionEvent (num angle, int length, String positionDateTime, num pos_CoordX, num pos_CoordY, {int sessionID})
The constructor of the  which sets the values required for an positionEvent object. 

### void calculateCoordX (num angle, int length)
Given the angle and the lenght of the vector the X coordinate is calculated.

### void calculateCoordY (num angle, int lenght)
Given the angle and the lenght of the vector the Y coordinate is calculated.

### int getXCoord ()
Getter; returning the object's X coordinate.

### int getYCoord ()
Getter; returning the object's Y coordinate.

### String getpositionDate ()
Getter; returning the date and time when the position was covered. 

### void setXCoord (int newXCoord)
Setter; sets the X coordinate for the object.

### void setYCoord (int newYCoord)
Setter; sets the Y coordinate for the object.

### void setDate (String newDate)
Setter; sets new date and time at which the position was covered. 

## Database Class
This class is responsible for storing, retrieving, and deleting data in the database. 

### void addPositionEvent(PositionEvent positionEvent)
Creates a new *positionEvent* in the database using the *sessionID* from the parameter and sets the values for it. 

### List<String> getAllPositions(String sessionID)
Returns the a list with all the *positionEvents* that match the *sessionID* given in the parameter. The retrieved objects are ordered by the *seessionID* 

### void deletePositionEvent(String sessionID)
Deletes all the *positionEvents* that match the *sessionID* given in the paramenter. 

### void addCollisionEvent(PositionEvent collisionPosition)
Takes a *positionEvent* and creates a new *collisionEvent* in the database if the *positionEvent* is a position where a collision has occured.

### List<String> getAllCollisionEvents() 
Returns a list of all *collisionEvents* stored in the database. 

### void deleteCollisionEvent(String sessionID)
Deletes the *collisionEvent* that matches the *sessionID* given in the parameter. 

## Requirements
### B1.1: The Backend shall read positions from the Mower and save these in a file.
The data about each position is sent from the Mower to the database, where it is stored in Firebase Realtime Database. 

### B1.2: The Backend shall record each position where collisions avoidance are activated.
Each position that the Mower has covered has a boolean attribute which determines if a collision has occured at that position. 