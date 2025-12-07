
import 'dart:convert';

import 'package:riverpod_exercise/Faculty_CRUD_Using_RiverPod/Model/faculty_model.dart';
import 'package:http/http.dart' as http;

class FacultyService {

  final String API = "http://localhost:8000";

  Future<List<FacultyModel>> FetchData() async{
    final responce = await http.get(
      Uri.parse(API+'/faculties'),
    );

    if(responce.body == null || responce.statusCode == 404){
      throw Exception('Data Not Fetch');
    }

    List<dynamic> dynamicFac = jsonDecode(responce.body);

    List<FacultyModel> ListFac = FacultyModel.ListFaculty(dynamicFac);

    return ListFac;
  }

  Future<FacultyModel> FetchDataById(Object id) async{
    final responce = await http.get(
      Uri.parse(API+'/faculties/$id'),
    );

    if(responce.body == null || responce.statusCode == 404){
      throw Exception('Data Not Fetch');
    }

    dynamic dynamicFac = jsonDecode(responce.body);

    FacultyModel Fac = FacultyModel.fromJson(dynamicFac);

    return Fac;
  }

  Future<bool> InsertData(String encoded_fac) async{
    final responce = await http.post(
      Uri.parse(API+'/add'),
      headers: {
        'Content-Type' : "application/json"
      },
      body: encoded_fac,
    );

    if(responce.statusCode == 200 || responce.statusCode == 201) return true;

    return false;
  }

  Future<bool> UpdateData(Object id,String encoded_fac) async{
    
    final responce = await http.patch(
      Uri.parse(API+'/edit/${id}'),
      headers: {
        'Content-Type' : 'application/json',
      },
      body: encoded_fac,
    );

    if(responce.statusCode == 200 || responce.statusCode == 201)return true;

    return false;
  }

  Future<bool> DeleteData(Object id) async {
    final responce = await http.delete(
      Uri.parse(API+'/faculties/$id'),
    );

    if(responce.statusCode == 200 || responce.statusCode == 201) return true;

    return false;
  }

}