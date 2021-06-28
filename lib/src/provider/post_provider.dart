import 'package:flutter/material.dart';
import 'package:pickle/src/model/post.dart';

class PostProvider extends ChangeNotifier{
  List<Post> _postData = [
    Post(
        "assets/icons/default_icon1.png",
        "홍길동",
        ["assets/images/dog1.jpg","assets/images/dog2.jpg","assets/images/dog3.jpg"],
        "귀여운 강아지 고르기",
        ["김철수","김영희","쿠민이"],
        "모두 공개",
        []
    ),
    Post(
        "assets/icons/default_icon2.png",
        "김철수",
        ["assets/images/food1.jpg","assets/images/food2.jpg","assets/images/food3.jpg","assets/images/food4.jpg"],
        "점심 골라주세요",
        ["쿠민이","김영희"],
        "모두 공개",
        []
    ),
    Post(
        "assets/icons/default_icon3.png",
        "김영희",
        ["assets/images/cafe1.jpg","assets/images/cafe2.jpg","assets/images/cafe3.jpg","assets/images/cafe4.png","assets/images/cafe5.png"],
        "자주 가는 카페?",
        ["김철수","홍길동"],
        "모두 공개",
        []
    ),
    Post(
        "assets/icons/kakao_icon.jpg",
        "쿠민이",
        ["assets/images/iceCream1.jpg", "assets/images/iceCream2.jpg", "assets/images/iceCream3.jpg", "assets/images/iceCream4.jpg"],
        "아이스크림 뭐먹을까요? 추천해주세요!",
        [],
        "모두 공개",
        []
    ),
  ];
  List<Post> get getPostData => _postData;

  loadPosts() {
    //load
    notifyListeners();
  }
}