import 'package:barcode_scanner/presentation/cubit/barcode_cubit.dart';
import 'package:barcode_scanner/presentation/views/barcode_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => BarcodeCubit(),
        child: const BarcodeList(),
      ),
    );
  }
}
