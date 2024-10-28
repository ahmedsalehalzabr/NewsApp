class OrdersModel {
  String? id;
  String? userId;
  String? addressid;
  String? ordrsType;
  String? priceDelivery;
  String? ordersPrice;
  String? totalPrice;
  String? paymentMethod;
  String? status;
  String? orderDate;
  String? item;
  String? quantity;
  String? price;
  List<OrderItems>? orderItems;

  OrdersModel(
      {this.id,
        this.userId,
        this.addressid,
        this.ordrsType,
        this.priceDelivery,
        this.ordersPrice,
        this.totalPrice,
        this.paymentMethod,
        this.status,
        this.orderDate,
        this.item,
        this.quantity,
        this.price,
        this.orderItems});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    addressid = json['addressid'];
    ordrsType = json['ordrsType'];
    priceDelivery = json['priceDelivery'];
    ordersPrice = json['ordersPrice'];
    totalPrice = json['totalPrice'];
    paymentMethod = json['paymentMethod'];
    status = json['status'];
    orderDate = json['orderDate'];
    item = json['item'];
    quantity = json['quantity'];
    price = json['price'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['addressid'] = this.addressid;
    data['ordrsType'] = this.ordrsType;
    data['priceDelivery'] = this.priceDelivery;
    data['ordersPrice'] = this.ordersPrice;
    data['totalPrice'] = this.totalPrice;
    data['paymentMethod'] = this.paymentMethod;
    data['status'] = this.status;
    data['orderDate'] = this.orderDate;
    data['item'] = this.item;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    if (this.orderItems != null) {
      data['orderItems'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItems {
  String? id;
  String? title;
  String? shortDescription;
  String? featuredImageUrl;
  String? urlHandle;
  double? price;
  String? publishedDate;
  int? quantity;
  double? discount;


  OrderItems(
      {this.id,
        this.title,
        this.shortDescription,
        this.featuredImageUrl,
        this.urlHandle,
        this.price,
        this.publishedDate,
        this.quantity,
        this.discount,
       });

  OrderItems.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['shortDescription'] = this.shortDescription;
    data['featuredImageUrl'] = this.featuredImageUrl;
    data['urlHandle'] = this.urlHandle;
    data['price'] = this.price;
    data['publishedDate'] = this.publishedDate;
    data['quantity'] = this.quantity;
    data['discount'] = this.discount;

    return data;
  }
}
