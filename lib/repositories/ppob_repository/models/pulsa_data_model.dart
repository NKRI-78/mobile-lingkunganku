class PulsaDataModel {
  String? id;
  String? code;
  int? price;
  String? name;

  PulsaDataModel({this.id, this.code, this.price, this.name});

  PulsaDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    code = json['code'];
    price = json['price'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['price'] = price;
    data['name'] = name;
    return data;
  }
}
