import 'dart:convert';

import 'package:http/http.dart' as http;

class FoodService{
  String api = "https://64fca63a605a026163aeb538.mockapi.io/Food";

  // without model pass Data

  Future<dynamic> FetchFoods() async{
    final responce = await http.get(Uri.parse(api));

    // print(responce.body);

    if(responce == null){
      throw Exception('Food Fetch Not Successful.');
    }

    final List finalResponce = jsonDecode(responce.body) as List;
    // print(finalResponce);

    return finalResponce;
  }
}