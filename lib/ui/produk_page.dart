import 'package:flutter/material.dart';
import 'package:frontend_toko/model/produk.dart';
import 'package:frontend_toko/ui/produk_detail.dart';
import 'package:frontend_toko/ui/produk_form.dart';
import 'package:google_fonts/google_fonts.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih
      appBar: AppBar(
        title: Text(
          'List Produk Galih',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.black, // AppBar hitam
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0, color: Colors.white),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProdukForm()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text(
                'Logout',
                style: GoogleFonts.poppins(color: Colors.black),
              ),
              trailing: const Icon(Icons.logout, color: Colors.black),
              onTap: () async {
                // Tambahkan logika logout di sini
              },
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          ItemProduk(
            produk: Produk(
              id: 1,
              kodeProduk: 'A001',
              namaProduk: 'Kamera',
              hargaProduk: 5000000,
            ),
          ),
          ItemProduk(
            produk: Produk(
              id: 2,
              kodeProduk: 'A002',
              namaProduk: 'Kulkas',
              hargaProduk: 2500000,
            ),
          ),
          ItemProduk(
            produk: Produk(
              id: 3,
              kodeProduk: 'A003',
              namaProduk: 'Mesin Cuci',
              hargaProduk: 2000000,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;

  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(produk: produk),
          ),
        );
      },
      child: Card(
        color: Colors.white, // Background card putih
        child: ListTile(
          title: Text(
            produk.namaProduk!,
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          subtitle: Text(
            'Rp ${produk.hargaProduk.toString()}',
            style: GoogleFonts.poppins(color: Colors.grey[600]),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
        ),
      ),
    );
  }
}
