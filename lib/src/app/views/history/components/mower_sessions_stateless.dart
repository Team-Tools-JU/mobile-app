import 'package:flutter/material.dart';
import 'package:mobile_app/src/app/models/constants/text_constants.dart';
import '../../../view_models/history_view_model.dart';

class MowerSessionsStateless extends StatelessWidget {
  final HistoryViewModel model;

  const MowerSessionsStateless(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), border: Border.all()),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: model.currentSession,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 35,
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 20),
            onChanged: (String? newValue) {
              model.setSessionName(newValue!);
              (context as Element).markNeedsBuild();

              // TODO: Send data to Painter to draw new session
            },
            // TODO: Retrieve the sessions from backend and add to list
            items: <String>[
              SESSION_1_LABEL,
              SESSION_2_LABEL,
              SESSION_3_LABEL,
              SESSION_4_LABEL
            ].map<DropdownMenuItem<String>>((String value) {
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
