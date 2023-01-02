import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sincomil/Classes/nav_handler.dart';
import 'package:sincomil/Screens/home_page.dart';
import 'package:sincomil/Screens/start_page.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class FingerPage extends StatefulWidget {
  const FingerPage({super.key});

  @override
  State<StatefulWidget> createState() => _FingerPageState();
}

class _FingerPageState extends State<FingerPage> {
  int _currIndex = 0;

  final storage = const FlutterSecureStorage();
  dynamic grades;

  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<List<String>> _readFromStorage() async {
    var email = await storage.read(key: "KEY_USERNAME") ?? '';
    var pass = await storage.read(key: "KEY_PASSWORD") ?? '';
    return [email, pass];
  }

  @override
  void initState() {
    super.initState();
    _currIndex = 0;
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    FlutterNativeSplash.remove();
  }

  Future<void> error() async {
    setState(() {
      _currIndex = 2;
    });

    await Future.delayed(
        const Duration(seconds: 1), () => {setState(() => _currIndex = 0)});
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Coloque seu dedo no sensor digital',
        options: const AuthenticationOptions(
            stickyAuth: true, biometricOnly: true, useErrorDialogs: false),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderOnForeground: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          Image.asset("assets/images/sincomil-logo.png"),
          const Spacer(),
          IconButton(
            iconSize: 70,
            icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                transitionBuilder: (child, anim) => RotationTransition(
                      turns: child.key == const ValueKey('icon1')
                          ? Tween<double>(begin: 0.75, end: 1).animate(anim)
                          : Tween<double>(begin: 0.75, end: 1).animate(anim),
                      child: ScaleTransition(scale: anim, child: child),
                    ),
                child: _currIndex == 0
                    ? const Icon(Icons.fingerprint_rounded,
                        key: ValueKey('icon1'))
                    : _currIndex == 2
                        ? const Icon(Icons.error_outline_rounded,
                            key: ValueKey('icon3'))
                        : const Icon(Icons.check_circle_outline_rounded,
                            key: ValueKey('icon2'))),
            onPressed: () async {
              await _authenticateWithBiometrics();
              _authorized == 'Authorized'
                  ? setState(() async {
                      _currIndex = 1;
                      final dt = await _readFromStorage();
                      if (!mounted) return;
                      final read =
                          await const NavHandler().check(context, dt[0], dt[1]);
                      final parent = read[0];
                      final data = read[1];
                      final List<String> nomes = [];
                      final List<int> numeros = [];
                      for (var i = 0; i < data.length; i++) {
                        nomes.add(data[i].nome);
                      }
                      for (var i = 0; i < data.length; i++) {
                        numeros.add(data[i].numero);
                      }
                      if (!mounted) return;
                      final fotos = await const NavHandler()
                          .getPic(context, nomes, numeros);
                      if (!mounted) return;
                      grades = await const NavHandler().getGrades(context, nomes);
                      setState(() => _currIndex = 0);
                      await Future.delayed(const Duration(seconds: 1),
                          () => {});
                      if (!mounted) return;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StartPage(
                              parent: parent,
                              data: data,
                              fotos: fotos,
                              list: initList(data),
                              grades: grades,
                              value: data[0].nome)));
                    })
                  : await error();
            },
          ),
          const Text(
            'Toque o sensor de impressão digital',
            style: TextStyle(fontSize: 20),
          ),
          const Spacer(),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }
}
