import 'package:barcode_scanner/data/local/database.dart';
import 'package:equatable/equatable.dart';

import 'package:barcode_scanner/data/models/barcode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'barcode_state.dart';

class BarcodeCubit extends Cubit<BarcodeState> {
  BarcodeCubit()
      : super(const BarcodeState(
          barcodeList: [],
        ));

  Future<void> saveBarcode(Barcode barcode) async {
    emit(state.copywith(barcodeList: [...state.barcodeList, barcode]));
    await DBProvider.db.insertBarcode(barcode);
  }

  Future<void> updateBarcodeList() async {
    final list = await DBProvider.db.getBarcodes();
    emit(state.copywith(barcodeList: list));
  }

  Future<void> deleteFromList(int index) async {
    await DBProvider.db.deleteBarcode(state.barcodeList[index].creationTime);
    emit(state.copywith(barcodeList: [...state.barcodeList]..removeAt(index)));
  }
}
