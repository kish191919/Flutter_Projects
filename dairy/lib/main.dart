import 'package:dairy/data/dairy.dart';
import 'package:dairy/write.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/database.dart';
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
  final dbHelper = DatabaseHelper.instance;
  Dairy todayDiary;

  List<String> statusImg=[
    "assets/img/ico-weather.png",
    "assets/img/ico-weather_2.png",
    "assets/img/ico-weather_3.png",
  ];

  void getTodayDiary()async{
    List<Dairy> diary = await dbHelper.getDairyByDate(Utils.getFormatTime(DateTime.now()));
    if(diary.isNotEmpty){
      todayDiary = diary.first;
    }
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // initState  안에서는  set State 를 부를 수가 없음. 그래서 함수를 만들어서 넣음
    super.initState();
    getTodayDiary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: getPage(),),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          Dairy _d;
          if(todayDiary != null){
            _d = todayDiary;
          } else{
            _d = Dairy(
              date: Utils.getFormatTime(DateTime.now()),
              title: "",
              memo: "",
              status: 0,
              image: "assets/img/b3.jpg",
            );
          }

          await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DairyWritePage(dairy: _d
          )));
          getTodayDiary();

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
    if (todayDiary == null){
      return Container(
        child: Text("일기 작성을 해주세요!"),
      );
    } return Container(
      child: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(todayDiary.image, fit: BoxFit.cover,) ),
          Positioned.fill(
              child: ListView(
                children: [
                  Container(child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${DateTime.now().month}.${DateTime.now().day}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                      Image.asset(statusImg[todayDiary.status], fit: BoxFit.contain, )
                    ],
                  ),
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(todayDiary.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Container(height: 18,),
                        Text(todayDiary.memo, style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  )
                ])
          )],
      ) );
  }

  Widget getHistoryPage(){
    return Container();
  }

  Widget getChartPage(){
    return Container();
  }
}
