import 'package:autivision/screens/forgotPassword_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/main_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/onBoarding_screen.dart';
import 'screens/example_screen.dart';
import 'screens/history_screen.dart';
import 'screens/profile_screen.dart';
import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Add other providers if necessary
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutiVision',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        '/login': (context) => LoginScreen(),
        '/main': (context) => MainScreen(),
        '/signup': (context) => SignupScreen(),
        '/onBoarding': (context) => OnBoardingScreen(),
        '/example': (context) => ExampleScreen(),
        '/history': (context) => HistoryScreen(),
        '/profile': (context) => ProfileScreen(),
        '/forgotPassword': (context) => ForgotPasswordScreen(),
      },
    );
  }
}