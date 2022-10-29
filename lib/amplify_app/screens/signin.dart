import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:weather_mvp/amplify_app/screens/signup.dart';

import '../blocs/AuthBloc.dart';
import '../blocs/events.dart';
import '../data/AuthRepo.dart';
import 'home_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  'Forgot Password',
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async {
                      try
                      {
                        AuthRepository repository=AuthRepository();
                        await repository.logIn(username: nameController.text, password: passwordController.text);
                        BlocProvider.of<AuthBloc>(context)
                            .add(AuthenticationStatusChanged());
                      }
                      on InvalidParameterException
                      catch(e)
                      {
                        print(e);
                        showDialog(context: context, builder: (context)
                        {
                          return AlertDialog(title: Text("error"),content: Text(e.message),actions: [TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("OK"))],);
                        });
                      }
                      catch(e)
                      {
                        showDialog(context: context, builder: (context)
                        {
                          return AlertDialog(title: Text("error"),content: Text("An error occured.Please try again"),actions: [TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("OK"))],);
                        });
                      }
                    },
                  )),
              Row(
                children: <Widget>[
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BlocProvider<AuthBloc>.value(value: BlocProvider.of<AuthBloc>(context),child: SignUp(),)));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SignInButton(
                  Buttons.GoogleDark,
                  onPressed: () async{
                    AuthRepository repository=AuthRepository();
                    await repository.googleSignIn();
                    BlocProvider.of<AuthBloc>(context)
                        .add(AuthenticationStatusChanged());
                  },
                ),
              ),
            ],
          )),
    );
  }
}