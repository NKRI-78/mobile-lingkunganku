class PulsaDataModel {
  String? id;
  String? code;
  int? price;
  String? name;
  String? idpel;

  PulsaDataModel({
    this.id,
    this.code,
    this.price,
    this.name,
    this.idpel,
  });

  PulsaDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    code = json['code'];
    price = json['price'];
    name = json['name'];
    idpel = json['idpel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['price'] = price;
    data['name'] = name;
    data['idpel'] = idpel;
    return data;
  }
}
