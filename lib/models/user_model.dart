class UserModel {
  String name;
  String path;
  String position;
  String lat;
  String long;

  UserModel({this.name, this.path, this.position, this.lat, this.long});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    path = json['Path'];
    position = json['Position'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Path'] = this.path;
    data['Position'] = this.position;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
