import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/data/database.dart';
import 'package:todo/write.dart';

import 'data/todo.dart';
import 'data/util.dart';

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
  final dbHelper = DatabaseHelper.instance;
  int selectIndex = 0;

  List<Todo> todos = [
    // Todo(
    //   title: "패스트캠퍼스 강의듣기",
    //   memo: "앱개발 입문강의",
    //   color: Colors.redAccent.value,
    //   done:0,
    //   category: "공부",
    //   date: 20210709
    // ),
    // Todo(
    //     title: "패스트캠퍼스 강의듣기2",
    //     memo: "앱개발 입문강의",
    //     color: Colors.blue.value,
    //     done:1,
    //     category: "공부",
    //     date: 20210709
    // ),
  ];

  void getTodayTodo() async {
    todos = await dbHelper.getTodoByDate(Utils.getFormatTime(DateTime.now()));
    setState(() {});
  }

  void getAllTodo() async {
    allTodo = await dbHelper.getAllTodo();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getTodayTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(),
        preferredSize: Size.fromHeight(0),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          // 화면이동
          Todo todo = await Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => TodoWritePage(
                    todo: Todo(
                        title: "",
                        color: 0,
                        memo: "",
                        done: 0,
                        category: "",
                        date: Utils.getFormatTime(
                            DateTime.now().subtract(Duration(days: 2)))),
                  )));
          getTodayTodo();
        },
      ),
      body: getPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.today_outlined), label: "오늘"),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined), label: "기록"),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "더보기"),
        ],
        currentIndex: selectIndex,
        onTap: (idx) {
          if (idx == 1) {
            getAllTodo();
          }
          setState(() {
            selectIndex = idx;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getPage() {
    if (selectIndex == 0) {
      return getMain();
    } else {
      return getHistory();
    }
  }

  Widget getMain() {
    return ListView.builder(
      itemBuilder: (ctx, idx) {
        if (idx == 0) {
          return Container(
            child: Text(
              "오늘하루",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          );
        } else if (idx == 1) {
          List<Todo> undone = todos.where((t) {
            return t.done == 0;
          }).toList();

          return Container(
            child: Column(
              children: List.generate(undone.length, (_idx) {
                Todo t = undone[_idx];
                return InkWell(
                  child: TodoCardWidget(t: t),
                  onTap: () async {
                    setState(() {
                      if (t.done == 0) {
                        t.done = 1;
                      } else {
                        t.done = 0;
                      }
                    });
                    await dbHelper.insertTodo(t);
                  },
                  onLongPress: () async {
                    getTodayTodo();
                  },
                );
              }),
            ),
          );
        } else if (idx == 2) {
          return Container(
            child: Text(
              "완료된 하루",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          );
        } else if (idx == 3) {
          List<Todo> done = todos.where((t) {
            return t.done == 1;
          }).toList();
          return Container(
            child: Column(
              children: List.generate(done.length, (_idx) {
                Todo t = done[_idx];
                return InkWell(
                    child: TodoCardWidget(t: t),
                    onTap: () async {
                      setState(() {
                        if (t.done == 0) {
                          t.done = 1;
                        } else {
                          t.done = 0;
                        }
                      });
                      await dbHelper.insertTodo(t);
                    },
                    onLongPress: () async {
                      Todo todo = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) => TodoWritePage(todo: t)));
                      setState(() {});
                    });
              }),
            ),
          );
        }
        return Container();
      },
      itemCount: 4,
    );
  }

  List<Todo> allTodo = [];

  Widget getHistory() {
    return ListView.builder(
      itemBuilder: (ctx, idx) {
        return TodoCardWidget(t: allTodo[idx]);
      },
      itemCount: allTodo.length,
    );
  }
}

class TodoCardWidget extends StatelessWidget {
  final Todo t;

  TodoCardWidget({Key key, this.t}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int now = Utils.getFormatTime(DateTime.now());
    DateTime time = Utils.numToDateTime(t.date);

    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          color: Color(t.color), borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                t.done == 0 ? "미완료" : "완료",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Container(
            height: 12,
          ),
          Text(
            t.memo,
            style: TextStyle(color: Colors.white),
          ),
          now == t.date
              ? Container()
              : Text(
                  "${time.month}월 ${time.day}일",
                  style: TextStyle(color: Colors.white),
                )
        ],
      ),
    );
  }
}
