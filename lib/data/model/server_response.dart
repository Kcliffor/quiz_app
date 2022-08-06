class ServerResponse {
  String code = '';
  String msgText;
  Object? err;
  Object? body;

  ServerResponse({
    required this.msgText,
    this.code = '',
    this.err = '',
    this.body,
  });
}
