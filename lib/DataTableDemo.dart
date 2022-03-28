import 'package:flutter/material.dart';

import 'widgets/DataTableMySqlDemo/Employee.dart';
import 'widgets/DataTableMySqlDemo/Services.dart';

class DataTableDemo extends StatefulWidget {
  const DataTableDemo() : super();
  final String title = 'Flutter Data Table';

  State<StatefulWidget> create() {
    return null;
  }

  @override
  _DataTableDemoState createState() => _DataTableDemoState();
}

class _DataTableDemoState extends State<DataTableDemo> {
  List<Employee> _employee;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _userNameController;
  TextEditingController _userPWController;
  TextEditingController _Comment;
  Employee _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;

  void initState() {
    super.initState();
    _employee = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _userNameController = TextEditingController();
    _userPWController = TextEditingController();
    _Comment = TextEditingController();

    _showProgress(String message){
      setState(() {
        _titleProgress = message;
      });
    }

    _showSnackBar(context, message){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message),),);
    }

    _createTable() {
      _showProgress('Creating Table...');
      Service.createTable().then((result) => {
        if('success' == result){
          _showSnackBar(context, result);
        }
      });
    }

    _addEmployee() {}

    _getEmployee() {}

    _updateEmployee() {}

    _deleteEmployee() {}
  }

  //Method to clear TextField values
  _clearValues(){
    _userNameController.text = '';
    _userPWController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _createTable();
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              _getEmployee();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _userNameController,
                decoration: InputDecoration.collapsed(hintText: 'User Name'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _userPWController,
                decoration: InputDecoration.collapsed(hintText: 'User PW'),
              ),
            ),
            // Add an update button and a Cancel Button
            // show these buttons only when updating an employee
            _isUpdating?
            Row(
              children: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    _updateEmployee();
                  },
                  child: Text('UPDATE'),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _isUpdating = false;
                    });
                    _clearValues();
                  },
                  child: Text('CANCLE'),
                ),
              ],
            ):Container(

            ),
          ],
        ),
      ),
    );
  }
}
