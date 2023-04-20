import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import 'exception.dart';

class ImgUploadService {
  Future<String?>? sendImage({XFile? file}) async {
    try {
      String fileName = file!.path.split('/').last;

      FormData data = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });
      Dio dio = Dio();
      Response response = await dio.post("http://103.143.40.250:8100/mobile/image/upload", data: data);

      if (response.statusCode == 200) {
        return response.data["url"];
      } else {
        return null;
      }
    } on DioError catch (ex) {
      print(ex.message);
    } catch (Ex) {
      print(Ex.toString());
      throw CustomException(errorMsg: Ex.toString());
    }
  }
}
