import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tube_stack/database/database.dart';
import 'package:url_launcher/url_launcher.dart';

import '../record_repository.dart';
import '../header.dart';
import '../todo_add_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<RecordRepository>(context, listen: false);

    return Scaffold(
      appBar: Header(),
      body: projectWidget(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final RecordModel recordModel = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return TodoAddPage();
              })
          );
          repository.canAdd(recordModel).then((result) => {
            if(result){
              setState(() {
                repository.save(recordModel);
                // addItem(youtubeData);
                // _todoList.add(recordModel);
              })
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget projectWidget(BuildContext context) {
    final repository = Provider.of<RecordRepository>(context, listen: false);
    return FutureBuilder(
      future: repository.fetchAll(),
      builder: (context, snapshot) {
        // 通信中はスピナーを表示
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        }
        // エラー発生時はエラーメッセージを表示
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        // データがnullでないかチェック
        if (snapshot.hasData) {
          return showList(snapshot.data);
        } else {
          return Text("データが存在しません");
        }
      },
    );
  }

  showList(List<RecordModel> list){
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final repository = Provider.of<RecordRepository>(context, listen: false);
        return Container(
          child: ListTile(
            leading: Image.network(list[index].thumbnail, width: 70,),
            title: Text(list[index].title),
            onTap: () => _launchURL(list[index]),
            onLongPress: () async {
              _showMyDialog(list[index]).then((result) => {
                setState(() => {
                  if(result != null) {
                    repository.delete(result)
                  }
                })
              });
            }
          )
        );
        // final item = _todoList[index];

        // return Dismissible(
        //   key: Key(item.getTitle()),
        //   // Provide a function that tells the app
        //   // what to do after an item has been swiped away.
        //   onDismissed: (direction) {
        //     // Remove the item from the data source.
        //     setState(() {
        //       _todoList.removeAt(index);
        //     });
        //     _launchURL(item);
        //   },
        //   // Show a red background as the item is swiped away.
        //   background: Container(color: Colors.lightGreen),
        //   child: ListTile(
        //     title: Text(_todoList[index].getTitle()),
        //     leading: Image.network(_todoList[index].getThumbnailUtl(), width: 70,),
        //   )
        // );
      },
    );
  }

  // Future<void> addItem(YoutubeData youtubeData) {
  //   return items
  //     .doc("user1")
  //     .set({
  //       'url': youtubeData.getUrl(),
  //     })
  //     .then((value) => print("User Added"))
  //     .catchError((error) => print("Failed to add user: $error"));
  // }

  Future _showMyDialog(RecordModel model) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('削除しますか？'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(model);
              },
            ),
          ],
        );
      },
    );
  }

  _launchURL(RecordModel data) async {
    if (await canLaunch(data.url)) {
      await launch(data.url);
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

