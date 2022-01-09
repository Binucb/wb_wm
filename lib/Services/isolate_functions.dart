import 'dart:typed_data';
import 'package:excel/excel.dart';

Future<Excel> parseExcelFile(Uint8List? _bytes) async {
  List<int> bytes = List.from(_bytes!);

  return Excel.decodeBytes(bytes);
}


