



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/todo.dart';

class TodoWritePage extends StatefulWidget{

  final Todo todo;

  TodoWritePage({Key key, this.todo}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TodoWritePageState();

  }

}

class _TodoWritePageState extends State<TodoWritePage>{
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              child: Text("저장", style: TextStyle(color: Colors.white),),
          onPressed: (){
                // 저장페이지
          },)
        ],
      ),
      body: ListView.builder(itemBuilder: (ctx, idx){
        if (idx == 0){
          return Container(
            child: Text("제목"),
          );
        } else if (idx==1){
          return Container(
            child: TextField(
              controller: nameController,
            ),
          );
        } else if (idx==2){
          return Container(
            child: Row(
              children: [
                Text("색상"),
                Container(
                  width: 20,
                  height: 20,
                  color: Color(widget.todo.color),
                )
              ],
            ),
          );
        }

        return Container();
      }),

    );

  }

}


