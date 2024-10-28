class AddressModel {
  String? id;
  String? userId;
  String? name;
  String? city;
  String? street;
  double? lat;
  double? long;

  AddressModel(
      {this.id,
        this.userId,
        this.name,
        this.city,
        this.street,
        this.lat,
        this.long});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    name = json['name'];
    city = json['city'];
    street = json['street'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['city'] = this.city;
    data['street'] = this.street;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
