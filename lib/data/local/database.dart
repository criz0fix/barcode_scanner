import 'dart:io';

import 'package:barcode_scanner/core/consts.dart';
import 'package:barcode_scanner/data/models/barcode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDB();

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}Barcode.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $barcodesTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName VARCHAR(255) NOT NULL, $columnTime VARCHAR(255) NOT NULL)''');
  }

  //READ
  Future<List<Barcode>> getBarcodes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> barcodeMapList =
        await db.query(barcodesTable);
    final List<Barcode> barcodeList = [];
    for (var barcodeMap in barcodeMapList) {
      barcodeList.add(Barcode.fromMap(barcodeMap));
    }
    return barcodeList;
  }

  //Insert
  Future<void> insertBarcode(Barcode barcode) async {
    final db = await database;
    await db.insert(
      barcodesTable,
      barcode.toMap(),
    );
  }

  //DELETE
  Future<void> deleteBarcode(String time) async {
    final db = await database;
    await db.delete(
      barcodesTable,
      where: 'time = ?',
      whereArgs: [time],
    );
  }
}
