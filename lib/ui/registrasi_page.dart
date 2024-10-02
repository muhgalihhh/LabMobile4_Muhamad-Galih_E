import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _namaTextBoxController = TextEditingController();
  final _emailTextBoxController = TextEditingController();
  final _passwordTextBoxController = TextEditingController();
  final _confirmPasswordTextBoxController = TextEditingController();

  bool _isNamaFocused = false;
  bool _isEmailFocused = false;
  bool _isPasswordFocused = false;
  bool _isConfirmPasswordFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Registrasi Galih",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _namaTextField(),
                const SizedBox(height: 20),
                _emailTextField(),
                const SizedBox(height: 20),
                _passwordTextField(),
                const SizedBox(height: 20),
                _passwordKonfirmasiTextField(),
                const SizedBox(height: 30),
                _buttonRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat TextBox untuk nama dengan animasi pada border
  Widget _namaTextField() {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isNamaFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isNamaFocused ? Colors.black : Colors.grey,
            width: _isNamaFocused ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Nama',
            hintText: 'Masukkan nama',
            border: InputBorder.none,
            labelStyle: GoogleFonts.poppins(color: Colors.black),
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
          ),
          controller: _namaTextBoxController,
          validator: (value) {
            if (value!.length < 3) {
              return 'Nama minimal 3 karakter';
            }
            return null;
          },
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
            color: _isEmailFocused ? Colors.black : Colors.grey,
            width: _isEmailFocused ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Masukkan email',
            border: InputBorder.none,
            labelStyle: GoogleFonts.poppins(color: Colors.black),
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
          ),
          keyboardType: TextInputType.emailAddress,
          controller: _emailTextBoxController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Email tidak boleh kosong';
            }
            Pattern pattern =
                r'^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$';
            RegExp regex = RegExp(pattern.toString());
            if (!regex.hasMatch(value)) {
              return 'Email tidak valid';
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
            color: _isPasswordFocused ? Colors.black : Colors.grey,
            width: _isPasswordFocused ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Masukkan password',
            border: InputBorder.none,
            labelStyle: GoogleFonts.poppins(color: Colors.black),
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
          ),
          obscureText: true,
          controller: _passwordTextBoxController,
          validator: (value) {
            if (value!.length < 6) {
              return 'Password minimal 6 karakter';
            }
            return null;
          },
        ),
      ),
    );
  }

  // Membuat TextBox untuk konfirmasi password dengan animasi pada border
  Widget _passwordKonfirmasiTextField() {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isConfirmPasswordFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isConfirmPasswordFocused ? Colors.black : Colors.grey,
            width: _isConfirmPasswordFocused ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Konfirmasi Password',
            hintText: 'Masukkan konfirmasi password',
            border: InputBorder.none,
            labelStyle: GoogleFonts.poppins(color: Colors.black),
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
          ),
          obscureText: true,
          controller: _confirmPasswordTextBoxController,
          validator: (value) {
            if (value != _passwordTextBoxController.text) {
              return 'Password tidak sama';
            }
            return null;
          },
        ),
      ),
    );
  }

  // Membuat Button Registrasi minimalis
  Widget _buttonRegistrasi() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Registrasi',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        onPressed: () {
          var valid = _formKey.currentState!.validate();
        },
      ),
    );
  }
}
