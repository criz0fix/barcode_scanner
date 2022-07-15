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
    context.read<BarcodeCubit>().updateBarcodeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BarcodeCubit, BarcodeState>(
      builder: (context, state) {
        final myCubit = context.read<BarcodeCubit>();
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
              return Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  myCubit.deleteFromList(index);
                },
                child: BarcodeTile(
                  title: state.barcodeList[index].barcode,
                  savedTime: state.barcodeList[index].creationTime,
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Future scanBarcode(BuildContext context) async {
    final barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.DEFAULT);
    if (barcode.compareTo('-1') != 0) {
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
                  context.read<BarcodeCubit>().saveBarcode(
                      Barcode(barcode: barcode, creationTime: _formatDate()));
                  Navigator.pop(context);
                },
                child: const Text('Yes'))
          ],
        ),
      );
    }
  }

  String _formatDate() =>
      DateFormat('yyyy-MM-dd – kk:mm:ss').format(DateTime.now());
}
