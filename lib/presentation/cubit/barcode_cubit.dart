// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:barcode_scanner/data/models/barcode.dart';

part 'barcode_state.dart';

class BarcodeCubit extends Cubit<BarcodeState> {
  BarcodeCubit()
      : super(const BarcodeState(
          barcodeList: [],
        ));

  void saveBarcode(Barcode barcode) {
    emit(state.copywith(
        barcodeList: [...state.barcodeList]..insert(0, barcode)));
  }
}
