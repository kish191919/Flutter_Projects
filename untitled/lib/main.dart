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
  int count1 = 0;
  int count2 = 0;
  String victeam = "";


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [
            Container(height: 50,),
            Text("Table Tennis Competition",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            Container(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Red Team", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Text("Blue Team", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ],
            ),
            Container(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("$count1점"),
                Text("$count2점"),
              ],
            ),
            Container(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(icon: Icon(Icons.add), onPressed: (){
                      setState(() {
                        count1 = count1 + 1;
                        if(count1 > 10){
                          victeam = "Red team Victory";
                        }
                      });

                    }, color: Colors.red,),
                    IconButton(icon: Icon(Icons.remove), onPressed: (){
                      setState(() {
                        count1 = count1 - 1;
                      });
                    }),
                    IconButton(icon: Icon(Icons.add), onPressed: (){
                      setState(() {
                        count2 = count2 + 1;
                        if(count2 > 10){
                          victeam = "Blue team Victory";
                        }
                      });

                    }, color: Colors.blue,),
                    IconButton(icon: Icon(Icons.remove), onPressed: (){
                      setState(() {
                        count2 = count2 - 1;
                      });
                    }),
                  ],
                ),
            Container(height: 20,),
            Text("$victeam", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.green),
            )


    ]))
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
