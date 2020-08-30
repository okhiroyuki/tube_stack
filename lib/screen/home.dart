import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../header.dart';
import '../todoAddPage.dart';
import '../youtubeData.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<YoutubeData> _todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          final item = _todoList[index];

          return Dismissible(
            key: Key(item.getTitle()),
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              // Remove the item from the data source.
              setState(() {
                _todoList.removeAt(index);
              });
              _launchURL(item);
            },
            // Show a red background as the item is swiped away.
            background: Container(color: Colors.lightGreen),
            child: ListTile(
              title: Text(_todoList[index].getTitle()),
              leading: Image.network(_todoList[index].getThumbnailUtl(), width: 70,),
            )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final YoutubeData youtubeData = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return TodoAddPage();
              })
          );
          if (youtubeData != null && youtubeData.getUrl().isNotEmpty) {
            setState(() {
              _todoList.add(youtubeData);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _launchURL(YoutubeData data) async {
    if (await canLaunch(data.getUrl())) {
      _todoList.add(data);
      await launch(data.getUrl());
    } else {
      Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}

