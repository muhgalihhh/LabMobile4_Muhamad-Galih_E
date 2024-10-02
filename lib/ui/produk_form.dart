import 'package:flutter/material.dart';
import 'package:frontend_toko/model/produk.dart';
import 'package:google_fonts/google_fonts.dart';

class ProdukForm extends StatefulWidget {
  Produk? produk;

  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = 'TAMBAH PRODUK Muhamad Galih';
  String tomboSubmit = 'SIMPAN';

  final _kodeProdukTextBoxController = TextEditingController();
  final _namaProdukTextBoxController = TextEditingController();
  final _hargaProdukTextBoxController = TextEditingController();

  bool _isKodeFocused = false;
  bool _isNamaFocused = false;
  bool _isHargaFocused = false;

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = 'UBAH PRODUK Galih';
        tomboSubmit = 'UBAH';
        _kodeProdukTextBoxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextBoxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextBoxController.text =
            widget.produk!.hargaProduk.toString();
      });
    } else {
      judul = 'TAMBAH PRODUK Galih';
      tomboSubmit = 'SIMPAN';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          judul,
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
              children: [
                _kodeProdukTextField(),
                const SizedBox(height: 20),
                _namaProdukTextField(),
                const SizedBox(height: 20),
                _hargaProdukTextField(),
                const SizedBox(height: 30),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Kode Produk TextField with animated border
  Widget _kodeProdukTextField() {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isKodeFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isKodeFocused ? Colors.black : Colors.grey,
            width: _isKodeFocused ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Kode Produk',
            hintText: 'Masukkan kode produk',
            border: InputBorder.none,
            labelStyle: GoogleFonts.poppins(color: Colors.black),
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
          ),
          keyboardType: TextInputType.text,
          controller: _kodeProdukTextBoxController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Kode Produk Harus Diisi';
            }
            return null;
          },
        ),
      ),
    );
  }

  // Nama Produk TextField with animated border
  Widget _namaProdukTextField() {
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
            labelText: 'Nama Produk',
            hintText: 'Masukkan nama produk',
            border: InputBorder.none,
            labelStyle: GoogleFonts.poppins(color: Colors.black),
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
          ),
          keyboardType: TextInputType.text,
          controller: _namaProdukTextBoxController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Nama Produk Harus Diisi';
            }
            return null;
          },
        ),
      ),
    );
  }

  // Harga Produk TextField with animated border
  Widget _hargaProdukTextField() {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isHargaFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isHargaFocused ? Colors.black : Colors.grey,
            width: _isHargaFocused ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Harga Produk',
            hintText: 'Masukkan harga produk',
            border: InputBorder.none,
            labelStyle: GoogleFonts.poppins(color: Colors.black),
            hintStyle: GoogleFonts.poppins(color: Colors.grey),
          ),
          keyboardType: TextInputType.number,
          controller: _hargaProdukTextBoxController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Harga Produk Harus Diisi';
            }
            return null;
          },
        ),
      ),
    );
  }

  // Button for form submission
  Widget _buttonSubmit() {
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
        onPressed: () {
          var validate = _formKey.currentState!.validate();
        },
        child: Text(
          tomboSubmit,
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    );
  }
}
