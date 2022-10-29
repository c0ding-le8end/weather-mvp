import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/AuthBloc.dart';
import '../blocs/events.dart';
import '../blocs/states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String email = "";

  @override
  void initState() {
    for(AuthUserAttribute element in BlocProvider.of<AuthBloc>(context).state.attributes)
      {

        if(element.userAttributeKey.key=="email")
          {
            email=element.value;
            print("hello");
            break;
          }
      }
    super.initState();
  }

  getData() async {
    var data = await Amplify.Auth.fetchUserAttributes();

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () async {
                await Amplify.Auth.signOut();

                BlocProvider.of<AuthBloc>(context)
                    .add(AuthenticationStatusChanged());
              },
              child: Text(
                  "hello \n$email\n Click on this text to sign out",textAlign: TextAlign.center,),)),
    );
  }
}
