# Software Design Description: Database & Datahandler

## Introduction

This application uses Firebase Realtime Database in order to store the data from the mower. Using the shared database, the stored information is retrieved to be displayed in the mobile application. The positions of the mower are sent through the mower and stored in the database. For this, it is appropriate to use a class to define the position-object. Hence, the class *PositionEvent* is created. To handle storage of the data and its retrieval, another class called *Database* is created. 

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
Returns the a list with all the *positionEvents* that match the *sessionID* given in the parameter. 

### void deletePositionEvent(String sessionID)
Deletes all the *positionEvents* that match the *sessionID* given in the paramenter. 

### void addCollisionEvent(PositionEvent collisionPosition)
Takes a *positionEvent* and creates a new *collisionEvent* in the database if the *positionEvent* is a position where a collision has occured.

### List<String> getAllCollisionEvents() 
Returns a list of all *collisionEvents* stored in the database. 

### void deleteCollisionEvent(String sessionID)
Deletes the *collisionEvent* that matches the *sessionID* given in the parameter. 