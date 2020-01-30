class BuildingModel {
  String id;
  String name;
  String detail;
  String urlImage;
  String lat;
  String lng;

  BuildingModel(
      {this.id, this.name, this.detail, this.urlImage, this.lat, this.lng});

  BuildingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    detail = json['Detail'];
    urlImage = json['UrlImage'];
    lat = json['Lat'];
    lng = json['Lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Detail'] = this.detail;
    data['UrlImage'] = this.urlImage;
    data['Lat'] = this.lat;
    data['Lng'] = this.lng;
    return data;
  }
}
