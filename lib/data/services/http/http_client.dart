import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:quiz_app/data/model/server_response.dart';

abstract class HTTPClient {
  static String path({
    required String command,
    required String params,
    required Map<String, String>? args,
    required Uri url,
  }) {
    return url
        .replace(
          path: ((command != '') ? command : '') + ((params != '') ? '/$params' : ''),
          queryParameters: args,
        )
        .toString();
  }

  static Future<ServerResponse> httpGet({
    required Uri serverUrl,
    required String command,
    required String params,
    required Map<String, String>? args,
    required Dio? client,
  }) async {
    ServerResponse? res;
    try {
      final response = await client?.get(
        path(command: command, params: params, args: args, url: serverUrl)
      );
      res = await responseEngine(resTxt: response);
    } on DioError catch (e) {
      res = ServerResponse(
        err: e.toString(),
        body: e.response!.data,
        msgText: '',
        code: e.response?.statusCode.toString() ?? '',
      );
    } catch (e) {
      res = ServerResponse(err: e.toString(), msgText: '');
    }

    return res;
  }

  static Future<ServerResponse> responseEngine({
    Response? resTxt,
  }) async {
    ServerResponse res = ServerResponse(err: 'Server not response', msgText: '');
    try {
      if (resTxt != null) {
        if (resTxt.statusCode == 200) {
          res = ServerResponse(
            code: '200',
            msgText: jsonEncode(resTxt.data),
            body: resTxt.data,
          );
        } else {
          res = ServerResponse(
            err: resTxt.requestOptions.data,
            code: resTxt.statusCode.toString(),
            msgText: resTxt.data.toString(),
          );
        }
      }
    } catch (e) {
      res = ServerResponse(err: e.toString(), msgText: '');
    }

    return res;
  }
}
