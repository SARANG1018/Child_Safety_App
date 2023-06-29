
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/qr_code_controller.dart';

import 'package:flutter/services.dart';

class QrCodeView extends GetView<QrCodeController> {
  const QrCodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          width: 300,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              //Display Image
              // Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQyYwscUPOH_qPPe8Hp0HAbFNMx-TxRFubpg&usqp=CAU")),

              //First Button
              FloatingActionButton(
                // padding: EdgeInsets.all(15),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ScanQR()));
                },
                child: Text("Scan QR Code",style: TextStyle(color: Colors.indigo),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  // side: BorderSide(color: Colors.indigo),
                ),
              ),
              SizedBox(height: 20),

              //Second Button
              FloatingActionButton(
                // padding: EdgeInsets.all(15),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                      GenerateQR()));
                },
                child: Text("Generate QR Code", style: TextStyle(color: Colors.indigo[900]),),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  // side: BorderSide(color: Colors.indigo),
                ),
              ),
            ],
          ),
        )
    );
  }
}


class GenerateQR extends StatefulWidget {
  @override
  _GenerateQRState createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {

  String qrData="https://github.com/ChinmayMunje";
  final qrdataFeed = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar having title
      appBar: AppBar(
        title: Center(child: Text("Generate QR Code")),
      ),
      body: Container(
        // padding: EdgeInsets.all(20),
        child: SingleChildScrollView(

          //Scroll view given to Column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QrImage(data: qrData),
              SizedBox(height: 20),
              Text("Generate QR Code",style: TextStyle(fontSize: 20),),

              //TextField for input link
              TextField(
                decoration: InputDecoration(
                    hintText: "Enter your link here..."
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                //Button for generating QR code
                child: FloatingActionButton(
                  onPressed: () async {
                    //a little validation for the textfield
                    if (qrdataFeed.text.isEmpty) {
                      setState(() {
                        qrData = "";
                      });
                    } else {
                      setState(() {
                        qrData = qrdataFeed.text;
                      });
                    }
                  },
                  //Title given on Button
                  child: Text("Generate QR Code",style: TextStyle(color: Colors.indigo[900],),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.indigo),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ScanQR extends StatefulWidget {
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {

  String qrCodeResult = "Not Yet Scanned";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Message displayed over here
            Text(
              "Result",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),

            //Button to scan QR code
            FloatingActionButton(
              // padding: EdgeInsets.all(15),
              onPressed: () async {
                  var codeScanner = await BarcodeScanner.scan(); //barcode scanner
                setState(() {
                  qrCodeResult = codeScanner.rawContent;
                });
              },
              child: Text("Open Scanner",style: TextStyle(color: Colors.indigo),),
              //Button having rounded rectangle border
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.indigo),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),

          ],
        ),
      ),
    );
  }
}






