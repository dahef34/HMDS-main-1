import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hmd_system/model/appoinment.dart';
import 'package:flutter/material.dart';

class aList extends StatelessWidget {
  final Appointment _appt;

  aList(this._appt);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "${_appt.title}",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("${_appt.details}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
