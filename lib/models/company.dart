import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
class CompanyInfo {
  int? prof_company_id;
  String? name;
  String? person_register;
  CompanyInfo({
    this.prof_company_id,
    this.name,
    this.person_register,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory CompanyInfo.fromJson(Map<String, dynamic> json) => _$CompanyInfoFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CompanyInfoToJson(this);
}
