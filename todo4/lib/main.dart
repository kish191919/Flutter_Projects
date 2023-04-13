import 'package:flutter/material.dart';
import 'package:todo4/Write.dart';

import 'data/Todo.dart';
import 'data/Utils.dart';

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
      home: MyHomePage(title: 'Todo List'),
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

  List<Todo> todos = [
    Todo(
      title: "강의듣기",
      memo: "웹개발",
      color: Colors.red.value,
      done: 0,
      category: "Study",
      date: 20230301
    ),
    Todo(
        title: "강의듣기2",
        memo: "웹개발2",
        color: Colors.blue.value,
        done: 1,
        category: "Study",
        date: 20230301
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        child: AppBar(),
        preferredSize: Size.fromHeight(0),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: ()async{
          //화면이동
          Todo todo = await Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> TodoWritePage(todo: Todo(
            title: "",
            color: 0,
            memo: "",
            done: 0,
            category: "",
            date: Utils.getFormatTime(DateTime.now())
          ),)));

          setState(() {
            todos.add(todo);
          });

        },
      ),
      body: ListView.builder(itemBuilder: (ctx, idx) {
        if (idx==0){
          return Container(
            child: Text("오늘하루", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),);
        } else if (idx==1){

          List<Todo> undone = todos.where((t){
            return t.done == 0;
          }).toList();

          return Container(
            child: Column(
              children: List.generate(undone.length, (_idx){
                // return Text("$_idx");
                Todo t = undone[_idx];
                return Container(
                  decoration: BoxDecoration(
                    color: Color(t.color),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.title, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                          Text(t.done == 0 ? "미완료": "완료", style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      Container(height: 8,),
                      Text(t.memo, style: TextStyle(color: Colors.white),)
                    ],
                  ),
                );

              }),
            ),
          );
        } else if (idx==2){
          return Container(
            child: Text("완료된 하루", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),);
        } else if (idx==3){
          List<Todo> done = todos.where((t){
            return t.done == 1;
          }).toList();

          return Container(
            child: Column(
              children: List.generate(done.length, (_idx){
                // return Text("$_idx");
                Todo t = done[_idx];
                return Container(
                  decoration: BoxDecoration(
                      color: Color(t.color),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.title, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                          Text(t.done == 0 ? "미완료": "완료", style: TextStyle(color: Colors.white),)
                        ],
                      ),
                      Container(height: 8,),
                      Text(t.memo, style: TextStyle(color: Colors.white),)
                    ],
                  ),
                );

              }),
            ),
          );
        }




        return Container();
      },
      itemCount: 4,),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.today_outlined), label: "Today"),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.more), label: "More")
        ],
      ),


    );
  }
}
