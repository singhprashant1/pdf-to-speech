import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

import 'package:pdf_text/pdf_text.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PDFDoc _pdfDoc;
  String _text = "";

  bool _buttonsEnabled = true;
  final FlutterTts flutterTts = FlutterTts();

  @override
  _speak() async {
    print(await flutterTts.getLanguages);
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(_text);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            FlatButton(
              child: Text(
                "Pick PDF document",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blueAccent,
              onPressed: _pickPDFText,
              padding: EdgeInsets.all(5),
            ),
            FlatButton(
              child: Text(
                "Read random page",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blueAccent,
              onPressed: _buttonsEnabled ? _readRandomPage : () {},
              padding: EdgeInsets.all(5),
            ),
            FlatButton(
              child: Text(
                "Read whole document",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blueAccent,
              onPressed: _buttonsEnabled ? _readWholeDoc : () {},
              padding: EdgeInsets.all(5),
            ),
            RaisedButton(
                child: Text("Press this button to say Hello"),
                onPressed: () => _speak()),
            Padding(
              child: Text(
                _pdfDoc == null
                    ? "Pick a new PDF document and wait for it to load..."
                    : "PDF document loaded, ${_pdfDoc.length} pages\n",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(15),
            ),
            Padding(
              child: Text(
                _text == "" ? "" : "Text:",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(15),
            ),
            Text(_text),
          ],
        ),
      )),
    );
  }

  /// Picks a new PDF document from the device
  Future _pickPDFText() async {
    File file = await FilePicker.getFile();
    _pdfDoc = await PDFDoc.fromFile(file);
    setState(() {});
  }

  /// Reads a random page of the document
  Future _readRandomPage() async {
    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });

    String text =
        await _pdfDoc.pageAt(Random().nextInt(_pdfDoc.length) + 1).text;

    setState(() {
      _text = text;
      _buttonsEnabled = true;
    });
  }

  /// Reads the whole document
  Future _readWholeDoc() async {
    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });

    String text = await _pdfDoc.text;

    setState(() {
      _text = text;
      _buttonsEnabled = true;
    });
  }
}
