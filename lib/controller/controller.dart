import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa_app/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/model.dart';
import 'package:http/http.dart' as http;

class Controller {
  final String uri = "https://api.nasa.gov/planetary/apod?api_key=YQGdIgGdV8CILRe8h7maeXfFz6Ad6bgzGOb9ZNNk&start_date=2022-01-01&end_date=2022-02-01";


  Future <List<Nasa>> fetchNasa() async {
    var test = await getjson();
     if(test == []){


    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print("200");

      List<dynamic> jsonList1 = [];
      var jsonList = jsonDecode(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      for (var i = 0; i < jsonList.length; i++) {
        jsonList1.add(jsonList[i]);
      }
      final List<String> a = jsonList1.map((item) => jsonEncode(item)).toList();
      prefs.setStringList('json', a);
      jsonList1 = await getjson();
      if (jsonList1 is List) {
        print(jsonList1.toString());
        return jsonList1.map((json) => Nasa.fromJson(json)).toList();
      }
    }}
     else{
       List<dynamic> jsonList1 = [];
       jsonList1 = await getjson();
       if (jsonList1 is List) {
         print(jsonList1.toString());
         return jsonList1.map((json) => Nasa.fromJson(json)).toList();
       }
     }
    throw Exception("http call not made");
  }

  late List<String> jsonList;
  late List<dynamic> list;

  Future<List<dynamic>> getjson() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    jsonList = prefs.getStringList('json')!;
    list = jsonList.map((item) => jsonDecode(item)).toList();
    return list;
  }




  Future <List<Nasa>> RechNasa() async {
    final prefs = await SharedPreferences.getInstance();

      var jsonList = await getjson();
      List<dynamic> jsonList1 =[];
      String txt =  (await prefs.getString('search')).toString();
      print(txt);

      for(var i = 0; i < jsonList.length; i++){
        if ((DateTime.tryParse(jsonList[i]['date']) != null) && (jsonList[i]['date'] == txt)) {
          jsonList1.add(jsonList[i]);
        }
        else if(jsonList[i]['title'].toLowerCase() == txt.toLowerCase()){
          jsonList1.add(jsonList[i]);
        }
      }

      return jsonList1.map((json) => Nasa.fromJson(json)).toList();


  }

}