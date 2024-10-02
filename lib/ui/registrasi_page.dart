import 'package:flutter/material.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({super.key});

  @override
  State<RegistrasiPage> createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;

  final _namaTextBoxController = TextEditingController();
  final _emailTextBoxController = TextEditingController();
  final _passwordTextBoxController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registrasi"),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _namaTextField(),
                        _emailTextField(),
                        _passwordTextField(),
                        _passwordKonfirmasiTextField(),
                        _buttonRegistrasi(),
                      ],
                    )))));
  }

// Membuat TextBox untuk nama
  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Nama',
        hintText: 'Masukkan nama',
      ),
      keyboardType: TextInputType.text,
      controller: _namaTextBoxController,
      validator: (value) {
        if (value!.length < 3) {
          return 'Nama minimal 3 karakter';
        }
        return null;
      },
    );
  }

// Membuat TextBox untuk email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Masukkan email',
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextBoxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        // Validasi Email
        Pattern patern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0 -9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-  Z]{2,}))$';
        RegExp regex = RegExp(patern.toString());
        if (!regex.hasMatch(value)) {
          return 'Email tidak valid';
        }
        return null;
      },
    );
  }

// Membuat TextBox untuk password

  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Password',
        hintText: 'Masukkan password',
      ),
      keyboardType: TextInputType.text,
      controller: _passwordTextBoxController,
      validator: (value) {
        if (value!.length < 6) {
          return 'Password minimal 6 karakter';
        }
        return null;
      },
    );
  }

// Membuat TextBox untuk konfirmasi password
  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Konfirmasi Password',
        hintText: 'Masukkan konfirmasi password',
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value != _passwordTextBoxController.text) {
          return 'Password tidak sama';
        }
        return null;
      },
    );
  }

// Membuat Button Registrasi
  Widget _buttonRegistrasi() {
    return ElevatedButton(
      onPressed: () {
        var validate = _formKey.currentState!.validate();
      },
      child: const Text('Registrasi'),
    );
  }
}
