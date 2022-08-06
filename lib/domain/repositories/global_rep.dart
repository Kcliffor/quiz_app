import 'package:quiz_app/data/services/net_exchange.dart';
import 'package:quiz_app/domain/services/router/delegate.dart';

class GlobalRep {
  late NetExchange netExchange;
  late AppRouterDelegate router;

  static late GlobalRep rep;

  GlobalRep._(this.router);

  factory GlobalRep({
    required AppRouterDelegate router,
  }) {
    rep = GlobalRep._(router);

    return rep;
  }

  init() {
    netExchange = NetExchange(
      serverUrl: Uri.parse('https://quizapi.io'),
    );
  }
}
