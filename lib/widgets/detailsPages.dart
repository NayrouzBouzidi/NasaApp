import 'package:flutter/material.dart';
import '../Model/model.dart';

class DetailsPages extends StatelessWidget{

  final Nasa nasa ;
  const DetailsPages({Key? key, required this.nasa}) : super(key :key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(nasa.title),
      backgroundColor: Colors.black,),
      body: ListView(
        children:<Widget> [
          Stack(children:<Widget> [
            Container(child: Center(child: CircularProgressIndicator(),),),
            Hero(tag: nasa.date, child: Image.network(nasa.url,alignment: Alignment.center,fit: BoxFit.cover,))
          ],),
          Padding(padding: EdgeInsets.all(16.0),
          child: Row(children:<Widget> [Text(nasa.date,style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.normal,
          fontStyle: FontStyle.italic),),
        ],),),
          Padding(padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Text(
              nasa.explanation,
              style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
            ),)
        ],
      ),
    );
  }
}