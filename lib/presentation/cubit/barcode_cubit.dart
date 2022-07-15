// ignore_for_file: depend_on_referenced_packages

import 'package:barcode_scanner/boxes.dart';
import 'package:barcode_scanner/data/models/barcode_hive_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:barcode_scanner/data/models/barcode.dart';

part 'barcode_state.dart';

class BarcodeCubit extends Cubit<BarcodeState> {
  BarcodeCubit({required List<Barcode> barcodes})
      : super(BarcodeState(
          barcodeList: barcodes,
        ));

  void saveBarcode(Barcode barcode) {
    emit(state.copywith(
        barcodeList: [...state.barcodeList]..insert(0, barcode)));
    HiveBoxesService.writeToLocalStorage(
      state.barcodeList
          .map((model) => BarcodeHiveModel.fromBarcode(model))
          .toList(),
    );
  }

  void getBarcodes() {}
}
