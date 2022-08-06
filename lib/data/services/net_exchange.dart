import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/server_response.dart';
import 'http/http_client.dart';

class NetExchange {
  static NetExchange? rep;
  final Dio dio;

  NetExchange.init({
    required this.dio,
    required this.serverUrlRep,
  });

  factory NetExchange({
    required Uri serverUrl,
  }) {
    rep ??= NetExchange.init(
      dio: Dio(),
      serverUrlRep: serverUrl,
    );

    rep?.dio.interceptors.addAll([
      PrettyDioLogger(
        requestBody: true,
        compact: false,
        requestHeader: false,
        request: true,
        error: true,
        responseBody: true,
        responseHeader: false,
      ),
      InterceptorsWrapper(
        onResponse: (response, handler) {
          return handler.next(response);
        },
      )
    ]);

    return rep!;
  }

  late StreamController streamController;
  Uri serverUrlRep;

  Future<ServerResponse> netGet({
    required String command,
    String params = '',
    Uri? serverUrl,
    String? token,
    Map<String, String>? args,
  }) async {
    ServerResponse res = (rep?.serverUrlRep != null)
        ? await HTTPClient.httpGet(
            serverUrl: serverUrl ?? rep?.serverUrlRep ?? Uri(),
            command: command,
            params: params,
            args: args,
            client: rep?.dio,
          )
        : ServerResponse(msgText: 'server url not specified', code: '404');

    return res;
  }
}
