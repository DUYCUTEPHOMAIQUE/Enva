import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:enva/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
          "135461409715-8p8s2lgp86ufunhllf0dkud5abad81qt.apps.googleusercontent.com");
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  // Hàm đăng nhập bằng Google
  Future<void> _signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;
      print('token ${googleAuth.idToken}');
      print('access ${googleAuth.accessToken}');

      if (accessToken == null || idToken == null) {
        throw 'Google Sign-In Error: accessToken or idToken is null';
      }

      await Supabase.instance.client.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken);
      Fluttertoast.showToast(msg: "GG OK");
    } catch (e) {
      print("Google Sign-In Error: $e");
    }
  }

  // Hàm đăng nhập bằng Facebook
  Future<void> _signInWithFacebook() async {
    try {
      final LoginResult result = await _facebookAuth.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;

        // final AuthResponse response =
        //     await Supabase.instance.client.auth.signInWithOAuth(
        //   Provider.google,
        //   accessToken: googleAuth.accessToken,
        // );

        // if (response != null) {
        //   print("Error: ${response.user!}");
        // } else {
        //   // Đăng nhập thành công
        //   print("Logged in with Facebook");
        // }
      } else {
        print("Facebook login failed: ${result.status}");
      }
    } catch (e) {
      print("Facebook Sign-In Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text("Go to Login"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: Text("Login with Google"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _signInWithFacebook,
              child: Text("Login with Facebook"),
            ),
          ],
        ),
      ),
    );
  }
}
