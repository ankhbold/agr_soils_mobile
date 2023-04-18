import 'package:mvvm/models/register_info.dart';

import '../models/company.dart';
import 'commons/api_helper.dart';

class RegisterService {
  static Future<dynamic> register({RegisterInfo? registerInfo}) async {
    var url =
        'http://103.143.40.250:8100/api/mobile/person/setcompany?prof_company_id=1&person_register=%D0%B8%D0%BE89080611&reg_user_id=';
  }

  static Future<CompanyInfo> registerNoSearchOrganization({String? registerNo}) async {
    var url = 'http://103.143.40.250:8100/api/mobile/profcompany/byregister?person_register=${registerNo}';
    final response = await ApiHelper().getUrl(url: url);
    CompanyInfo companyInfo = CompanyInfo.fromJson(response['data']);
    return companyInfo;
  }
}
