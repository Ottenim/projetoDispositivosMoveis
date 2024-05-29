import 'package:barber/firebase_options.dart';
import 'package:barber/repositories/user_repository.dart';
import 'package:barber/ui/pages/authentication/authentication_bloc.dart';
import 'package:barber/ui/pages/home_page.dart';
import 'package:barber/ui/pages/login/login.dart';
import 'package:barber/ui/pages/login/view/view.dart';
import 'package:barber/ui/pages/splash/view/splash_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

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
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            buildWhen: (previous, current) => previous.authenticationUser != current.authenticationUser,
            builder: (context, state) {
              switch (state.authenticationUser) {
                case AuthenticationUser.authenticated:
                  return HomePage();
                case AuthenticationUser.unauthenticated:
                  return LoginPage();
                case AuthenticationUser.none:
                  return SplashPage();
              }
            },
          ),
          onGenerateRoute: (settings) => SplashPage.route(),
        ),
      ),
    );
  }
}
