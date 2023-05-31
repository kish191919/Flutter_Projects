import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'data/database.dart';
import 'data/diary.dart';
import 'data/utils.dart';
import 'write.dart';

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
  Diary todayDiary;
  Diary historyDiary;
  DateTime time = DateTime.now();

  CalendarController calendarController = CalendarController();

  List<String> statusImg=[
    "assets/img/ico-weather.png",
    "assets/img/ico-weather_2.png",
    "assets/img/ico-weather_3.png",
  ];

  void getTodayDiary()async{
    List<Diary> diary = await dbHelper.getDiaryByDate(Utils.getFormatTime(DateTime.now()));
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
          if(selectIndex ==0){
            Diary _d;
            if(todayDiary != null){
              _d = todayDiary;
            } else{
              _d = Diary(
                date: Utils.getFormatTime(DateTime.now()),
                title: "",
                memo: "",
                status: 0,
                image: "assets/img/b3.jpg",
              );
            }
            await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DiaryWritePage(diary: _d
            )));
            getTodayDiary();
          } else if(selectIndex==1){
            Diary _d;
            if(historyDiary != null){
              _d = historyDiary;
            } else{
              _d = Diary(
                date: Utils.getFormatTime(time),
                title: "",
                memo: "",
                status: 0,
                image: "assets/img/b3.jpg",
              );
            }
            await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DiaryWritePage(diary: _d
            )));
            getDiaryByDate(time);

          }


        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: "오늘"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: "기록"),
          BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: "통계")
        ],
        currentIndex: selectIndex,
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

  void getDiaryByDate(DateTime date)async{
    List<Diary> d = await dbHelper.getDiaryByDate(Utils.getFormatTime(date));
    setState(() {
      if (d.isEmpty){
        historyDiary = null;
      } else{
        historyDiary = d.first;
      }
    });
  }

  Widget getHistoryPage(){
    return Container(
      child: ListView.builder(itemBuilder: (ctx, idx){
            if (idx==0){
              return Container(
                child: TableCalendar(
                  calendarController: calendarController,
                  onDaySelected: (date, events,holidays) {
                    print(date);
                    time=date;
                    getDiaryByDate(date);
                  },
                ),

              );
            } else if(idx==1){
              if(historyDiary == null){
                return Container();
              }
              return Container(
                child: Column(
                  children: [
                    Container(child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${time.month}.${time.day}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                              color: Colors.black),),
                        Image.asset(statusImg[historyDiary.status], fit: BoxFit.contain,)
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
                          Text(historyDiary.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          Container(height: 12,),
                          Text(historyDiary.memo, style: TextStyle(fontSize: 18),),
                          Image.asset(historyDiary.image, fit: BoxFit.cover,)
                        ],
                      ),
                    ),
                  ],
                ));
              }
            return Container();
          },
      itemCount: 2,),
    );
  }

  Widget getChartPage(){
    return Container();
  }
}
