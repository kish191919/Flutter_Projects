import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/Todo.dart';

class TodoWritePage extends StatefulWidget{
  final Todo todo;

  TodoWritePage({Key key, this.todo}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TodoWritePAgeState();
  }
}

class _TodoWritePAgeState extends State<TodoWritePage>{

  TextEditingController nameController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  int colorIndex = 0;
  int ctIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.todo.title;
    memoController.text = widget.todo.memo;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text("Save", style: TextStyle(color: Colors.white),),
            onPressed: (){

              widget.todo.title = nameController.text;
              widget.todo.memo = memoController.text;

              Navigator.of(context).pop(widget.todo);

            },
          )
        ],
      ),
      body: ListView.builder(itemBuilder: (ctx,idx){
        if(idx==0){
          return Container(
            child: Text("제목", style: TextStyle(fontSize: 20),),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          );
        }else if(idx==1){
          return Container(
            child: TextField(
              controller: nameController,
            ),
            margin: EdgeInsets.symmetric(horizontal: 16),
          );
        } else if(idx==2){
          return InkWell (child: Container(
            margin: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("색상", style: TextStyle(fontSize: 20),),
                Container(
                  width: 20,
                  height: 20,
                  color: Color(Colors.red.value),
                )
              ],
            ),
          ),
            onTap: (){
            List<Color> colors=[
              Color(0xFF80d3f4),
              Color(0xFFa794fa),
              Color(0xFFfb91d1),
              Color(0xFFfb8a94),
              Color(0xFFfebd9a),
              Color(0xFF51e29d),
              Color(0xFFFFFFFF),
            ];

            widget.todo.color = colors[colorIndex].value;
            colorIndex ++;
            setState(() {
              colorIndex = colorIndex % colors.length;
            });

            }
          );
        } else if (idx==3){
          return InkWell(child: Container(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("카테고리", style: TextStyle(fontSize: 20),),
                Text(widget.todo.category)
              ],
            ),
          ),
          onTap: (){
            List<String> category=["Study", "Workout", "Game"];

            widget.todo.category = category[ctIndex];
            ctIndex ++;
            setState(() {
              ctIndex = ctIndex % category.length;
            });
          },);
        }
        return Container();
      },
      itemCount: 6,),
    );
  }

}