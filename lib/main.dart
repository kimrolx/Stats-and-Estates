import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stats_and_estates/firebase_options.dart';
import 'package:stats_and_estates/src/providers/current_index_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stats_and_estates/src/services/authentication/auth_gate.dart';
import 'package:stats_and_estates/src/services/authentication/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CurrentIndexProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
