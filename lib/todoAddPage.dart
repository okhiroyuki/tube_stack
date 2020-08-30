import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'youtubeData.dart';

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {

  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('追加'),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text, style: TextStyle(color: Colors.blue)),
            TextField(
              onChanged: (String value){
                _text = value;
              },
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: (){
                  Future<YoutubeData> future = getTitle(_text);
                  future.then((data) => setState((){
                    Navigator.of(context).pop(data);
                  }));
                },
                child: Text('リスト追加', style: TextStyle(color: Colors.white)),
              )
            ),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: FlatButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      )
    );
  }

  Future<YoutubeData> getTitle(String url) async {
    if(url.isEmpty) return null;
    var jsonData = await getDetail(url);
    return YoutubeData(url, jsonData['title'], jsonData['thumbnail_url']);
  }

  Future<dynamic> getDetail(String userUrl) async {
    String embedUrl = "https://www.youtube.com/oembed?url=$userUrl&format=json";

    //store http request response to res variable
    var res = await http.get(embedUrl);
    print("get youtube detail status code: " + res.statusCode.toString());

    try {
      if (res.statusCode == 200) {
        //return the json from the response
        return json.decode(res.body);

      } else {
        //return null if status code other than 200
        return null;
      }
    } on FormatException catch (e) {
      print('invalid JSON'+ e.toString());
      //return null if error
      return null;
    }
  }
}
