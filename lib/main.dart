import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Printer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrinterHomePage(),
    );
  }
}

class PrinterHomePage extends StatefulWidget {
  @override
  _PrinterHomePageState createState() => _PrinterHomePageState();
}

class _PrinterHomePageState extends State<PrinterHomePage> {
  ReceiptController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Printer'),
      ),
      body: Column(
        children: [
          Receipt(
            builder: (context) => const Column(
              children: [
                Text('Sample Receipt'),
                Text('Item 1: \$10.00'),
                Text('Item 2: \$20.00'),
                Text('Total: \$30.00'),
              ],
            ),
            onInitialized: (ctrl) {
              setState(() {
                controller = ctrl;
              });
            },
          ),
          ElevatedButton(
            onPressed: () => _selectAndPrintDevice(context),
            child: Text('Print Receipt'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectAndPrintDevice(BuildContext context) async {
    final device = await FlutterBluetoothPrinter.selectDevice(context);
    if (device != null && controller != null) {
      await controller!.print(address: device.address);
    }
  }
}
