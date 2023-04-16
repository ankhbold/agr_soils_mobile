import '../conf_global.dart';
import '../models/create_season_model.dart';
import 'commons/api_helper.dart';
import 'commons/apis.dart';

class SeasonService {
  Future<dynamic> createSeason({CreateSeasonModelRequest? createSeasonModelRequest}) async {
    String url =
        '${main_host_url}/api/mobile/season/create?company_id=${Globals.prof_company_id}&name=${createSeasonModelRequest!.name}&start=${createSeasonModelRequest.start}&end=${createSeasonModelRequest.end}';
    var response = await ApiHelper().postUrl(url: url);
    return response;
  }

  Future<dynamic> updateSeason({CreateSeasonModelRequest? createSeasonModelRequest}) async {
    String url =
        '${main_host_url}/api/mobile/season/update?season_id=${createSeasonModelRequest!.season_id}&company_id=${Globals.prof_company_id}&season_name=${createSeasonModelRequest.name}&start_date=${createSeasonModelRequest.start}&end_date=${createSeasonModelRequest.end}';
    print(url);
    var response = await ApiHelper().postUrl(url: url);
    return response;
  }

  Future<dynamic> deleteSeason({int? season_id}) async {
    String url = '${main_host_url}/api/mobile/season/delete?season_id=${season_id}';
    print(url);
    var response = await ApiHelper().deleteUrl(url: url);
    return response;
  }
}
