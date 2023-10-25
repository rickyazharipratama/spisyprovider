import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:spisyprovider/factory/Utils/spisy_router.dart';
import 'package:spisyprovider/factory/implementor/providers/user_provider_impl.dart';
import 'package:spisyprovider/factory/provider/user_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProviderImpl(),
      child: MaterialApp.router(
        routerConfig: currentRouter,
        title: "spisy10 Provier",
        debugShowCheckedModeBanner: false,
      // child: const MaterialApp(
      //   home: Splash(),
      ),
    );
  }
}