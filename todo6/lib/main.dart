import 'package:flutter/material.dart';
import 'package:todo6/data/utils.dart';
import 'package:todo6/write.dart';

import 'data/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Todo> todos=[
    Todo(
      title: "아린이 숙제",
      memo: "수학문제 10개 풀어주세요",
      color: Colors.blue.value,
      done: 0,
      date: 20230501
    ),
    Todo(
        title: "하린이 숙제",
        memo: "그림그리기",
        color: Colors.red.value,
        done: 1,
        date: 20230501
    )
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:PreferredSize(
        child: AppBar(),
        preferredSize: Size.fromHeight(0),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
        // 화면이동
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => TodoWritePage(todo: Todo(
          title:"",
          color:0,
          memo:"",
          done: 0,
          category: "",
          date:Utils.getFormatTime(DateTime.now())
        ),)));}
      ),
      body: ListView.builder(itemBuilder: (ctx, idx){
        if (idx==0) {
          return Container(
            child: Text("오늘하루",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          margin: EdgeInsets.symmetric(vertical:12, horizontal: 20),);
        } else if (idx ==1){
          List<Todo> undone=todos.where((t){
            return t.done==0;
          }).toList();
          return Container(
            child: Column(
              children: List.generate(undone.length, (_idx){
                Todo t = undone[_idx];
                return Container(
                  decoration: BoxDecoration(
                    color: Color(t.color),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.title,style: TextStyle(fontSize:18, color: Colors.white, fontWeight: FontWeight.bold),),
                          Text(t.done == 0 ? "미완성" : "완료", style: TextStyle(color:Colors.white),
                          )
                        ],
                      ),
                      Container(height: 16,),
                      Row(
                        children: [
                          Text(t.memo, style: TextStyle(color: Colors.white),)
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
          );

        } else if (idx == 2){
          return Container(
            child: Text("완료된 하루",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            margin: EdgeInsets.symmetric(vertical:12, horizontal: 20),);
        } else if (idx ==3){
          List<Todo> done=todos.where((t){
            return t.done==1;
          }).toList();
          return Container(
            child: Column(
              children: List.generate(done.length, (_idx){
                Todo t = done[_idx];
                return Container(
                  decoration: BoxDecoration(
                      color: Color(t.color),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.title,style: TextStyle(fontSize:18, color: Colors.white, fontWeight: FontWeight.bold),),
                          Text(t.done == 0 ? "미완성" : "완료", style: TextStyle(color:Colors.white),
                          )
                        ],
                      ),
                      Container(height: 16,),
                      Row(
                        children: [
                          Text(t.memo, style: TextStyle(color: Colors.white),)
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
          );

        }

        else{
          return Container();
        }
      },
      itemCount: 4,),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.today_outlined), label: "Today"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label:"History"),
          BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), label: "Game")
        ],
      ),
    );

  }
}
