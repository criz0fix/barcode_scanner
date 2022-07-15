import 'package:equatable/equatable.dart';

class Barcode extends Equatable {
  final String barcode;
  final String creationTime;

  const Barcode({required this.barcode, required this.creationTime});
  @override
  List<Object?> get props => [barcode, creationTime];

  Map<String, String> toMap() =>
      <String, String>{'name': barcode, 'time': creationTime};

  factory Barcode.fromMap(Map<String, dynamic> map) =>
      Barcode(barcode: map['name'] ?? '', creationTime: map['time'] ?? '');
}
