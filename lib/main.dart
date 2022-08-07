import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/repositories/global_rep.dart';
import 'domain/services/router/delegate.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  late final GlobalRep globalRep;

  initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initFirebase();
    globalRep = GlobalRep(router: AppRouterDelegate());
    globalRep.router.push(Routes.startPage);
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => globalRep,
      child: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: MaterialApp.router(
          routerDelegate: globalRep.router,
          routeInformationParser: const AppRouteInformationParser(),
        ),
      ),
    );
  }
}
