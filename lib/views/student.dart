import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/student_manager.dart';

class StudentPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            child: Text(
              '新增',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              StudentManager.instance.insert();
            },
          ),
          ElevatedButton(
            child: Text(
              '查詢',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              StudentManager.instance.query();
            },
          ),
          ElevatedButton(
            child: Text(
              '修改',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              StudentManager.instance.update();
            },
          ),
          ElevatedButton(
            child: Text(
              '刪除',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              StudentManager.instance.delete();
            },
          ),
        ],
      ),
    );
  }
}
