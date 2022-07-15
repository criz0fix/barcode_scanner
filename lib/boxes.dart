import 'dart:developer';

import 'package:barcode_scanner/data/models/barcode.dart';
import 'package:barcode_scanner/data/models/barcode_hive_model.dart';
import 'package:hive/hive.dart';

class HiveBoxesService {
  static void registerAdapters() {
    Hive.registerAdapter(BarcodeHiveModelAdapter());
  }

  static Box getBox() => Hive.box<BarcodeHiveModel>('barcodes');

  static void writeToLocalStorage(List<BarcodeHiveModel> data) =>
      getBox().put('barcodes', data);

  static List<BarcodeHiveModel> readFromLocalStorage(String key) {
    final data = getBox().get('barcodes') as List<BarcodeHiveModel>;
    log(data.toString());
    return data;
  }

  static void openBoxes() {
    Hive.openBox('barcodes');
  }

  static void closeBoxes() {
    Hive.box('barcodes').close();
  }
}
