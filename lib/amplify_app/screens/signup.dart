import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../blocs/AuthBloc.dart';
import '../blocs/events.dart';
import '../data/AuthRepo.dart';
import 'confirmation_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                    'Sign up',
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
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Signup'),
                    onPressed: () async {
                      try
                      {

                        AuthRepository repository=AuthRepository();
                        await repository.signUp(username: nameController.text, password: passwordController.text);
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>BlocProvider<AuthBloc>.value(value:BlocProvider.of<AuthBloc>(context),child: ConfirmationScreen(email: nameController.text,password: passwordController.text,))));
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
                  const Text('Already have an account?'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }
}