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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("First App"),
            Icon(Icons.add),
            Container(
              child: Text("I am in container"),
              color: Colors.red,
            ),
            TextButton(child: Text("I am Text Button!"),
            onPressed: (){
              print("I am pressed!");
            },)
          ],
        ),
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

