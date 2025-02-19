import 'package:flutter/material.dart';
import '../services/authServices.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Inisiasi State
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isHidden = false;

  @override
  void dispose() {
    // Membersihkan controller ketika widget dihapus
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Sign-up Page", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFF2808A),
      ),
      body: Stack(
        children: <Widget>[
          // Background Image
          Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/images/bg1.jpg'),
            //     fit: BoxFit.fill,
            //   ),
            // ),
          ),
          // Centered Content
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   'assets/images/poto3.png',
                  //   width: 140,
                  //   height: 160,
                  //   fit: BoxFit.cover,
                  // ),
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFD95F76),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: const Color(0xFFFDD4D7).withOpacity(0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Sign-up",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: usernameController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: passwordController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(
                                  _isHidden ? Icons.visibility : Icons.visibility_off,
                                ),
                              ),
                            ),
                            obscureText: _isHidden,
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              authServices.simpanAkun(
                                  usernameController.text,
                                  passwordController.text
                              );
                            },
                            child: Text('Sign-up', style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 36),
                              backgroundColor: Color(0xFFD95F76),
                            ),
                          ),
                          Row(
                            children: [
                              Text("Sudah Punya Akun?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginPage())
                                  );
                                },
                                child: Text("Login"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
