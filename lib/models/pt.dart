import 'package:hive/hive.dart';
part 'pt.g.dart';

@HiveType(typeId: 1)
class PtDB extends HiveObject {
  PtDB({this.required, this.optional, this.conditional});
  @HiveField(0)
  late String? required;

  @HiveField(1)
  late String? optional;

  @HiveField(2)
  late String? conditional;
}
