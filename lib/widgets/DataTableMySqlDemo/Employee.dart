class Employee{
  int? userID;
  String? userName;
  String? userPW;
  String? Comment;

  Employee({this.userID, this.userName, this.userPW, this.Comment});

  factory Employee.fromJson(Map<String, dynamic> json){
    return Employee(
      userID: json['userID'] as int,
      userName: json['userName'] as String,
      userPW: json['userPW'] as String,
      Comment: json['Comment'] as String,
    );
  }
}