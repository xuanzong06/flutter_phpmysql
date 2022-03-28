import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Employee.dart';

class Service{
  static const ROOT = 'http://localhost/Employee/employee_action.php';

  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';

  //why would tutorial build create table function?

  static Future<String?> createTable() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    }catch(e){
      return 'error';
    }
  }

  static Future<List<Employee>> getEmployees() async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('getEmployees Response: ${response.body}');
      if( 200 == response.statusCode){
        List<Employee> list = parseResponse(response.body);
        return list;
      }else{
        return List<Employee>();
      }
    }catch(e){
      return List<Employee>(); //return an empty list on exception/error
    }
  }

  static List<Employee> parseResponse(String responseBody){
    final parsed = json.decode(responseBody).case<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  static Future<String> addEmployee(String userID, String userName, String userPW, String Comment) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_EMP_ACTION;
      map['userID'] = userID;
      map['userName'] = userName;
      map['userPW'] = userPW;
      map['Comment'] = Comment;
      final response = await http.post(ROOT, body: map);
      print('addEmployee Response: ${response.body}');
      if( 200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }

  static Future<String> updateEmployee(int userID, String userName, String userPW, String Comment) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_EMP_ACTION;
      map['userID'] = userID;
      map['userName'] = userName;
      map['userPW'] = userPW;
      map['Comment'] = Comment;
      final response = await http.post(ROOT, body: map);
      print('updateEmployee Response: ${response.body}');
      if( 200 == response.statusCode){
        List<Employee> list = parseResponse(response.body);
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error";
    }
  }

  static Future<String> deleteEmployee(int userID, String userName, String userPW, String Comment) async{
    try{
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_EMP_ACTION;
      map['userID'] = userID;
      map['userName'] = userName;
      map['userPW'] = userPW;
      map['Comment'] = Comment;
      final response = await http.post(ROOT, body: map);
      print('deleteEmployee Response: ${response.body}');
      if( 200 == response.statusCode){
        return response.body;
      }else{
        return "error";
      }
    }catch(e){
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}
