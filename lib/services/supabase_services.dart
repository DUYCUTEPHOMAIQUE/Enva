import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseServices {
  static final SupabaseClient client = SupabaseClient(
    dotenv.env['SUPABASE_URL']!,
    dotenv.env['ANON_KEY']!,
  );

  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  static Future<void> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn(
      clientId: dotenv.env['GOOGLE_CLIENT_ID']!,
    );
    final googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      throw 'Google Sign-In Error: accessToken or idToken is null';
    }
    await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    // print('123:: ${user.user}');
  }
}
