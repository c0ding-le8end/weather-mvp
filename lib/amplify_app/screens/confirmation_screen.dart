import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../blocs/AuthBloc.dart';
import '../blocs/events.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key, required this.email, required this.password}) : super(key: key);
  final String email;
  final String password;

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  double verifyButtonOpacity = 0.5;
  late String otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 79,
              ),
              Text("Enter otp sent to your mail"),
              const SizedBox(
                height: 79,
              ),
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                fieldStyle: FieldStyle.box,
                otpFieldStyle: OtpFieldStyle(
                  backgroundColor: Color(0xFFF3F6FF),
                ),
                onCompleted: (value) async {
                  otp = value;
                  print("here");
                },
                onChanged: (value) {
                  if (value.length == 6) {
                    setState(() {
                      verifyButtonOpacity = 1;
                    });
                  } else {
                    setState(() {
                      verifyButtonOpacity = 0.5;
                    });
                  }
                  //added this to avoid null value error
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 21.57, left: 40, right: 40),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 51,
                  decoration: BoxDecoration(
                    color: Color(0xFF407BFF).withOpacity(verifyButtonOpacity),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(9.80519),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {

                      if (verifyButtonOpacity == 1) {
                        SignUpResult result = await Amplify.Auth.confirmSignUp(
                            username: widget.email, confirmationCode: otp);
                        if (result.isSignUpComplete) {

                          bool check=await Amplify.Auth.fetchAuthSession().then((value) => value.isSignedIn);
                          if(!check)
                          {
                            await Amplify.Auth.signIn(username: widget.email,password: widget.password);
                            BlocProvider.of<AuthBloc>(context)
                                .add(AuthenticationStatusChanged());
                          }
                          else
                          {
                            BlocProvider.of<AuthBloc>(context)
                                .add(AuthenticationStatusChanged());
                          }
                          if(!mounted)
                          {

                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } else {
                          print("invalid code");
                        }
                      }
                    },
                    child: Center(
                      child: Text(
                        "Verify",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 23, left: 40, right: 40),
              //   child: FittedBox(
              //     child: Text.rich(TextSpan(
              //         text: "You didn’t receive a code? ",
              //         style: TextStyle(
              //             fontWeight: FontWeight.w600,
              //             fontSize: 16,
              //             color: Color(0XFF656565)),
              //         children: [
              //           TextSpan(
              //             text:
              //             "RESEND OTP in 00:${formatter.format(secondsRemaining)}",
              //             style: GoogleFonts.lato(
              //                 fontWeight: FontWeight.w800,
              //                 fontSize: 14,
              //                 color: ColorResources.PRIMARY),
              //           )
              //         ])),
              //   ),
              // ),
            ],
          )),
    );
  }
}