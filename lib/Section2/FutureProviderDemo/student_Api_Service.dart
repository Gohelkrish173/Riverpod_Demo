import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_exercise/Section2/FutureProviderDemo/StudentModel.dart';

class Student_Service{
  String API = "https://64fca63a605a026163aeb538.mockapi.io/Student";

  // with Model

  Future<dynamic> FetchAPI() async{
    final responce = await http.get(Uri.parse(API));

    if(responce.body == null){
      throw Exception("Student Data Not Found.");
    }

    final List dynamicList = jsonDecode(responce.body);

    final List<StudentModel> StudentList = StudentModel.listStudent(dynamicList);

    print("=====================");
    print(StudentList);

    return StudentList;
  }
}