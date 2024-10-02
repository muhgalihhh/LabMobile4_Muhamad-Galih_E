import 'package:flutter/material.dart';
import 'package:frontend_toko/model/produk.dart';
import 'package:frontend_toko/ui/produk_form.dart';
import 'package:google_fonts/google_fonts.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;

  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  State<ProdukDetail> createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih
      appBar: AppBar(
        title: const Text('Detail Produk Galih'),
        backgroundColor: Colors.black, // AppBar hitam
        foregroundColor: Colors.white, // Text putih
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoProduk('Kode Produk', widget.produk!.kodeProduk!),
              const SizedBox(height: 10),
              _infoProduk('Nama Produk', widget.produk!.namaProduk!),
              const SizedBox(height: 10),
              _infoProduk(
                  'Harga Produk', widget.produk!.hargaProduk.toString()),
              const SizedBox(height: 30),
              _tombolHapusEdit(),
            ],
          ),
        ),
      ),
    );
  }

  // Menampilkan informasi produk dengan format minimalis
  Widget _infoProduk(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }

  // Membuat tombol Edit dan Delete dengan gaya minimalis
  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Tombol Edit
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.black), // Border hitam
          ),
          child: Text(
            "EDIT",
            style: GoogleFonts.poppins(color: Colors.black),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProdukForm(
                        produk: widget.produk!,
                      )),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.black), // Border hitam
          ),
          child: Text(
            "DELETE",
            style: GoogleFonts.poppins(color: Colors.black),
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  // Dialog konfirmasi hapus
  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.white, // Background putih
      content: Text(
        "Yakin ingin menghapus data ini?",
        style: GoogleFonts.poppins(color: Colors.black),
      ),
      actions: [
        // Tombol hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.black),
          ),
          child: Text(
            "Ya",
            style: GoogleFonts.poppins(color: Colors.black),
          ),
          onPressed: () {
            // Tambahkan logika hapus di sini
            Navigator.pop(context);
          },
        ),
        // Tombol batal
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.black),
          ),
          child: Text(
            "Batal",
            style: GoogleFonts.poppins(color: Colors.black),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
