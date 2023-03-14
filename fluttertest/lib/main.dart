import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _idx = 0;
  Color color = Colors.blue;
  int count1 = 0 ;
  int count2 = 0 ;
  String victeam = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    color = Colors.green;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(height: 50,),
          Text("탁구 대회", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Container(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("패스트 대학"),
              Text("캠퍼스 대학")
            ],
          ),
          Container(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("$count1점", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              Text("$count2점", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  IconButton(icon: Icon(Icons.add),
                      onPressed: (){
                      setState(() {
                        count1 = count1 + 1;
                        if(count1>10){
                          victeam = "패스트 대학 승리!";
                        }
                      });

                      }),
                  IconButton(icon: Icon(Icons.remove),
                      onPressed: (){
                      setState(() {
                        count1 = count1 - 1;
                      });
                      })
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(icon: Icon(Icons.add),
                      onPressed: (){
                      setState(() {
                        count2 = count2 + 1;
                        if(count2>10){
                        victeam = "캠퍼스 대학 승리!";
                        }
                      });
                      }),
                  IconButton(icon: Icon(Icons.remove),
                      onPressed: (){
                      setState(() {
                        count2 = count2 - 1;
                      });
                      })
                ],
              ),
            ],
          ),
          Container(height: 20,),
          Text(victeam, style: TextStyle(fontSize: 50, color: Colors.green ),)
        ],

      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
