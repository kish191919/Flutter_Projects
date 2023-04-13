



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
  TextEditingController memoController = TextEditingController();

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
        } else if (idx==3){
          return Container(
            child: Row(
              children: [
                Text("카테고리"),
                Text(widget.todo.category)
              ],
            ),
          );
        } else if(idx==4){
          return Container(
            child: Text("메모"),
          );
        } else if(idx==5){
          return Container(
            child: TextField(
              controller: memoController,
              maxLines: 10,
              minLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
                )
              ),
            ),
          );
        }

        return Container();
      }),

    );

  }

}


