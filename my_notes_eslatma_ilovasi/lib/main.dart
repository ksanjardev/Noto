import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:my_notes_eslatma_ilovasi/data/local/local_storage.dart';
import 'package:my_notes_eslatma_ilovasi/di/di.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/res/custom_theme.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/screen/auth/login/login_screen.dart';
import 'package:my_notes_eslatma_ilovasi/presentation/screen/home/home_screen.dart';
import 'data/remote/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: customTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        quill.FlutterQuillLocalizations.delegate,
      ],
      // 3. Define which locales you support
      supportedLocales: const [
        Locale('en'),
      ],
      home: FutureBuilder(
          future: getFirstEnter(),
          builder: (context, snapshot){
            return snapshot.data ?? false ? HomeScreen() : LoginScreen();
          }),
    );
  }
}
