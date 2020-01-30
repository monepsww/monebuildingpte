import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:monebuilding/models/building_model.dart';
import 'package:monebuilding/screens/add_building.dart';
import 'package:monebuilding/utility/my_constant.dart';

class ListBuilding extends StatefulWidget {
  @override
  _ListBuildingState createState() => _ListBuildingState();
}

class _ListBuildingState extends State<ListBuilding> {
  // Field
  List<BuildingModel> listBuilding = List();

  // Method

  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    listBuilding = List();

    // listBuilding.clear();

    // if (listBuilding.length > 0) {
    //   listBuilding.removeWhere((BuildingModel buildingModel) {
    //     return listBuilding != null;
    //   });
    // }
    Response response = await Dio().get(MyConstant().urlAPIreadAllBuild);

    var result = json.decode(response.data);
    print('result $result');

    for (var map in result) {
      // lร้างเป็นโมเดลก่น  แล้วเก็บ map ไว้ในโมเดล
      BuildingModel buildingModel = BuildingModel.fromJson(map);
      setState(() {
        // เขียนทับใหม่
        listBuilding.add(buildingModel);
      });
    }
  }

  // FloatingActionButton
  // Row ก่อน แล้วค่อยคอบด้วย col
  Widget addBuildingButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 20.0, bottom: 20.0, left: 10.0),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  MaterialPageRoute materialPageRoute =
                      MaterialPageRoute(builder: (BuildContext buildContext) {
                    return AddBuilding();
                  });
                  // ไปแล้วสามารถ กดย้อนกลับได้
                  Navigator.of(context).push(materialPageRoute)
                      // เมื่อกลับมาหน้าเดิม  มันจะรีเฟสหน้าอีกรอบ
                      .then((response) {
                    readAllData();
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget showListView() {
    return ListView.builder(
      itemCount: listBuilding.length,
      itemBuilder: (BuildContext buildContext, int index) {
        return Row(
          children: <Widget>[
            showImage(index),
            showText(index),
          ],
        );
      },
    );
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Image.network(
        listBuilding[index].urlImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget showText(int index) {
    return Column(
      children: <Widget>[
        Text(listBuilding[index].name),
        Text(
          listBuilding[index].detail,
        )
      ],
    );
  }

// Stack  อยู่ ซ้ายบนเสมอ
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[showListView(), addBuildingButton()],
    );
  }
}
