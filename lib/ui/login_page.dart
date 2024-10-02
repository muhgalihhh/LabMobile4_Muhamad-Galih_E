import 'package:flutter/material.dart';
import 'package:frontend_toko/ui/registrasi_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;

  final _emailTextBoxController = TextEditingController();
  final _passwordTextBoxController = TextEditingController();
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color white
      appBar: AppBar(
        title: Text(
          "Login Galih",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.black, // Monochrome AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _emailTextField(),
                const SizedBox(height: 20),
                _passwordTextField(),
                const SizedBox(height: 30),
                _buttonLogin(),
                const SizedBox(height: 30),
                _menuRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat TextBox untuk email dengan animasi pada border
  Widget _emailTextField() {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isEmailFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isEmailFocused
                ? Colors.black
                : Colors.grey, // Animated border color
            width: _isEmailFocused ? 2 : 1, // Animated border width
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Masukkan email',
            border: InputBorder.none, // Remove default border
            labelStyle: GoogleFonts.poppins(color: Colors.black),
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
          ),
          keyboardType: TextInputType.emailAddress,
          controller: _emailTextBoxController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email tidak boleh kosong';
            }
            return null;
          },
        ),
      ),
    );
  }

  // Membuat TextBox untuk password dengan animasi pada border
  Widget _passwordTextField() {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isPasswordFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isPasswordFocused
                ? Colors.black
                : Colors.grey, // Animated border color
            width: _isPasswordFocused ? 2 : 1, // Animated border width
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Masukkan password',
            border: InputBorder.none, // Remove default border
            labelStyle: GoogleFonts.poppins(color: Colors.black),
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
          ),
          keyboardType: TextInputType.text,
          obscureText: true,
          controller: _passwordTextBoxController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password tidak boleh kosong';
            }
            return null;
          },
        ),
      ),
    );
  }

  // Membuat tombol login minimalis
  Widget _buttonLogin() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Black button
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Login',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        onPressed: () {
          var valid = _formKey.currentState!.validate();
        },
      ),
    );
  }

  // Membuat menu registrasi minimalis
  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: Text(
          'Registrasi',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegistrasiPage()));
        },
      ),
    );
  }
}
