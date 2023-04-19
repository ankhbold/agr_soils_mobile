import 'dart:convert';

import 'package:mvvm/models/position_type.dart';
import 'package:mvvm/models/register_info.dart';

import '../models/company.dart';
import 'commons/api_helper.dart';

class RegisterService {
  static Future<dynamic> register({RegisterInfo? registerInfo}) async {
    //   username, password
    print(registerInfo!.toJson());
    var url =
        'http://103.143.40.250:8100/api/mobile/person/setcompany?prof_company_id=${registerInfo!.prof_company_id}&person_register=${registerInfo!.person_register}&firstname=${registerInfo.firstname}&lastname=${registerInfo.lastname}&phone=${registerInfo.phone}&position_type_id=${registerInfo.position_type_id}&email=${registerInfo.email}&username=${registerInfo.username}&password=${registerInfo.password}';
    final response = await ApiHelper().postUrl(url: url);
    return response;
  }

  static Future<CompanyInfo> registerNoSearchOrganization({String? registerNo}) async {
    var url = 'http://103.143.40.250:8100/api/mobile/profcompany/byregister?person_register=${registerNo}';
    final response = await ApiHelper().getUrl(url: url);
    CompanyInfo companyInfo = CompanyInfo.fromJson(response['data']);
    return companyInfo;
  }

  static Future<List<PositionType>> getPositionTypes({String? registerNo}) async {
    var url = 'http://103.143.40.250:8100/api/employee/position';
    final response = await ApiHelper().getUrl(url: url);
    // print(response);
    List<PositionType> types =
        List<PositionType>.from(json.decode(response).map((model) => PositionType.fromJson(model)));
    return types;
  }
}
