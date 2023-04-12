import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import 'exception.dart';

class ImgUploadService {
  Future sendImage({XFile? file}) async {
    try {
      String fileName = file!.path.split('/').last;

      FormData data = FormData.fromMap({
        "upload": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });
      Dio dio = Dio();
      Response response = await dio.post("/upload-image/multipart", data: data);
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
