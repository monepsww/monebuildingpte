import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:monebuilding/utility/my_constant.dart';
import 'package:monebuilding/utility/normal_dialog.dart';

class AddBuilding extends StatefulWidget {
  @override
  _AddBuildingState createState() => _AddBuildingState();
}

class _AddBuildingState extends State<AddBuilding> {
  //Field
  double lat, lng;
  LatLng latLng;
  File file;
  String name, detail, urlImage;
  String nameFile;

  //Method
  @override
  void initState() {
    super.initState();
    findLatlng();
  }

  Future<void> findLatlng() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
    });

    // ตัวอย่างทดสอบ
    // Duration duration = Duration(seconds: 5);
    // await Timer(duration, () {
    //   setState(() {
    //     lat = 13.594559;
    //     lng = 100.2929657;
    //   });
    // });
  }

// ส่งพิกัดของเครื่อง จะเอามาใช้งาน
  Future<LocationData> findLocationData() async {
    var location = Location();
    try {
      return await location.getLocation();
    } catch (e) {}
  }

  Set<Marker> myMarket() {
    return <Marker>{
      Marker(
        position: latLng,
        markerId: MarkerId('myPosition'),
      ),
    }.toSet();
  }

  Widget showDetailMap() {
    latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16,
    );
    return GoogleMap(
      markers: myMarket(),
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController googleMapController) {},
    );
  }

  Widget showMap() {
    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
        bottom: 20.0,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: lat == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : showDetailMap(),
    );
  }

  Widget detailForm() {
    return Container(
      width: 250.0,
      child: TextField(
        onChanged: (String string) {
          detail = string.trim();
        },
        decoration: InputDecoration(hintText: 'Detail:'),
      ),
    );
  }

  Widget nameForm() {
    return Container(
      width: 250.0,
      child: TextField(
        onChanged: (String string) {
          name = string.trim();
        },
        decoration: InputDecoration(hintText: 'Name:'),
      ),
    );
  }

  Widget showImage() {
    return GestureDetector(
      onTap: () {
        print('Click Image');
        cameraAction();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width,
        child:
            file == null ? Image.asset('images/camera.png') : Image.file(file),
      ),
    );
  }

  Future<void> cameraAction() async {
    try {
      var object = await ImagePicker.pickImage(
          source: ImageSource.camera, maxWidth: 800.0, maxHeight: 800.0);
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Future<void> uploadImageToServer() async {
    Random random = Random();
    int i = random.nextInt(10000);
    nameFile = 'building$i.jpg';

// Upload File to Server
    try {
      Map<String, dynamic> map = Map();
      map['file'] = UploadFileInfo(file, nameFile);
      FormData formData = FormData.from(map);
      await Dio()
          .post(MyConstant().urlAPIsaveFile, data: formData)
          .then((respones) {
        print('respones = $respones');
        insertDataImageToServer();
      });
    } catch (e) {}
  }

  Future<void> insertDataImageToServer() async {
    urlImage = 'https://www.androidthai.in.th/pte/avatarMone/$nameFile';
    String url =
        'https://www.androidthai.in.th/pte/addBuilding.php?isAdd=true&Name=$name&Detail=$detail&UrlImage=$urlImage&Lat=$lat&Lng=$lng';

    Response response = await Dio().get(url);
    if (response.toString() == 'true') {
      Navigator.of(context).pop();
    } else {
      normalDialog(context, 'Upload Fail', 'Please Try Again');
    }
  }

  Widget addBuildingButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            child: Text('Add Building'),
            onPressed: () {
              if (file == null) {
                normalDialog(context, 'No Image', 'Please Click Image');
              } else if (name == null ||
                  name.isEmpty ||
                  detail == null ||
                  detail.isEmpty) {
                normalDialog(
                    context, 'เกิดข้อผิดพลาด', 'กรุณากรอกข้อมูลให้ครบถ้วน');
              } else {
                uploadImageToServer();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget myContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          showImage(),
          nameForm(),
          detailForm(),
          showMap(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Building'),
      ),
      body: Stack(
        children: <Widget>[
          myContent(),
          addBuildingButton(),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
