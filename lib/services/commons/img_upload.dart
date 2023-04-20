import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import 'exception.dart';

class ImgUploadService {
  Future sendImage({XFile? file}) async {
    try {
      String fileName = file!.path.split('/').last;

      FormData data = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });
      Dio dio = Dio();
      Response response = await dio.post("/mobile/image/upload", data: data);
      if (response.statusCode == 200) {
        return response.data["response"];
      } else {
        return false;
      }
    } catch (Ex) {
      throw CustomException(errorMsg: Ex.toString());
    }
  }
}
