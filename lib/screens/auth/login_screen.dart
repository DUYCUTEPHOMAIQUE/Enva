<<<<<<< HEAD
import 'package:enva/screens/home/home_screen.dart';
=======
import 'package:enva/screens/auth/widgets/loading_overlay.dart';
>>>>>>> 304d5556caa311af1ebf65a7abe14ba97e8bff3b
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

<<<<<<< HEAD
  String _errorMessage = "";

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Please fill in both fields.";
      });
      return;
    }

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        Fluttertoast.showToast(
            msg: "Login successfully ${response.user!.userMetadata!['name']}");
        setState(() {
          _errorMessage = response.session!.user!.email!;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        });
      } else {
        // Nếu đăng nhập thành công, chuyển đến màn hình chính hoặc trang người dùng
        setState(() {
          _errorMessage = "";
        });
        // Chuyển hướng hoặc lưu trạng thái đăng nhập
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred. Please try again.";
      });
    }
  }

=======
>>>>>>> 304d5556caa311af1ebf65a7abe14ba97e8bff3b
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              // Navigator.pushReplacementNamed(context, '/home');
            }
            if (state is AuthError) {
              Fluttertoast.showToast(msg: state.message);
              print('11111');
              print(state.message);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildTextField("Email", Icons.email, _emailController),
                      const SizedBox(height: 20),
                      _buildTextField(
                        "Password",
                        Icons.lock,
                        _passwordController,
                        isPassword: true,
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                    EmailSignInRequested(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    ),
                                  );
                            },
                            child: const Text("Sign In"),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(GoogleSignInRequested());
                            },
                            child: const Text("Sign In With Google"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (state is AuthLoading) const LoadingOverlay(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
