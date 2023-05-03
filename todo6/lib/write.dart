


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/todo.dart';

class TodoWritePage extends StatefulWidget{

  final Todo todo;

  TodoWritePage({Key key, this.todo}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TodoWritePageState();
  }

}

class _TodoWritePageState extends State<TodoWritePage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(
        actions: [
          TextButton(
            child: Text("저장", style: TextStyle(color: Colors.white),),
            onPressed: (){
            },
          )
        ],
      ),
      body: ListView.builder(itemBuilder: (ctx,idx){
        if (idx==0){
          return Container(
            child:Text("오늘", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
          );
        }
        return Container();
      },
      itemCount: 3,),
    );
  }
}