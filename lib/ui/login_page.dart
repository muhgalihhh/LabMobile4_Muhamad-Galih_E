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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                _emailTextField(),
                _passwordTextField(),
                _buttonLogin(),
                const SizedBox(height: 30),
                _menuRegistrasi(),
              ]),
            ),
          ),
        ));
  }

  // Membuat TextBox untuk email
  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Masukkan email',
        labelStyle: GoogleFonts.poppins(),
        hintStyle: GoogleFonts.poppins(),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextBoxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        return null;
      },
    );
  }

  // Membuat TextBox untuk password
  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Masukkan password',
        labelStyle: GoogleFonts.poppins(),
        hintStyle: GoogleFonts.poppins(),
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
    );
  }

  // Membuat tombol login
  Widget _buttonLogin() {
    return ElevatedButton(
      child: Text(
        'Login',
        style: GoogleFonts.poppins(),
      ),
      onPressed: () {
        var valid = _formKey.currentState!.validate();
      },
    );
  }

  // Membuat menu registrasi
  // Membuat menu registrasi
  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: Text(
          'Registrasi',
          style: GoogleFonts.poppins(color: Colors.blue),
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegistrasiPage()));
        },
      ),
    );
  }
}
