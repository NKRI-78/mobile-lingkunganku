// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) => AppState(
      profile: json['profile'] == null
          ? null
          : ProfileModel.fromJson(json['profile'] as Map<String, dynamic>),
      badges: json['badges'] == null
          ? null
          : NotificationCountModel.fromJson(
              json['badges'] as Map<String, dynamic>),
      iuranBadges: json['iuranBadges'] == null
          ? null
          : IuranCountModel.fromJson(
              json['iuranBadges'] as Map<String, dynamic>),
      alreadyOnboarding: json['alreadyOnboarding'] as bool? ?? false,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String? ?? '',
      loadingNotif: json['loadingNotif'] as bool? ?? false,
      alreadyShowTermCondition:
          json['alreadyShowTermCondition'] as bool? ?? false,
    );

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'badges': instance.badges,
      'iuranBadges': instance.iuranBadges,
      'alreadyOnboarding': instance.alreadyOnboarding,
      'user': instance.user,
      'token': instance.token,
      'loadingNotif': instance.loadingNotif,
      'profile': instance.profile,
      'alreadyShowTermCondition': instance.alreadyShowTermCondition,
    };
