import 'package:flutter/material.dart';


class MowerSessions extends StatefulWidget {
  const MowerSessions({Key? key}) : super(key: key);

  @override
  _MowerSessions createState() => _MowerSessions();
}

class _MowerSessions extends State<MowerSessions> {

  String dropdownValue = 'Session one';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all()),
          child: DropdownButtonHideUnderline(
            child:  DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 35,
              elevation: 16,
              style: TextStyle(color: Colors.black, fontSize: 20),
              onChanged: (String? newValue) {
                setState(() {
                  // TODO: Send data to Painter to draw new session
                  dropdownValue = newValue!;
                });
              },
              // TODO: Retrieve the sessions from backend and add to list
              items: <String>['Session one', 'Session two', 'Session three', 'Session four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
    );
  }
}
