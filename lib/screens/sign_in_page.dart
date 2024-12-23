import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:logoispum/screens/sign_up_page.dart';
import '../widget/password_field.dart';
import 'forgot_password/confirm_email.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class SocialLoginButton extends StatelessWidget {
  final String assetPath;
  final String text;
  final VoidCallback onPressed;

  const SocialLoginButton({
    required this.assetPath,
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Color(0xFFEFF0F6),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Dio _dio = Dio();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _login(BuildContext context) async {
    final String url = 'https://api-dev-photruyen.deepviet.com/api/auth/login';
    try {
      final response = await _dio.post(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: {
          'user_name': _emailController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        // Xử lý khi đăng nhập thành công
        final data = response.data;
        print('Login successful: $data');
        // Chuyển đến màn hình tiếp theo nếu cần
      } else {
        // Xử lý khi đăng nhập thất bại
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
        print('Login failed: ${response.data}');
      }
    } catch (e) {
      // Xử lý lỗi khi gửi yêu cầu
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')),
      );
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 18,
              height: 18,
            ),
            const SizedBox(width: 8),
            Image.asset('assets/logoispum.png'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sign in to your\nAccount',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter your email and password to log in',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 40),
                const Text(
                  'User name',
                  style: TextStyle(color: Color(0xFF6C7278)),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Input your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text('Password:',
                    style: TextStyle(color: Color(0xFF6C7278))),
                const SizedBox(height: 5),
                PasswordField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  onToggleVisibility: _togglePasswordVisibility,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConfirmEmail()),
                      );
                    },
                    child: const Text('Forgot Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Color(0xFF4D81E7),
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: TextButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty ||
                          _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill all fields')),
                        );
                      } else {
                        _login(context); // Truyền context vào hàm đăng nhập
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF1D61E7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(color: Color(0xFFEFF0F6), thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Or',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Color(0xFFEFF0F6)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SocialLoginButton(
                  assetPath: 'assets/google.png',
                  text: 'Continue with Google',
                  onPressed: () {
                    print('Google button pressed');
                  },
                ),
                const SizedBox(height: 15),
                SocialLoginButton(
                  assetPath: 'assets/facebook.png',
                  text: 'Continue with Facebook',
                  onPressed: () {
                    print('Facebook button pressed');
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Color(0xFF6C7278),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Color(0xFF4D81E7),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
