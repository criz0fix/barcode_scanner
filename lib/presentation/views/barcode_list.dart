import 'package:barcode_scanner/boxes.dart';
import 'package:barcode_scanner/data/models/barcode.dart';
import 'package:barcode_scanner/presentation/cubit/barcode_cubit.dart';
import 'package:barcode_scanner/presentation/widgets/barcode_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BarcodeList extends StatefulWidget {
  const BarcodeList({Key? key}) : super(key: key);

  @override
  State<BarcodeList> createState() => _BarcodeListState();
}

class _BarcodeListState extends State<BarcodeList> {
  @override
  void initState() {
    HiveBoxesService.registerAdapters();
    HiveBoxesService.openBoxes();
    super.initState();
  }

  @override
  void dispose() {
    HiveBoxesService.closeBoxes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BarcodeCubit(
        barcodes: HiveBoxesService.readFromLocalStorage('barcodes')
            .map((model) => Barcode.fromBarcodeHiveModel(model))
            .toList(),
      ),
      child: BlocBuilder<BarcodeCubit, BarcodeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Barcode Scanner'),
              centerTitle: true,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
                onPressed: () => scanBarcode(context),
                child: const Icon(Icons.qr_code_scanner)),
            body: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.barcodeList.length,
              itemBuilder: ((context, index) {
                final item = state.barcodeList[index];
                return BarcodeTile(
                  title: item.barcode,
                  savedTime: formatDate(item.creationTime),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  Future scanBarcode(BuildContext context) async {
    String barcode;
    barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.DEFAULT);

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Save code?'),
              content: Text(barcode),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No')),
                TextButton(
                    onPressed: () {
                      context.read<BarcodeCubit>().saveBarcode(Barcode(
                          barcode: barcode, creationTime: DateTime.now()));
                      Navigator.pop(context);
                    },
                    child: const Text('Yes'))
              ],
            ));
  }

  String formatDate(DateTime date) =>
      DateFormat('yyyy-MM-dd – kk:mm:ss').format(date);
}


      // DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())

