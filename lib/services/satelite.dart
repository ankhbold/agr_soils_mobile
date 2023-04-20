import 'package:mvvm/models/satelite_layer_type.dart';
import 'package:mvvm/services/commons/api_helper.dart';

class SateliteService {
  Future<List<SateliteLayerType>> getSateliteTypes() async {
    var url = 'http://103.143.40.250:8100/api/mobile/satellite/imagetype';
    final response = await ApiHelper().getUrl(url: url);
    List<SateliteLayerType> types = (response as List).map((e) => SateliteLayerType.fromJson(e)).toList();
    return types;
  }
}
