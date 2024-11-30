import 'package:alarma/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screen/login_screen.dart';
import 'screen/registro_screen.dart';
import 'screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Firebase App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const InitialScreen(), // Pantalla inicial
        routes: {
          '/login': (context) =>  LoginScreen(),
          '/register': (context) =>  RegisterScreen(),
          '/home': (context) {
            final user = FirebaseAuth.instance.currentUser;
            if (user == null) {
              return  LoginScreen();
            } else {
              return HomeScreen(user: user);
            }
          },
        },
      ),
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return HomeScreen(user: snapshot.data!);
        } else {
          return  LoginScreen();
        }
      },
    );
  }
}
