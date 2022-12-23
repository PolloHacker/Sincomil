import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sincomil/Screens/login_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
          ],
          background: Container(color: whiteSecondary)),
      theme: ThemeData(),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
