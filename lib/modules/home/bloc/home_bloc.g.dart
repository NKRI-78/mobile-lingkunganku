// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeState _$HomeStateFromJson(Map<String, dynamic> json) => HomeState(
      selectedIndex: (json['selectedIndex'] as num?)?.toInt() ?? 0,
      news: (json['news'] as List<dynamic>?)
              ?.map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      nextPageNews: (json['nextPageNews'] as num?)?.toInt() ?? 1,
      isLoading: json['isLoading'] as bool? ?? false,
      profile: json['profile'] == null
          ? null
          : ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeStateToJson(HomeState instance) => <String, dynamic>{
      'selectedIndex': instance.selectedIndex,
      'news': instance.news,
      'nextPageNews': instance.nextPageNews,
      'isLoading': instance.isLoading,
      'profile': instance.profile,
    };
