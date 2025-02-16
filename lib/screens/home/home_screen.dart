import 'package:enva/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:enva/services/services.dart';

import 'package:enva/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  final SupabaseClient client = Supabase.instance.client;
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(clientId: dotenv.env['GOOGLE_CLIENT_ID']!);
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

  Future<void> _shareLink() async {
    Share.share('This is facebook https://www.facebook.com/');
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

  Future<void> _addData() async {
    final user = client.auth.currentUser;
    Fluttertoast.showToast(msg: "User: ${user}");
    final response = await client.from('cards').insert({
      'owner_id': user!.id,
      'title': "Card_3",
      'description': "Description_1",
      'image_url': 'img_url',
      'location': 'Ha Noi',
      'created_at': DateTime.now().toIso8601String(),
      'background_image_url': user.userMetadata!['avatar_url'] ?? '',
    });

    print(response);

    print('OKKK');
    return response.data;
  }

  Future<void> _getData() async {
    final user = client.auth.currentUser;
    final response = await client.from('cards').select().eq('id', user!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (Supabase.instance.client.auth.currentUser != null)
              Column(
                children: [
                  Text(
                      "User: ${Supabase.instance.client.auth.currentUser!.email}"),
                  ElevatedButton(
                    onPressed: () async {
                      await Supabase.instance.client.auth.signOut();
                      Fluttertoast.showToast(msg: "Sign out successfully");
                    },
                    child: Text("Sign out"),
                  ),
                ],
              ),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text("Go to Sign Up"),
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _shareLink,
              child: Text("Share link"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addData,
              child: Text("+ Data"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getData,
              child: Text("Get Data"),
            ),
          ],
        ),
      ),
    );
  }
}
