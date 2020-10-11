import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'database/database.dart';

class RecordRepository{
  /// レコードの変更を保存
  Future<void> save(RecordModel record) async {
    var box = await Hive.openBox<RecordModel>('record');
    await box.add(record);
  }

  /// 全件データを取得
  Future<List<RecordModel>> fetchAll() async {
    var box = await Hive.openBox<RecordModel>('record');
    return box.values.toList();
  }

  Future<bool> canAdd(RecordModel recordModel) async {
    if(recordModel == null || recordModel.url.isEmpty) return false;

    try {
      final box = await Hive.openBox<RecordModel>('record');
      List<RecordModel> list = box.values
          .where((n) => n.url == (recordModel.url)).toList();
      return list.length == 0;
    } catch (e) {
      debugPrint("データの取得で例外発生しました。 $e.toString()");
    }
    return false;
  }

  Future<void> delete(RecordModel recordModel) async {
    final box = await Hive.openBox<RecordModel>('record');
    int i = box.values.toList().indexOf(recordModel);
    box.deleteAt(i);
  }
}