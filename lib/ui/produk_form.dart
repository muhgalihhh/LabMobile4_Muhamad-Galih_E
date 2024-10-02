import 'package:flutter/material.dart';
import 'package:frontend_toko/model/produk.dart';

class ProdukForm extends StatefulWidget {
  Produk? produk;

  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = 'TAMBAH PRODUK';
  String tomboSubmit = 'SIMPAN';

  final _kodeProdukTextBoxController = TextEditingController();
  final _namaProdukTextBoxController = TextEditingController();
  final _hargaProdukTextBoxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = 'UBAH PRODUK';
        tomboSubmit = 'UBAH';
        _kodeProdukTextBoxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextBoxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextBoxController.text =
            widget.produk!.hargaProduk.toString();
      });
    } else {
      judul = 'TAMBAH PRODUK';
      tomboSubmit = 'SIMPAN';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                _namaProdukTextField(),
                _hargaProdukTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Kode Produk'),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextBoxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Kode Produk Harus Diisi';
        }
        return null;
      },
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Nama Produk'),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextBoxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Nama Produk Harus Diisi';
        }
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Harga Produk'),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextBoxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Harga Produk Harus Diisi';
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tomboSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
        });
  }
}
