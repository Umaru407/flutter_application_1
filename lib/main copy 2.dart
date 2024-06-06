import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Widget Screenshot2'),
      ),
      body: Center(
        child: Screenshot(
          controller: screenshotController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hello, Flutter!43',
                style: TextStyle(fontSize: 30),
              ),
              ElevatedButton(
                onPressed: _shareScreenshot,
                child: Text('Share Screenshot'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _shareScreenshot() async {
    screenshotController
        .captureFromWidget(Container(
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent, width: 5.0),
              color: Colors.redAccent,
            ),
            child: Text("This is an invisible widget")))
        .then((capturedImage) {
      XFile xFile = XFile.fromData(capturedImage, mimeType: 'image/png');
      Share.shareXFiles(
        [xFile],
      );
      
      // Handle captured image
    });

    // Share.share('check out my website https://example.com');
  }
}
