import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Barcode extends Equatable {
  String barcode;
  DateTime creationTime;

  Barcode({required this.barcode, required this.creationTime});
  @override
  List<Object?> get props => [barcode];
}
