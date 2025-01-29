class CityModel {
    String cityName;

    CityModel({
        required this.cityName,
    });

    factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        cityName: json["city_name"],
    );

    Map<String, dynamic> toJson() => {
        "city_name": cityName,
    };
}