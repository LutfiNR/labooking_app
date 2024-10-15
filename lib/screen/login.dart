import 'package:flutter/material.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau Password tidak boleh kosong'),
        ),
      );
    } else {
      if (username == 'admin' && password == '1234') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username atau Password salah'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SingleChildScrollView(
        // Scroll to avoid overflow on smaller screens
        padding: const EdgeInsets.all(48.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 80), // Top padding for better centering
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'La',
                      style: TextStyle(
                        fontSize: 24, // Increased for better visibility
                        fontWeight: FontWeight.bold,
                        color: colorScheme.secondary,
                      ),
                    ),
                    TextSpan(
                      text: 'Booking',
                      style: TextStyle(
                        fontSize: 24, // Consistent font size
                        fontWeight: FontWeight.bold,
                        color: colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Selamat Datang!!',
                style: TextStyle(
                    fontSize:
                        64, // Reduced for better layout on smaller screens
                    fontWeight: FontWeight.w900,
                    height: 1.15),
              ),
              const SizedBox(height: 64),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Username',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.15),
                  ),
                  const SizedBox(
                      height: 4), // Space between label and TextField
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'NPM',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    cursorColor: colorScheme.secondary,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ), // Text size in TextField
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.15),
                  ),
                  const SizedBox(
                      height: 8), // Space between label and TextField
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    cursorColor: colorScheme.secondary,
                    obscureText: true, // Hide password input
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ), // Text size in TextField
                  ),
                ],
              ),
              const SizedBox(height: 48), // Space between fields and buttons
              Center(
                child: Column(
                  children: [
                    Container(
                      width: double
                          .infinity, // Make the button take full width of the container
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.secondary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.zero, // Set border radius to 0
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18, color: colorScheme.tertiary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}