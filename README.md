# **Software Design Description: App**

[link to class diagram!](https://drive.google.com/file/d/1bJgkpCA02XR1QgMH_F5UQLhQh8izsuSE/view?usp=sharing )
## Design pattern:
### The app makes use of the Model View ViewModel (MVVM) design pattern. This makes it possible to abstract the view and thus reduces the amount of business logic required in the code behind it. It also makes it easier to test the ViewModel without any interaction from the view  

## A1.1 The App shall establish a wireless connection with the Robot

#### Bluetooth has been implemented as a communication protocol and therefore the following functions is needed to form a connection with the mower: 

### onBluetoothConnect() :
This function listens for the Bluetooth connection state and updates the isConnected variable 

### write() :  
This function sends data for the mower to interpret. 

### listen() : 
This method listens for incoming messages from the mower 

### scan() : 
This function scans for devices in the area and returns the devices. Calls on *onScanResults*

### onScanResults() : 
This function finds the specific device and calls *connect*

### connect() : 
This function tries to connect to the specific device. 

### showRequestDialog() : 
This function brings up a dialog window if Bluetooth or location services is not enabled, prompting the user to enable these things for the app to fully function. Calls on  *requestPermission*

### onPermissionGiven() : 
This function checks if the user has the required permissions and if they have start scanning for devices, if not then open Bluetooth settings. 

### updateBluetoothStatusText() : 
This function updates the Bluetooth status text when the user presses on the Bluetooth icon.  

### updateBluetoothSymbolText() : 
This function switches the Bluetooth icon depending on the connection state to the mower. 

## A1.2 The App shall take user input and translate this to drive commands passed to the Robot
#### To be able to let the user drive the mower in a smooth and good way these functions has been implemented: 

### send() : 
This function sends driving commands to the mower, as following: 
* MOWER_AUTO_RUN = "AR"
* MOWER_IDLE = "AS"
* MOWER_FORWARD = "MF"
* MOWER_BACKWARD = "MB"
* MOWER_LEFT = "ML"
* MOWER_RIGHT = "MR"

### disableSteering() : 
This function removes the steering view and pushes a new view to display for the user.  

## A1.3: The App shall visualize sensor data from the collision avoidance sensor on the Mower

#### To be able to visualize the path and collision events from the mower, the following functions are being used: 

### getSignalStrength() : 
This function retrieves data from the mower, how close to an object it currently is and updates the signalStrength variable accordingly. This in turn will update the collision icon. 

### getPositions() :  
This function retrieves vectors from the backend and transform these into coordinates, that will be displayed as a path on the view. 


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
