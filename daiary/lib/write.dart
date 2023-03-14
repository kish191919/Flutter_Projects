

import 'package:daiary/data/diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryWritePage extends StatefulWidget{
  final Diary diary;

  DiaryWritePage({Key key, this.diary}) :super(key:key);

  @override
  State<StatefulWidget>createState(){
    return _DiaryWritePageState();

  }
}

class _DiaryWritePageState extends State<DiaryWritePage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold();
  }
}