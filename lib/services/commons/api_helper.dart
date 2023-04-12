import 'dart:io';

import 'package:dio/dio.dart';

import '../../utils/network_check.dart';
import 'exception.dart';

class ApiHelper {
  Dio createDio() {
    var dio = Dio();
    dio.options.baseUrl = 'http://103.143.40.250:8100';
    dio.options.connectTimeout = 40000; //40s
    dio.options.receiveTimeout = 40000;
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        return handler.next(options); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: `handler.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: `handler.reject(dioError)`
      }, onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response); // continue
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: `handler.reject(dioError)`
      }, onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: `handler.resolve(response)`.
      }),
    );
    return dio;
  }

  Future<dynamic> postUrl({String? url, Map<String, dynamic>? body, bool? isPublic = false}) async {
    var dio = createDio();
    bool checkConnection = await NetWorkUtils().checkInternetConnection();
    if (!checkConnection) {
      throw CustomException(errorMsg: "Интернэт холболтоо шалгана уу");
    }
    try {
      // if (!isPublic!) dio.options.headers['access_token'] = await getToken();

      Response response = await dio.post(url!, data: body);

      return response.data;
    } on DioError catch (ex) {
      var decodedResp = ex.response!.data;
      print(decodedResp);
      if (decodedResp != null) {
        throw CustomException(errorMsg: decodedResp['message']['mongolian']);
      } else {
        throw CustomException(errorMsg: "сервертэй холбогдоход алдаа гарлаа");
      }
    } on SocketException catch (ex) {
      print(ex.message.toString());
      throw CustomException(errorMsg: ex.message);
    } catch (ex) {
      print(ex.toString());
      throw CustomException(errorMsg: ex.toString());
    }
  }

  Future<dynamic> getUrl({String? url, bool? isPublic}) async {
    var dio = createDio();
    bool checkConnection = await NetWorkUtils().checkInternetConnection();
    if (!checkConnection) {
      throw CustomException(errorMsg: "Интернэт холболтоо шалгана уу");
    }
    try {
      // dio.options.headers['access_token'] = await getToken();
      Response response = await dio.get(url!);
      // print(response.data);
      return response.data;
    } on DioError catch (ex) {
      var decodedResp = ex.response!.data;
      print(decodedResp);
      if (decodedResp != null) {
        throw CustomException(errorMsg: decodedResp['message']['mongolian']);
      } else {
        throw CustomException(errorMsg: "сервертэй холбогдоход алдаа гарлаа");
      }
    } on SocketException catch (ex) {
      print(ex.message.toString());
      throw CustomException(errorMsg: ex.toString());
    } catch (ex) {
      print(ex.toString());
      throw CustomException(errorMsg: ex.toString());
    }
  }

  Future<dynamic> putUrl({String? url, Map<String, dynamic>? body, bool? isPublic}) async {
    var dio = createDio();
    bool checkConnection = await NetWorkUtils().checkInternetConnection();
    if (!checkConnection) {
      throw CustomException(errorMsg: "Интернэт холболтоо шалгана уу");
    }
    try {
      // dio.options.headers['access_token'] = await getToken();
      Response response = await dio.put(url!, data: body);
      return response.data;
    } on DioError catch (ex) {
      var decodedResp = ex.response!.data;
      // print(decodedResp);
      if (decodedResp != null) {
        throw CustomException(errorMsg: decodedResp['message']['mongolian']);
      } else {
        throw CustomException(errorMsg: "сервертэй холбогдоход алдаа гарлаа");
      }
    } on SocketException catch (ex) {
      // print(ex.message.toString());
      throw CustomException(errorMsg: ex.toString());
    } catch (ex) {
      // print(ex.toString());
      throw CustomException(errorMsg: ex.toString());
    }
  }

  Future<dynamic> deleteUrl({String? url, Map<String, dynamic>? body, bool? isPublic}) async {
    var dio = createDio();
    bool checkConnection = await NetWorkUtils().checkInternetConnection();
    if (!checkConnection) {
      throw CustomException(errorMsg: "Интернэт холболтоо шалгана уу");
    }
    try {
      // dio.options.headers['access_token'] = await getToken();
      Response response = await dio.delete(url!, data: body);
      return response.data;
    } on DioError catch (ex) {
      var decodedResp = ex.response!.data;
      if (decodedResp != null) {
        throw CustomException(errorMsg: decodedResp['message']['mongolian']);
      } else {
        throw CustomException(errorMsg: "сервертэй холбогдоход алдаа гарлаа");
      }
    } on SocketException catch (ex) {
      throw CustomException(errorMsg: ex.toString());
    } catch (ex) {
      throw CustomException(errorMsg: ex.toString());
    }
  }
}
