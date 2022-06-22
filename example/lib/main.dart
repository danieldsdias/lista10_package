// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista10_package/lista10_package.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista10 Package Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Lista10 Package Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var itemList = ['item 1', 'item 2'];
  File? image;

  void _addNewItem(String title) {
    setState(() {
      itemList.add(title);
    });
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const double imageSize = 160;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: image != null
                  ? ImageWidget(
                      image: image!,
                      onClicked: (source) => pickImage(source),
                      size: imageSize)
                  : const FlutterLogo(size: imageSize),
            ),
            const SizedBox(height: 24),
            image == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageWidget.buildButton(
                          title: 'Galeria',
                          icon: Icons.image_outlined,
                          onClicked: () => pickImage(ImageSource.gallery)),
                      const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20)),
                      ImageWidget.buildButton(
                          title: 'Camera',
                          icon: Icons.camera_alt_outlined,
                          onClicked: () => pickImage(ImageSource.camera)),
                    ],
                  )
                : const SizedBox(height: 24),
            Padding(padding: EdgeInsets.all(50)),
            Text('Lista de itens: \n${itemList.join('\n')}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => NewItemWidget.startAddNewItem(context, _addNewItem),
        tooltip: 'Adiciona um item',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
