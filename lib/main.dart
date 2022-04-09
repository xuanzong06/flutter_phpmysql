import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(HomeRoute());
}

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  TextEditingController? _firstNameController;
  TextEditingController? _lastNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  // Now lets add an Employee
  _addEmployee() {
    if (_firstNameController!.text.isEmpty || _lastNameController!.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    // _showProgress('Adding Employee...');
    print('_firstNameController!.text : '+_firstNameController!.text+ '   _lastNameController!.text :   '+_lastNameController!.text);
    Services.addEmployee(_firstNameController!.text, _lastNameController!.text)
        .then((result) {
          print(result);
      if ('success' == result) {
        print('successed');
        // _getEmployees(); // Refresh the List after adding each employee...
        // _clearValues();
        print("Add Employee Work Successed!!");
      }
    });
  }

  // 先從最基本的開始，是否可以傳值給php
  _addEmployee2() {
    addEmployee2(_firstNameController!.text, _lastNameController!.text).then((result) {
      print(result);
      if ('success' == result) {
        print('successed');
        // _getEmployees(); // Refresh the List after adding each employee...
        // _clearValues();
        print("Add Employee Work Successed!!");
      }
    });
  }

  static Future<String> addEmployee2(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = "flutter";
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      // final response = await http.post(Uri. parse('http://localhost:8888/testdb.php'), body: map);
      final response = await http.post(Uri. parse('http://192.168.31.167:8888/testdb.php'), body: map);
      print('addEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
  //function that I create for button event
  // _InsertProgress(){
  //   if(_firstNameController.text.isEmpty || _lastNameController.text.isEmpty){
  //
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Title"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'First Name',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Last Name',
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    // if (_firstNameController!.text.isEmpty ||
                    //     _lastNameController!.text.isEmpty) {
                    //   //_..Controller 加上驚嘆號的用途是檢查該參數是否為null，也可用問號，但問號不可以在條件中使用
                    //   print('欄位沒有值');
                    //   return; //跳出工作
                    // }
                    _addEmployee2();
                    print('Click Add Button');
                  },
                  child: Text('Add'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Employee {
  int? id;
  String? firstName;
  String? lastName;

  Employee({this.id, this.firstName, this.lastName});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );
  }
}

class Services {
  static const ROOT = 'http://localhost:8080/employee_actions.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  // Method to create the table Employees.
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Employee>> getEmployees() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('getEmployees Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Employee> list = parseResponse(response.body);
        return list;
      } else {
        List<Employee> result = <Employee>[];
        return result;
      }
    } catch (e) {
      List<Employee> result = <Employee>[];
      return result; // return an empty list on exception/error
    }
  }

  static List<Employee> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  // Method to add employee to the database...
  static Future<String> addEmployee(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(Uri. parse(ROOT), body: map);
      print('addEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an Employee in Database...
  static Future<String> updateEmployee(
      String empId, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('updateEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to Delete an Employee from Database...
  static Future<String> deleteEmployee(String empId) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('deleteEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}
