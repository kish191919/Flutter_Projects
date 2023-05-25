import 'package:flutter/material.dart';

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
  int _counter = 0;
  int _idx = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text("Project Test"),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1,
          children: [
            InkWell(child : Text("name"),
            onTap: (){
              print("name is clicked");
            },),
            Container(
                margin: EdgeInsets.all(20),
                color: Colors.blue,
                child: Text("Danny")),
            Container(
                padding: EdgeInsets.all(20),
                color: Colors.red,
                child: Text("name1")),
            GestureDetector(child: Text("Danny2"),
            onTap: (){
              print("danny2 is detected");
            },),
            Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                color: Colors.green,
                child: Text("name3")),
            Text("Danny3"),
            Text("name4"),
            Text("Danny4"),
          ],
        )

          // 2. Listtile
        // ListView(
        //   children: [
        //     ListTile(
        //       title: Text("Name"),
        //       trailing: Text("Danny"),
        //       onTap: (){
        //         print("pressed listtile");
        //       },
        //     )
        //   ],
        // ),

        // 1.List View
        // child: ListView(
        //   // 가로로 보고 싶을때
        //   // scrollDirection: Axis.horizontal,
        //   children: [
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //     Text("name"),
        //     Text("Danny"),
        //   ],
        // )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("FAB is pressed");
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.more), label: "more"),
          BottomNavigationBarItem(icon: Icon(Icons.more), label: "more1"),
        ],
        onTap: (index){
          print(index);
          setState(() {
            _idx = index;
          });
        },
        // currentIndex: 2,
        currentIndex: _idx,
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

