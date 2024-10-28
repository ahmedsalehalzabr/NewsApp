class CategoryModel {
  String? id;
  String? name;
  String? urlHandle;
  String? shortDescription;
  String? featuredImageUrl;
  List<Items>? items;

  CategoryModel(
      {this.id,
        this.name,
        this.urlHandle,
        this.shortDescription,
        this.featuredImageUrl,
        this.items});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    urlHandle = json['urlHandle'];
    shortDescription = json['shortDescription'];
    featuredImageUrl = json['featuredImageUrl'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['urlHandle'] = this.urlHandle;
  //   data['shortDescription'] = this.shortDescription;
  //   data['featuredImageUrl'] = this.featuredImageUrl;
  //   if (this.items != null) {
  //     data['items'] = this.items!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Items {
  String? id;
  String? title;
  String? shortDescription;
  String? featuredImageUrl;
  String? urlHandle;
  double? price;
  String? publishedDate;
  int? quantity;
  double? discount;
  Items(
      {this.id,
        this.title,
        this.shortDescription,
        this.featuredImageUrl,
        this.urlHandle,
        this.price,
        this.publishedDate,
        this.quantity,
        this.discount});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDescription = json['shortDescription'];
    featuredImageUrl = json['featuredImageUrl'];
    urlHandle = json['urlHandle'];
    price = json['price'];
    publishedDate = json['publishedDate'];
    quantity = json['quantity'];
    discount = json['discount'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['shortDescription'] = this.shortDescription;
  //   data['featuredImageUrl'] = this.featuredImageUrl;
  //   data['urlHandle'] = this.urlHandle;
  //   data['publishedDate'] = this.publishedDate;
  //   return data;
  // }
}
