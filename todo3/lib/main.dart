import 'package:flutter/material.dart';

import 'data/Todo.dart';

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
      home: MyHomePage(title: 'Todo3'),
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
      title: "English",
      memo: "2Hours",
      category: "Study",
      color: Colors.blue.value,
      done: 1,
      date: 20210315
    ),
    Todo(
        title: "Franch",
        memo: "10Hours",
        category: "Study",
        color: Colors.red.value,
        done: 0,
        date: 20210315
    )
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(child:AppBar(),preferredSize: Size.fromHeight(0)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          //화면이동
        },
      ),
      body: ListView.builder(itemBuilder: (ctx,idx){
        if(idx==0){
          return Container(
            child: Text("Today", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),);
        }else if(idx==1){
          List<Todo> undone = todos.where((t){
            return t.done == 0;
          }).toList();

          return Container(
            child: Column(
              children: List.generate(undone.length, (index){
                Todo t = undone[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Color(t.color),
                    borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.title, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                          Text(t.done == 0 ? "미완료": "완료", style: TextStyle(color: Colors.white),)],
                      ),
                      Container(
                        height: 16,
                      ),
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
        }else if (idx==2){
          return Container(
            child: Text("Done",  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),);
        }else if (idx==3){
          List<Todo> done = todos.where((t){
            return t.done == 1;
          }).toList();
          return Container(
            child: Column(
              children: List.generate(done.length, (index){
                Todo t = done[index];
                return Container(
                  decoration: BoxDecoration(
                      color: Color(t.color),
                      borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(t.title, style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                          Text(t.done == 0 ? "미완료": "완료", style: TextStyle(color: Colors.white),)],
                      ),
                      Container(
                        height: 16,
                      ),
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


        return Container();

      },
      itemCount: 4,),

      bottomNavigationBar: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.today_outlined),label: "Today"),
        BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined),label: "History"),
        BottomNavigationBarItem(icon: Icon(Icons.more),label: "More")
      ],
      ),



    );
  }
}
