

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/dairy.dart';
import 'data/database.dart';

class DairyWritePage extends StatefulWidget{

  final Dairy dairy;
  DairyWritePage({Key key, this.dairy}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _DairyWritePageState();

  }

}

class _DairyWritePageState extends State<DairyWritePage>{
  int imgIndex = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  final dbHelper = DatabaseHelper.instance;

  List<String> images=[
    "assets/img/b1.jpg",
    "assets/img/b2.jpg",
    "assets/img/b3.jpg",
    "assets/img/b4.jpg",
  ];

  List<String> statusImg=[
    "assets/img/ico-weather.png",
    "assets/img/ico-weather_2.png",
    "assets/img/ico-weather_3.png",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.dairy.title;
    memoController.text = widget.dairy.memo;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              child: Text("저장", style: TextStyle(color: Colors.white),),
            onPressed: () async{

                widget.dairy.title = nameController.text;
                widget.dairy.memo = memoController.text;

               await dbHelper.insertDairy(widget.dairy);
               Navigator.of(context).pop();

            },)
        ],
      ),
      body: ListView.builder(itemBuilder: (ctx, idx){

        if(idx==0){
          return InkWell(child: Container(
            height: 100,
            width: 100,

            child: Image.asset(widget.dairy.image, fit: BoxFit.cover,),
          ),
          onTap: (){
            setState(() {
              widget.dairy.image = images[imgIndex];
              imgIndex++;
              imgIndex = imgIndex % images.length;
            });
          },);
        } else if(idx==1){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(statusImg.length, (_idx){
                return InkWell(child : Container(
                  height: 70,
                  width: 70,
                  child: Image.asset(statusImg[_idx], fit: BoxFit.contain,),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    border: Border.all(color: _idx == widget.dairy.status ? Colors.blue : Colors.transparent),
                    borderRadius: BorderRadius.circular(100)
                  ),
                ),
                  onTap: (){
                  setState(() {
                    widget.dairy.status = _idx;
                  });

                });
              })
            ),
          );
        } else if(idx==2){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text("제목", style: TextStyle(fontSize: 20),),
          );
        } else if(idx==3){
          return Container(
            margin: EdgeInsets.symmetric( horizontal: 16),
            child: TextField(
              controller: nameController,
            ),
          );
        }

        else if(idx==4){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text("내용", style: TextStyle(fontSize: 20),),
          );
        }

        else if(idx==5){
          return Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: TextField(
              controller: memoController,
              minLines: 10,
              maxLines: 20,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)

                )
              ),
            ),
          );}
        return Container();

      },
      itemCount: 6,),


    );
  }
}