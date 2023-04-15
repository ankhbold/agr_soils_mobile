import '../conf_global.dart';
import '../models/unit_area_create_request.dart';
import 'commons/api_helper.dart';

class UnitAreaService {
  Future createUnitArea({CreateUnitAreaModelRequest? createUnitAreaModelRequest}) async {
    // print(createUnitAreaModelRequest!.toJson());
    var url =
        '/api/mobile/parcelnote/create?season_id=${Globals.seasonId}&company_person_id=${Globals.personId}&description=${createUnitAreaModelRequest!.description}&field_name=${createUnitAreaModelRequest.field_name}&cult_type=${createUnitAreaModelRequest.cult_type}&geom=${createUnitAreaModelRequest.geom}';
    var response = await ApiHelper().postUrl(url: url);
    return response;
  }
}
