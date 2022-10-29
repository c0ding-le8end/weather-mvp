
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:weather_mvp/amplify_app/blocs/events.dart';
import 'package:weather_mvp/amplify_app/blocs/states.dart';
import 'package:weather_mvp/amplify_app/data/AuthRepo.dart';
import 'package:weather_mvp/blocs/weather_bloc.dart';

import 'amplify_app/blocs/AuthBloc.dart';
import 'amplify_app/screens/home_screen.dart';
import 'amplify_app/screens/signin.dart';
import 'amplifyconfiguration.dart';

void main() {
  runApp(BlocProvider(create: (context)=>AuthBloc(),child:MyApp()));
}

bool isCon = false;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyConfig2);

      isCon = true;
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Root(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {



@override
  void didChangeDependencies() {

  BlocProvider.of<AuthBloc>(context)
      .add(AuthenticationStatusChanged());
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is Unauthenticated) {
        return BlocProvider<AuthBloc>.value(value:BlocProvider.of<AuthBloc>(context),child:  SignIn());
      }
      else if (state is Authenticated) {
        return BlocProvider<AuthBloc>.value(value:BlocProvider.of<AuthBloc>(context),child:  HomeScreen());
      } else if (state is Unknown) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return const SignIn();
      }
    });
  }

  Future<bool> isUserSignedIn() async {
    late final result;
    try {
      await Future.delayed(Duration(seconds: 2), () async {
        result = await Amplify.Auth.fetchAuthSession();
      });
    } catch (e) {
      print(e);
      result = false;
    }

    print(" is here");
    return result.isSignedIn;
  }
}







