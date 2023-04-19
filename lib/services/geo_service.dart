import 'dart:convert';

import 'package:mvvm/models/raster_layer.dart';

import '../conf_global.dart';
import '../models/unit_area.dart';
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
}
