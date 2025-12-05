import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_exercise/Section2/FutureProviderDemo/StudentModel.dart';
import 'package:riverpod_exercise/Section2/StateNotifierDemo/student_api_example/student_model.dart';

class Student_Service{
  String API = "https://64fca63a605a026163aeb538.mockapi.io/Student";

  // with Model

  Future<List<StudentModel>> FetchAPI() async{
    final responce = await http.get(Uri.parse(API));

    if(responce.statusCode != 200 || responce.body == null){
      throw Exception("Student Data Not Found.");
    }

    final List dynamicList = jsonDecode(responce.body);

    final List<StudentModel> StudentList = StudentModel.listStudent(dynamicList);

    print("=====================");
    print(StudentList);

    return StudentList;
  }

  Future<Student_Model> GetStudent(String id) async{
    final responce = await http.get(Uri.parse(API+"/${id}"));

    if(responce.statusCode != 200 || responce.body == null){
      throw Exception("Student Data Not Found.");
    }

    Student_Model S = jsonDecode(responce.body);

    return S;
  }

  Future<bool> InsertData(Student_Model s) async{
    final responce = await http.post(Uri.parse(API),body: jsonEncode(s));
    print(responce.statusCode);
    if(responce.statusCode == 201 || responce.body != null) return true;

    return false;
  }

  Future<bool> UpdateData(Student_Model s) async{
    final responce = await http.put(Uri.parse(API+"/${s.id}"),body: jsonEncode(s));

    if(responce.statusCode == 201 || responce.body != null) return true;

    return false;
  }

  Future<bool> DeleteData(String id) async{
    final responce = await http.delete(Uri.parse(API+"/${id}"));

    print(responce);
    if(responce.statusCode == 201 || responce.body != null) return true;

    return false;
  }

}