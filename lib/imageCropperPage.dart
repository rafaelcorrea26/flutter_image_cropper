import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';

class CropperPage extends StatefulWidget {
  CropperPage();

  @override
  _CropperPage createState() => _CropperPage();
}

class _CropperPage extends State<CropperPage> {
  var CaminhoImagem = "assets/pictures/profile-picture.jpg";
  File? _arquivo;
  XFile? imageFile = null;

  String VerificarCaminhoImagem() {
    if (imageFile == null) {
      return CaminhoImagem;
    } else {
      return imageFile!.path;
    }
  }

  _CropperPage();

  @override
  void initState() {
    super.initState();
  }

  Future<void> MostraDialogoEscolha(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Escolha uma opção",
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.red[400],
                  ),
                  ListTile(
                    onTap: () {
                      AbreGaleria(context);
                    },
                    title: Text("Galeria"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.red[400],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.red[400],
                  ),
                  ListTile(
                    onTap: () {
                      AbreCamera(context);
                    },
                    title: Text("Câmera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.red[400],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future AbreCamera(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      cropImage(image.path);
    } on PlatformException catch (e) {
      print('Falha ao selecionar a imagem: $e');
    }
  }

  Future AbreGaleria(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      cropImage(image.path);
    } on PlatformException catch (e) {
      print('Falha ao selecionar a imagem: $e');
    }
  }

  cropImage(filePath) async {
    File? croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 600,
      maxHeight: 600,
      aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
      androidUiSettings: androidUiSettings(),
      iosUiSettings: iosUiSettings(),
    );
    if (croppedImage != null) {
      final imageTemp = croppedImage; //File(croppedImage.path);
      setState(() => this._arquivo = imageTemp);
    }
  }

  static IOSUiSettings iosUiSettings() => IOSUiSettings(
        aspectRatioLockEnabled: false,
      );

  static AndroidUiSettings androidUiSettings() => AndroidUiSettings(
        toolbarTitle: 'Ajuste a Imagem',
        toolbarColor: Colors.red,
        toolbarWidgetColor: Colors.white,
        lockAspectRatio: false,
      );

  barraSuperior() {
    return AppBar(
      title: Text("App manipulação imagens"),
      centerTitle: true,
      backgroundColor: Colors.red[400],
    );
  }

  Widget corpo(context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 40, right: 40),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            width: 300,
            height: 300,
            alignment: Alignment(0.0, 1.15),
            child: Column(
              children: [
                Container(
                  width: 240,
                  height: 240,
                  child: FittedBox(
                      fit: BoxFit.fill, // otherwise the logo will be tiny
                      child: _arquivo != null ? Image.file(_arquivo!) : Image.asset(CaminhoImagem)),
                ),
                Container(
                  height: 56,
                  width: 56,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0XFFEF5350),
                    border: Border.all(
                      width: 1.0,
                      color: const Color(0xFFFFFFFF),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(56),
                    ),
                  ),
                  child: SizedBox.expand(
                    child: TextButton(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await MostraDialogoEscolha(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: corpo(context), appBar: barraSuperior());
  }
}
