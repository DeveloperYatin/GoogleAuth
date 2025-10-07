import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err) {
      debugPrint('Login error: $err');
    }
  }

  Future<void> _logout() async {
    await _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Auth Demo',
      home: Scaffold(
        body: Center(
          child: _isLoggedIn
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Image.network(
                        _googleSignIn.currentUser?.photoUrl ?? '',
                        height: 50.0,
                        width: 50.0,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 50.0,
                            width: 50.0,
                            color: Colors.grey[300],
                            child: const Icon(Icons.person),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(_googleSignIn.currentUser?.displayName ?? 'User'),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      child: const Text("Logout"),
                      onPressed: _logout,
                    ),
                  ],
                )
              : OutlinedButton(
                  child: const Text("Login with Google"),
                  onPressed: _login,
                ),
        ),
      ),
    );
  }
}
