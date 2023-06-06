import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

class FileUpload extends StatefulWidget {
  final ValueChanged<File?> onFileChanged;

  FileUpload({required this.onFileChanged});

  @override
  _FileUploadState createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  File? _selectedFile;

  void _selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() {
      _selectedFile = File(path);
    });

    widget.onFileChanged(_selectedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Suba su documento de identidad(CI):'),
          trailing: ElevatedButton(
              onPressed: _selectFile,
              child: Text('Cargar documento'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(HexColor("#9695ff")),
              )),
        ),
        if (_selectedFile != null)
          ListTile(
            title: Text('Archivo seleccionado:'),
            subtitle: Text(_selectedFile!.path),
          ),
      ],
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
