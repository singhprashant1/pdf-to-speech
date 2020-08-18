import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:texttosp/file.dart';

void main() => runApp(TToS());

class TToS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("TExt to speech"),
          backgroundColor: Colors.deepOrange,
        ),
        body: MyApp(),
      ),
    );
  }
}

// class _Home extends StatefulWidget {
//   @override
//   __HomeState createState() => __HomeState();
// }

// class __HomeState extends State<_Home> {
//   final FlutterTts flutterTts = FlutterTts();

//   @override
//   _speak() async {
//     print(await flutterTts.getLanguages);
//     await flutterTts.setLanguage('en-US');
//     await flutterTts.setPitch(1.0);
//     await flutterTts.speak("Hello");
//   }

//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       child: RaisedButton(
//           child: Text("Press this button to say Hello"),
//           onPressed: () => _speak()),
//     );
//   }
// }
