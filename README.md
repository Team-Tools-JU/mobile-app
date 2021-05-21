# **Software Design Description: App**

[Link to class diagram](https://drive.google.com/file/d/1bJgkpCA02XR1QgMH_F5UQLhQh8izsuSE/view?usp=sharing )
## Introduction:
The application is created using Flutter, which allows an application to work in Android as well as IOS. The app makes use of the Model View ViewModel (MVVM) design pattern. This makes it possible to abstract the view and thus reduces the amount of business logic required in the code behind it. It also makes it easier to test the ViewModel without any interaction from the view.  

![App Design Pattern](https://github.com/Team-Tools-JU/mobile-app/blob/main/Design%20pattern.png)

## Functionality

#### onBluetoothConnect() :
This function listens for the Bluetooth connection state and updates the isConnected variable 

#### write() :  
This function sends data for the mower to interpret. 

#### listen() : 
This method listens for incoming messages from the mower 

#### scan() : 
This function scans for devices in the area and returns the devices. Calls on *onScanResults*

#### onScanResults() : 
This function finds the specific device and calls *connect*

#### connect() : 
This function tries to connect to the specific device. 

#### showRequestDialog() : 
This function brings up a dialog window if Bluetooth or location services is not enabled, prompting the user to enable these things for the app to fully function. Calls on  *requestPermission*

#### requestPermission() :
This method request permissions from the user

#### onPermissionGiven() : 
This function checks if the user has the required permissions and if they have start scanning for devices, if not then open Bluetooth settings. 

#### updateBluetoothStatusText() : 
This function updates the Bluetooth status text when the user press the Bluetooth icon.  

#### updateBluetoothSymbolText() : 
This function switches the Bluetooth icon depending on the connection state to the mower. 

#### send() : 
This function sends driving commands to the mower, as following: 
* MOWER_AUTO_RUN = "AR"
* MOWER_IDLE = "AS"
* MOWER_FORWARD = "MF"
* MOWER_BACKWARD = "MB"
* MOWER_LEFT = "ML"
* MOWER_RIGHT = "MR"

#### disableSteering() : 
This function removes the steering view and pushes a new view to display for the user.  

#### getSignalStrength() : 
This function retrieves data from the mower, how close to an object it currently is and updates the signalStrength variable accordingly. This in turn will update the collision icon. 

#### getPositions() :  
This function retrieves vectors from the backend and transform these into coordinates, that will be displayed as a path on the view. 

## Requirements

### A1.1 The App shall establish a wireless connection with the Robot

Bluetooth has been implemented as a communication protocol between the app and mower.  

### A1.2 The App shall take user input and translate this to drive commands passed to the Robot

The app visualizes buttons for the user to press, that will steer the mower. This is done by calling the *send()* method describes previously, which will send data to the mower who will execute the commands.   

### A1.3: The App shall visualize sensor data from the collision avoidance sensor on the Mower

The app recieves data from the mower, by calling *getSignalStrength()* and updates the view, which visualizes how close the mower is to an object and tells the user if a collision has occurred.   


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
