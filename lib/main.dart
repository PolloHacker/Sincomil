import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sincomil/Provider/app_settings.dart';
import 'package:sincomil/Screens/finger_page.dart';
import 'package:sincomil/Screens/login_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'Constants/constants.dart';
import 'Screens/welcome_page.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final isDark = sharedPreferences.getBool('is_dark') ?? false;
  final useFinger = sharedPreferences.getBool('use_finger') ?? false;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(isDark: isDark, useFinger: useFinger));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final bool useFinger;
  final storage = const FlutterSecureStorage();
  const MyApp({super.key, required this.isDark, required this.useFinger});

  Future<List<String>> _readFromStorage() async {
    var email = await storage.read(key: "KEY_USERNAME") ?? '';
    var pass = await storage.read(key: "KEY_PASSWORD") ?? '';
    return [email, pass];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _readFromStorage(),
        builder: (context, AsyncSnapshot<List<String>> data) {
          if (data.hasData) {
            if (data.data?[0] != '' && data.data?[1] != '') {
              return ChangeNotifierProvider(
                  create: (context) => AppSettings(isDark, useFinger),
                  builder: (context, snapshot) {
                    final appSettings = Provider.of<AppSettings>(context);
                    if (appSettings.fingerprint == "true") {
                      return MaterialApp(
                        builder: (context, child) => ResponsiveWrapper.builder(
                            ClampingScrollWrapper.builder(context, child!),
                            maxWidth: 1200,
                            minWidth: 480,
                            defaultScale: true,
                            breakpoints: [
                              const ResponsiveBreakpoint.resize(480,
                                  name: MOBILE),
                              const ResponsiveBreakpoint.autoScale(800,
                                  name: TABLET),
                              const ResponsiveBreakpoint.resize(1000,
                                  name: DESKTOP),
                              const ResponsiveBreakpoint.autoScale(2460,
                                  name: '4K'),
                            ]),
                        theme: appSettings.currentTheme,
                        home: const FingerPage(),
                        debugShowCheckedModeBanner: false,
                      );
                    } else {
                      return MaterialApp(
                        builder: (context, child) => ResponsiveWrapper.builder(
                            ClampingScrollWrapper.builder(context, child!),
                            maxWidth: 1200,
                            minWidth: 480,
                            defaultScale: true,
                            breakpoints: [
                              const ResponsiveBreakpoint.resize(480,
                                  name: MOBILE),
                              const ResponsiveBreakpoint.autoScale(800,
                                  name: TABLET),
                              const ResponsiveBreakpoint.resize(1000,
                                  name: DESKTOP),
                              const ResponsiveBreakpoint.autoScale(2460,
                                  name: '4K'),
                            ],
                            background: Container(color: whiteSecondary)),
                        theme: appSettings.currentTheme,
                        home: const WelcomePage(),
                        debugShowCheckedModeBanner: false,
                      );
                    }
                  });
            } else {
              return ChangeNotifierProvider(
                  create: (context) => AppSettings(isDark, false),
                  builder: (context, snapshot) {
                    final settings = Provider.of<AppSettings>(context);
                    return MaterialApp(
                      builder: (context, child) => ResponsiveWrapper.builder(
                          ClampingScrollWrapper.builder(context, child!),
                          maxWidth: 1200,
                          minWidth: 480,
                          defaultScale: true,
                          breakpoints: [
                            const ResponsiveBreakpoint.resize(480,
                                name: MOBILE),
                            const ResponsiveBreakpoint.autoScale(800,
                                name: TABLET),
                            const ResponsiveBreakpoint.resize(1000,
                                name: DESKTOP),
                            const ResponsiveBreakpoint.autoScale(2460,
                                name: '4K'),
                          ],
                          background: Container(color: whiteSecondary)),
                      theme: settings.currentTheme,
                      home: const LoginPage(),
                      debugShowCheckedModeBanner: false,
                    );
                  });
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
