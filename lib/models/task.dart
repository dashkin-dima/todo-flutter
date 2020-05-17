import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;  
  @HiveField(1)
  String text;

  Task({this.title, this.text});
}
