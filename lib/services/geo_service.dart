import 'dart:convert';

import 'package:latlong2/latlong.dart';

import '../conf_global.dart';
import '../models/get_satelite_info.dart';
import '../models/raster_layer.dart';
import '../models/unit_area.dart';
import '../models/unit_area_number.dart';
import '../models/unit_area_satelite_info.dart';
import 'commons/api_helper.dart';

class GeoService {
  static Future<List<UnitArea>> getGeoUnitArea() async {
    var response = await ApiHelper().getUrl(
        url: '/mobile/parcel/bycompany/register?company_person_id=${Globals.personId}&season_id=${Globals.seasonId}');
    List<UnitArea> areas = List<UnitArea>.from(
      json.decode(response).map(
            (model) => UnitArea.fromJson(model),
          ),
    );

    return areas;
  }

  static Future<List<RasterLayer>> getRasterLayer() async {
    var response = await ApiHelper().getUrl(url: '/api/mobile/fill/layers');

    List<RasterLayer> layers = List<RasterLayer>.from(
      response.map(
        (model) => RasterLayer.fromJson(model),
      ),
    );
    return layers;
  }

  static Future<UnitAreaNumber> getUnitAreaNumber({LatLng? latLng}) async {
    var response = await ApiHelper()
        .getUrl(url: '/api/mobile/getparcelid/bycoords?coord_x=${latLng!.longitude}&coord_y=${latLng.latitude}');

    UnitAreaNumber unitAreaNumber = UnitAreaNumber.fromJson(json.decode(response));
    return unitAreaNumber;
  }

  static Future<UnitAreaSateliteInfo> getUnitAreaSateliteInfo({GetSateliteTypeInfo? typeInfo}) async {
    var response = await ApiHelper().getUrl(
        url:
            '/parcel/satellite/bypolygon?parcel_id=${typeInfo!.parcel_id}&image_type=${typeInfo.image_type}&sattelite_date=${typeInfo.sattelite_date}');
    UnitAreaSateliteInfo unitAreaSateliteInfo = UnitAreaSateliteInfo.fromJson(response);
    print(unitAreaSateliteInfo.toJson());
    return unitAreaSateliteInfo;
  }
}
