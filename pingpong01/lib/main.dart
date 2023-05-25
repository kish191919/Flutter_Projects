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
  int count1=0;
  int count2=0;
  String victeam="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(height: 50,),
          Text("Table Tennis Competition!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), ),
          Container(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Red Team"),
              Text("Blue Team")],
          ),
          Container(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("$count1 점", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text("$count2 점", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ],
          ),
          Container(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  IconButton(icon: Icon(Icons.add), onPressed: (){
                    setState(() {
                      count1 = count1+1;
                      if(count1 > 10){
                        victeam = "Red Team";
                      }
                    });

                  }),
                  IconButton(icon: Icon(Icons.remove), onPressed: (){
                    setState(() {
                      count1 = count1-1;
                    });

                  })
                ],
              ),
              Row(
                children: [
                  IconButton(icon: Icon(Icons.add), onPressed: (){
                    setState(() {
                      count2 = count2+1;
                      if(count2 > 10){
                        victeam = "Blue Team";
                      }
                    });

                  }),
                  IconButton(icon: Icon(Icons.remove), onPressed: (){
                    setState(() {
                      count2 = count2-1;
                    });

                  })
                ],
              )
            ],
          ),
          Container(height: 50,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            Text("$victeam", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),),
            Text("Victory! ", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold))
          ])
        ],
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
