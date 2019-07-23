
class HomeModel {
  final String name;
  final String msg;
  final String imgUrl;

  HomeModel({this.name, this.msg, this.imgUrl});

  factory HomeModel.fromJson(Map json){

    return HomeModel(
      name: json['name'],
      msg:  json['message'],
      imgUrl: json['imgUrl'],
    );
  }
}
