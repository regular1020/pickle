class Post {
  late String icon;
  late String writer;
  late List<String> images;
  late String text;
  late List<String> picks;
  late String status;
  late List<String> comments;
  Post(String icon, String writer, List<String> images, String text, List<String> picks, String status, List<String> comments){
    this.icon = icon;
    this.writer = writer;
    this.images = images;
    this.text = text;
    this.picks = picks;
    this.status = status;
    this.comments = comments;
  }
}