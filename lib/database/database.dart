import 'package:hive/hive.dart';

part 'database.g.dart';

@HiveType(typeId: 1)
class RecordModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String url;
  @HiveField(2)
  String thumbnail;

  RecordModel(this.title, this.url, this.thumbnail);
}