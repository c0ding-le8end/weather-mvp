import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_mvp/amplify_app/blocs/events.dart';
import 'package:weather_mvp/amplify_app/blocs/states.dart';

import '../../main.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthBloc() : super(Unknown()) {

    on<AuthenticationStatusChanged>((event, emit) async {

      try {
        emit(Unknown());

if(!isCon)
  {
    await Future.delayed(Duration(seconds: 2));
  }
        bool status=await event.status;
        switch (status) {
          case true:
            var attributes=await Amplify.Auth.fetchUserAttributes();
            print(attributes);
            emit(Authenticated(attributes));
            break;
          case false:
            emit(Unauthenticated());
            break;

        }
      } catch (e) {
        emit(AuthError());
      }
    });
  }
}
