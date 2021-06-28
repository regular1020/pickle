import 'package:flutter/material.dart';
import 'package:pickle/src/model/result.dart';

class ResultProvider extends ChangeNotifier{
  List<Result> _result = [
    Result(
      "assets/images/31.jpg",
      "베스킨라빈스 최애 메뉴는?",
      "쿠민이",
      "2021-06-21T14:58:04+09:00",
    ),
    Result(
      "assets/images/dessert1.jpg",
      "디저트 골라주세요?",
      "이집피클잘하네",
      "2020-12-31T17:23:04+09:00",
    ),
    Result(
      "assets/images/travel1.jpg",
      "가장 여행가고싶은 나라는?",
      "ㅇㅇㅇ",
      "2021-03-02T09:22:04+09:00",
    ),
  ];
  List<Result> get getResult => _result;

  loadResult (){
    //load
    notifyListeners();
  }
}