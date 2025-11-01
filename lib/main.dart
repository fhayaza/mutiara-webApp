import 'package:core/core.dart';
import 'package:flutter/material.dart';

// Tambahan Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './src/routes/routes.dart';

void main() async {
  // Wajib untuk async
  WidgetsFlutterBinding.ensureInitialized();

  // Init Firebase dengan file konfigurasi hasil flutterfire configure
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  setupLocatorCore();
  locator.registerSingleton<GoRouter>(router);
  await locator.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Starter Kit',
      supportedLocales: L.supportedLocales,
      locale: const Locale("id"),
      localizationsDelegates: const [
        L.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: MainColor.primary),
        primarySwatch: MainColor.primary,
        primaryColor: MainColor.primary,
        textTheme: GoogleFonts.robotoTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: MainColor.primary,
          surfaceTint: Colors.transparent,
        ),
        useMaterial3: true,
      ),
    );
  }
}
