import 'package:dairy/data/dairy.dart';
import 'package:dairy/write.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(child: getPage(),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          
          await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DairyWritePage(dairy:
          Dairy(
            date: Utils.getFormatTime(DateTime.now()),
            title: "",
            memo: "",
            status: 0,
            image: "assets/img/b2.jpg",

          ))));

        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: "오늘"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: "기록"),
          BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: "통계")
        ],
        onTap: (idx){
          setState(() {
            selectIndex = idx;
          });
        },
      ),
    );
  }

  Widget getPage(){

    if(selectIndex == 0){
      return getTodayPage();
    } else if(selectIndex ==1){
      return getHistoryPage();
    } else {
      return getChartPage();
    }

  }

  Widget getTodayPage(){

    return Container();

  }

  Widget getHistoryPage(){
    return Container();

  }

  Widget getChartPage(){
    return Container();

  }
}
