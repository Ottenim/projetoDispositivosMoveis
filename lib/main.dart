import 'package:barber/firebase_options.dart';
import 'package:barber/repositories/user_repository.dart';
import 'package:barber/ui/pages/authentication/authentication_bloc.dart';
import 'package:barber/ui/pages/home/view/home_page.dart';
import 'package:barber/ui/pages/login/login.dart';
import 'package:barber/ui/pages/login/view/view.dart';
import 'package:barber/ui/pages/splash/splash.dart';
import 'package:barber/ui/pages/splash/view/splash_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepository>(
      create: (context) => UserRepository(),
      child: BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(context.read<UserRepository>())..add(AuthenticationInitialValidation()),
        child: MaterialApp(
          navigatorKey: globalKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
            useMaterial3: true,
          ),
          home: const MainPage(),
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) => previous.authenticationUser != current.authenticationUser,
      listener: (context, state) {
        switch (state.authenticationUser ?? AuthenticationUser.none) {
          case AuthenticationUser.authenticated:
            globalKey.currentState?.pushReplacement(HomePage.route());
          case AuthenticationUser.none:
          case AuthenticationUser.unauthenticated:
            globalKey.currentState?.pushReplacement(LoginPage.route());
        }
      },
      child: SplashPage(),
    );
  }
}
