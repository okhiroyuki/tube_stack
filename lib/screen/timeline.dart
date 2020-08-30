import 'package:flutter/material.dart';

import '../header.dart';

class Timeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 300,
          width: 300,
          child: Text(
            "Timeline",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}