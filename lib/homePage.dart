import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nasa_app/Model/model.dart';
import 'Widgets/error.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/controller.dart';
import 'widgets/nasaCard.dart';
class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  late Future<List<Nasa>> nasa;
  final String uri="https://api.nasa.gov/planetary/apod?api_key=YQGdIgGdV8CILRe8h7maeXfFz6Ad6bgzGOb9ZNNk&count=5";
  final myController = TextEditingController();

  Future meth ()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('search', myController.text);
  }
  @override
  initState() {
    super.initState();
    nasa =  Controller().fetchNasa();


  }

@override
Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: TextField(decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'find by title or date',
          hintStyle: Theme.of(context).textTheme.caption!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.5),
        ),
        ),
          style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color: Colors.white),
          controller: myController,
        ),

        elevation: 16.0,
        centerTitle: true,
        backgroundColor:  Colors.black,
        actions:<Widget> [
          IconButton(onPressed:(){
            setState(()  {
              meth();
             nasa = Controller().RechNasa();

            });
          }, icon: Icon(Icons.search))
        ],
      ),
      body:  new RefreshIndicator(
        onRefresh: () {  setState(() {
          nasa = Controller().fetchNasa();
        });return nasa; },
        child: FutureBuilder(
         future: nasa,
          builder: (BuildContext context,
          AsyncSnapshot<List<Nasa>> snapshot){
      if (snapshot.hasData) {
        return ListView(
          padding: EdgeInsets.all(16.0),
          children: snapshot.data!.map((nasa) =>
          NasaCard(nasa:nasa)).toList(),
        );
    }
      else if(snapshot.hasError){
        return Error(error : snapshot.error);
      }
      else{
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
        );
      }

          }


          ),)
        );
  }
}