

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
  int colorIndex = 0;
  int ctIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
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
              child: Text("저장", style: TextStyle(color: Colors.white),),
          onPressed: (){
                widget.todo.title = nameController.text;
                widget.todo.memo = memoController.text;

                Navigator.of(context).pop(widget.todo);

                // 페이지 저장시
          },)
        ],
      ),
      body: ListView.builder(
          itemBuilder: (ctx, idx){
            if (idx == 0){
              return Container(
                child: Text("제목", style: TextStyle(fontSize: 20),),
                margin: EdgeInsets.symmetric(vertical:12, horizontal: 16),
              );
            } else if (idx ==1){
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: nameController,
                ),
              );
            } else if (idx ==2){
              return InkWell(child: Container(
                margin: EdgeInsets.symmetric(vertical:24, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("색상",style: TextStyle(fontSize: 20),),
                    Container(
                      height: 20,
                      width: 20,
                      color: Color(widget.todo.color),
                    )
                  ],
                ),
              ),
              onTap: (){
                  List<Color> colors = [
                    Color(0xFF80d3f4),
                    Color(0xFFa794fa),
                    Color(0xFFfb91d1),
                    Color(0xFFfb8a94),
                    Color(0xFFfebd9a),
                    Color(0xFF51e29d),
                    Color(0xFFFFFFFF),
                  ];

                  widget.todo.color = colors[colorIndex].value;
                  colorIndex++;
                  setState(() {

                    colorIndex = colorIndex % colors.length;
                  });

              },
              );
            } else if (idx==3){
              return InkWell(child: Container(
                margin: EdgeInsets.symmetric(vertical:24, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Category",style: TextStyle(fontSize: 20),),
                    Text(widget.todo.category)
                  ],
                ),
              ),
              onTap: (){
                List<String> category=["Study", "Meal", "WorkOut","Sleep"];

                widget.todo.category = category[ctIndex];
                ctIndex ++;
                setState(() {
                  ctIndex = ctIndex % category.length;
                });


              },
              );
            }else if (idx==4){
              return Container(
                margin: EdgeInsets.symmetric(vertical:12, horizontal: 16),
                child: Text("Memo",style: TextStyle(fontSize: 20),),
              );
            }else if (idx==5){
              return Container(
                margin: EdgeInsets.symmetric(vertical:1, horizontal: 16),
                child: TextField(
                  controller: memoController,
                  maxLines: 10,
                  minLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                  ),
                ),
              );
            }
            return Container();

          },
      itemCount: 6,),
    );
  }

}