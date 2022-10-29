import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:weather_mvp/main.dart';

class AuthRepository {
  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Amplify.Auth.signIn(username: username, password: password);
  }

  Future<void> googleSignIn() async{
    await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
  }

  Future<void> signUp({
    required String username,
    required String password,
  }) async {
    final userAttributes = <CognitoUserAttributeKey, String>{
      CognitoUserAttributeKey.email: username,
      // additional attributes as needed
    };
    await Amplify.Auth.signUp(
      username: username,
      password: password,
      options: CognitoSignUpOptions(userAttributes: userAttributes),
    );
  }

  Future<void> logOut() async {
    await Amplify.Auth.signOut();
  }
}
