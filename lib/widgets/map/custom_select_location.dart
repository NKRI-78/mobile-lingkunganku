import 'dart:convert';

import 'package:flutter/material.dart';

import '../../misc/api_url.dart';
import '../../misc/http_client.dart';
import '../../misc/injections.dart';

class CustomSelectLocationWidget extends StatefulWidget {
  const CustomSelectLocationWidget({
    super.key,
    this.administration,
  });
  final SelectedAdministration? administration;

  static Future<SelectedAdministration?> go(BuildContext context,
      {SelectedAdministration? administration}) async {
    return Navigator.push<SelectedAdministration?>(
      context,
      MaterialPageRoute(
        builder: (_) => CustomSelectLocationWidget(
          administration: administration,
        ),
      ),
    );
  }

  @override
  State<CustomSelectLocationWidget> createState() =>
      _CustomSelectLocationWidgetState();
}

class _CustomSelectLocationWidgetState
    extends State<CustomSelectLocationWidget> {
  List<AdministrationModel> provinces = [];
  List<AdministrationModel> cities = [];
  List<AdministrationModel> districts = [];
  List<AdministrationModel> subDistricts = [];
  List<AdministrationModel> postalCodes = [];
  AdministrationModel? province;
  AdministrationModel? city;
  AdministrationModel? district;
  AdministrationModel? subDistrict;
  AdministrationModel? postalCode;

  TextEditingController searchController = TextEditingController();

  int menuIndex = 0;

  var client = getIt<BaseNetworkClient>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAdministration();
    });
  }

  void getAdministration() {
    if (widget.administration != null) {
      province = widget.administration?.province;
      city = widget.administration?.city;
      district = widget.administration?.district;
      subDistrict = widget.administration?.subDistrict;
      postalCode = widget.administration?.postalCode;
      menuIndex = 3;
      setState(() {});
    }
    fetchProvince();
    if (province != null) fetchCity(province!.name);
    if (city != null) fetchDistrict(city!.name);
    if (district != null) fetchSubDistrict(district!.name);
    // if (subDistrict != null) fetchPostalCodes(subDistrict!.name);
    if (city != null && district != null) {
      fetchPostalCodesV2(city!.name, district!.name);
    }
  }

  void fetchProvince() async {
    try {
      var res = await client
          .post(Uri.parse("${MyApi.baseUrl}/api/v1/administration/provinces"));

      provinces = (jsonDecode(res.body)['data'] as List)
          .map((e) => AdministrationModel.fromMap(e))
          .toList();
      setState(() {});
    } catch (e) {
      ///
    }
  }

  void fetchCity(String name) async {
    try {
      var res = await client.post(
          Uri.parse("${MyApi.baseUrl}/api/v1/administration/cities"),
          body: {"province_name": name});
      cities = (jsonDecode(res.body)['data'] as List)
          .map((e) => AdministrationModel.fromMap(e))
          .toList();
      setState(() {});
    } catch (e) {
      //
    }
  }

  void fetchDistrict(String name) async {
    try {
      var res = await client.post(
          Uri.parse("${MyApi.baseUrl}/api/v1/administration/districts"),
          body: {"city_name": name});
      districts = (jsonDecode(res.body)['data'] as List)
          .map((e) => AdministrationModel.fromMap(e))
          .toList();
      setState(() {});
    } catch (e) {
      //
    }
  }

  void fetchSubDistrict(String name) async {
    try {
      var res = await client.post(
          Uri.parse("${MyApi.baseUrl}/api/v1/administration/subdistricts"),
          body: {"district_name": name});

      subDistricts = (jsonDecode(res.body)['data'] as List)
          .map((e) => AdministrationModel.fromMap(e))
          .toList();
      setState(() {});
    } catch (e) {
      //
    }
  }

  void fetchPostalCodes(String name) async {
    try {
      var res = await client.post(
          Uri.parse("${MyApi.baseUrl}/api/v1/administration/postal-codes"),
          body: {
            "subdistrict_name": name,
          });

      postalCodes = (jsonDecode(res.body)['data'] as List)
          .map((e) => AdministrationModel.fromMap(e))
          .toList();
      setState(() {});
    } catch (e) {
      //
    }
  }

  void fetchPostalCodesV2(String cityName, String districtName) async {
    try {
      var res = await client.post(
          Uri.parse("${MyApi.baseUrl}/api/v1/administration/postal-codes"),
          body: {"district_name": districtName, "city_name": cityName});
      // print(res.data['data']);
      postalCodes = (jsonDecode(res.body)['data'] as List)
          .map((e) => AdministrationModel.fromMap(e))
          .toList();
      setState(() {});
    } catch (e) {
      // print(e.toString());
      //
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headers,
            _subMenuSelected,
            _titleSelected,
            _listContent,
          ],
        ),
      ),
    );
  }

  Widget get _headers => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (text) {
                      setState(() {});
                    },
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search ${titleSelectedString(menuIndex)}',
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      border: const OutlineInputBorder(),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
        ),
      );

  Widget get _subMenuSelected => Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Location',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: List.generate(menuIndex + 1, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () {
                      menuIndex = index;
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: index == menuIndex
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          index == menuIndex
                              ? getChooseByIndex(index) != '-'
                                  ? getChooseByIndex(index)
                                  : "Select ${titleSelectedString(index)}"
                              : getChooseByIndex(index),
                          style: TextStyle(
                              fontWeight: index == menuIndex
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: index == menuIndex
                                  ? Theme.of(context).colorScheme.primary
                                  : null),
                        )
                      ],
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );

  Widget get _titleSelected => Container(
        color: Colors.grey.shade200,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Text(
          titleSelectedString(menuIndex),
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      );

  Widget get _listContent {
    final list = getListByMenu(menuIndex);
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: List.generate(list.length, (index) {
          final data = list[index];
          return ListTile(
            onTap: () {
              switch (menuIndex) {
                case 1:
                  city = data;
                  menuIndex = 2;
                  searchController.text = '';
                  fetchDistrict(data.name);
                  setState(() {});
                  return;

                case 2:
                  district = data;
                  menuIndex = 3;
                  searchController.text = '';
                  fetchPostalCodesV2(city!.name, data.name);
                  setState(() {});

                  return;
                // case 3:
                //   subDistrict = data;
                //   menuIndex = 4;
                //   searchController.text = '';
                //   fetchPostalCodes(data.name);
                //   setState(() {});
                //   return;
                case 3:
                  postalCode = data;

                  Navigator.pop(
                    context,
                    SelectedAdministration(
                      city: city!,
                      province: province!,
                      subDistrict: AdministrationModel(
                          id: 'adm--', name: data.subdistrictName ?? '-'),
                      district: district!,
                      postalCode: postalCode!,
                    ),
                  );
                  return;
                default:
                  province = data;
                  menuIndex = 1;
                  searchController.text = '';
                  fetchCity(data.name);
                  setState(() {});
              }
            },
            title: Text(
              data.name,
            ),
          );
        }),
      ),
    );
  }

  String titleSelectedString(int index) {
    switch (index) {
      case 1:
        return 'City';
      case 2:
        return 'SUBDISTRICT';
      // case 3:
      //   return getTranslated("DISTRICT");
      case 3:
        return 'POSTAL CODE';
      default:
        return 'PROVINCE';
    }
  }

  String getChooseByIndex(int index) {
    switch (index) {
      case 1:
        return city?.name ?? '-';
      case 2:
        return district?.name ?? '-';
      // case 3:
      //   return subDistrict?.name ?? '-';
      case 3:
        return postalCode?.name ?? '-';
      default:
        return province?.name ?? '-';
    }
  }

  List<AdministrationModel> getListByMenu(int index) {
    List<AdministrationModel> list = [];
    switch (index) {
      case 1:
        list = cities;
      case 2:
        list = districts;
      // case 3:
      //   list = subDistricts;
      case 3:
        list = postalCodes;
      default:
        list = provinces;
    }

    return list
        .where((element) =>
            element.name.toLowerCase().contains(searchController.text))
        .toList();
  }
}

class SelectedAdministration {
  final AdministrationModel province;
  final AdministrationModel city;
  final AdministrationModel district;
  final AdministrationModel subDistrict;
  final AdministrationModel postalCode;

  SelectedAdministration({
    required this.province,
    required this.city,
    required this.district,
    required this.subDistrict,
    required this.postalCode,
  });
}

class AdministrationModel {
  // {
  //           "id": "00",
  //           "name": "BALI"
  //       }
  final String id;
  final String name;
  final String? subdistrictName;

  AdministrationModel({
    required this.id,
    required this.name,
    this.subdistrictName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'subdistricts_name': subdistrictName,
    };
  }

  factory AdministrationModel.fromMap(Map<String, dynamic> map) {
    return AdministrationModel(
      id: map['id'] as String,
      name: map['name'] as String,
      subdistrictName: map['subdistricts_name'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdministrationModel.fromJson(String source) =>
      AdministrationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
