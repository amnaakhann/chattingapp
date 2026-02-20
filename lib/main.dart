<<<<<<< HEAD
import 'models/services/auth/auth_gate.dart';
import 'firebase_options.dart';
import 'features/theme/theme_provider.dart';
=======
import 'package:chatting_app/homepage.dart';
import 'package:chatting_app/services/auth/auth_gate.dart';
import 'package:chatting_app/firebase_options.dart';
import 'package:chatting_app/login_page.dart';
import 'package:chatting_app/register_page.dart';
import 'package:chatting_app/theme/light_mode.dart';
import 'package:chatting_app/theme/theme_provider.dart';
>>>>>>> b916ab414ac3465d07de8c69e746c3098344149b
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

<<<<<<< HEAD
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

import 'app/homepage.dart';

=======
>>>>>>> b916ab414ac3465d07de8c69e746c3098344149b
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
<<<<<<< HEAD

  // Create auth data source and repository for provider
  final remote = FirebaseAuthRemoteDataSource(firebaseAuth: fb.FirebaseAuth.instance, googleSignIn: GoogleSignIn());
  final repo = AuthRepositoryImpl(remoteDataSource: remote);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => AuthProvider(repo)),
    ],
    child: const MyAppWrapper(),
  ));
}

class MyAppWrapper extends StatelessWidget {
  const MyAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: themeProvider.themedata,
      routes: {
        '/home': (context) => Homepage(),
      },
=======
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themedata,
>>>>>>> b916ab414ac3465d07de8c69e746c3098344149b
    );
  }
}
