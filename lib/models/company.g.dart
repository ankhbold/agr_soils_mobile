// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyInfo _$CompanyInfoFromJson(Map<String, dynamic> json) => CompanyInfo(
      prof_company_id: json['prof_company_id'] as int?,
      name: json['name'] as String?,
      person_register: json['person_register'] as String?,
    );

Map<String, dynamic> _$CompanyInfoToJson(CompanyInfo instance) =>
    <String, dynamic>{
      'prof_company_id': instance.prof_company_id,
      'name': instance.name,
      'person_register': instance.person_register,
    };
