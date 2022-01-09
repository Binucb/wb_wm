import 'package:hive/hive.dart';
part 'maindb.g.dart';

@HiveType(typeId: 0)
class MainDB extends HiveObject {
  MainDB({this.itemDetails});
  @HiveField(0)
  late List<String>? itemDetails;

  @HiveField(1)
  late int rwNm;
}
