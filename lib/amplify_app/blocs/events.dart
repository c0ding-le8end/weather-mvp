import 'package:amplify_flutter/amplify_flutter.dart';

import '../../main.dart';

abstract class AuthenticationEvent
{}

class AuthenticationStatusChanged extends AuthenticationEvent
{
 Future<bool> get status async
 {

   var data=await Amplify.Auth.fetchAuthSession();

   return data.isSignedIn;
 }
}