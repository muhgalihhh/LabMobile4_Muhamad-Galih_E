[![Flutter](https://img.shields.io/badge/Flutter-3.24.2-blue.svg?logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.5.2-blue.svg?logo=dart)](https://dart.dev/)
[![Android](https://img.shields.io/badge/Platform-Android-green.svg?logo=android)](https://developer.android.com/)
[![iOS](https://img.shields.io/badge/Platform-iOS-green.svg?logo=apple)](https://developer.apple.com/ios/)

<table>
  <tr>
    <td style="text-align: center;">
      <img src="https://github.com/user-attachments/assets/595d8118-e3e4-48a0-ab91-1e181ead8217" height="120" alt="anime-yes"/>
    </td>
    <td style="vertical-align: middle;">
      <h5>Nama: Muhamad Galih</h5>
      <h5>NIM: H1D022052</h5>
      <h5>Shift: E (Baru)</h5>
    </td>
  </tr>
</table>



## <a id="proses"></a>Penjelasan Untuk Tiap Proses
1. [Proses Registrasi](#register)
2. [Proses Login](#login)
3. [Proses Tambah Produk](#tambah)
4. [Proses Tampil Produk](#tampil)
5. [Proses Ubah Produk](#ubah)
6. [Proses Detail Produk](#detail)
7. [Proses Hapus Produk](#hapus)
8. [Proses Logout](#logout)

## <a id="register"></a>Proses Registrasi   

<img src="https://github.com/user-attachments/assets/33c93e3f-9e1c-48c3-94ea-6119eacb68b9" width="20%">

[Daftar Proses yang Terjadi>>](#proses)

Proses registrasi terjadi melalui beberapa tahap utama, mulai dari input data, validasi, pengiriman data ke server, hingga menampilkan hasil registrasi menggunakan pop-up dialog. Berikut penjelasan singkat alur registrasi dan kode yang terlibat:

1. **Input Data oleh Pengguna:**
   - Pengguna memasukkan nama, email, password, dan konfirmasi password di dalam text field yang disediakan.
   - Kode: 
     - `TextFormField` untuk `nama`, `email`, `password`, dan `konfirmasi password`.
     - `_namaTextboxController`, `_emailTextboxController`, dan `_passwordTextboxController` digunakan untuk mengakses input.

2. **Validasi Data Input:**
   - Setelah pengguna menekan tombol registrasi, sistem melakukan validasi form, termasuk memastikan:
     - Nama minimal 3 karakter.
     - Email harus diisi dan formatnya valid.
     - Password minimal 6 karakter.
     - Konfirmasi password sesuai dengan password yang dimasukkan.
   - Kode: 
     ```dart
     validator: (value) { ... }  // Memvalidasi setiap input field.
     ```

3. **Mengirim Data ke Server:**
   - Jika validasi berhasil, aplikasi akan mengirim data ke server menggunakan method `registrasi` dari `RegistrasiBloc`.
   - Data yang dikirimkan adalah `nama`, `email`, dan `password`.
   - Kode:
     ```dart
     RegistrasiBloc.registrasi(
       nama: _namaTextboxController.text,
       email: _emailTextboxController.text,
       password: _passwordTextboxController.text)
     ```

4. **Menampilkan Popup Berdasarkan Hasil Registrasi:**
   - **Jika Registrasi Berhasil:** Ditampilkan dialog `SuccessDialog` yang menginformasikan bahwa registrasi berhasil, dan pengguna diarahkan untuk login.
     - Kode:
       ```dart
       showDialog(
         context: context,
         barrierDismissible: false,
         builder: (BuildContext context) => SuccessDialog(
           description: "Registrasi berhasil, silahkan login",
           okClick: () {
             Navigator.pop(context);
           },
         ));
       ```
   - **Jika Registrasi Gagal:** Ditampilkan `WarningDialog` yang memberitahukan bahwa registrasi gagal dan pengguna diminta untuk mencoba lagi.
     - Kode:
       ```dart
       showDialog(
         context: context,
         barrierDismissible: false,
         builder: (BuildContext context) => const WarningDialog(
           description: "Registrasi gagal, silahkan coba lagi",
         ));
       ```

### **Highlight Aliran Data:**
- Data dari text field dikirimkan melalui controller seperti `_namaTextboxController.text`.
- Method `RegistrasiBloc.registrasi` memproses data tersebut dengan mengirimnya ke server menggunakan `Api().post`.
- Setelah mendapatkan respon dari server (sukses atau gagal), pop-up dialog (`SuccessDialog` atau `WarningDialog`) akan muncul sesuai hasilnya.

## <a id="login"></a>Proses Login   

<img src="https://github.com/user-attachments/assets/513cf083-0fbb-4645-9e11-a6a692df90f8" width="20%">
<img src="https://github.com/user-attachments/assets/47a76c39-137c-42c4-beed-dda65d69a356" width="20%">

[Daftar Proses yang Terjadi>>](#proses)

Proses login pada kode ini melibatkan beberapa langkah penting, mulai dari memvalidasi inputan, mengirim data ke server, menerima respon, dan menampilkan hasilnya melalui dialog popup.

### 1. **Validasi Inputan**
   Inputan pengguna (email dan password) diverifikasi dengan menggunakan fungsi validator di TextFormField. Validasi memastikan bahwa:
   - **Email** harus diisi.
   - **Password** tidak boleh kosong.

   ```dart
   if (value!.isEmpty) {
     return 'Email harus diisi';
   }
   ```

### 2. **Mengirim Data ke Server**
   Setelah validasi, data email dan password yang dimasukkan oleh pengguna dikirim ke server melalui fungsi `LoginBloc.login()`. Kode ini mengirimkan POST request ke API URL yang ditentukan.

   ```dart
   LoginBloc.login(
     email: _emailTextboxController.text,
     password: _passwordTextboxController.text
   )
   ```

   Pada `LoginBloc.login()`, data tersebut di-encode ke format JSON dan dikirimkan ke server.

   ```dart
   var body = {"email": email, "password": password};
   var response = await Api().post(apiUrl, body);
   ```

### 3. **Menerima Respon dari Server**
   Setelah data dikirim, respon dari server akan diperiksa. Jika responnya sukses (kode status 200), token dan ID pengguna disimpan menggunakan `UserInfo()`.

   ```dart
   if (value.code == 200) {
     await UserInfo().setToken(value.token.toString());
     await UserInfo().setUserID(int.parse(value.userID.toString()));
   ```

   Jika login berhasil, pengguna diarahkan ke halaman `ProdukPage`.

   ```dart
   Navigator.pushReplacement(context,
     MaterialPageRoute(builder: (context) => const ProdukPage()));
   ```

### 4. **Menampilkan Popup**
   Berdasarkan hasil login, aplikasi akan menampilkan dialog popup. Jika login berhasil, akan muncul dialog sukses.

   ```dart
   showDialog(
     context: context,
     barrierDismissible: false,
     builder: (BuildContext context) => const SuccessDialog(
       description: "Login berhasil",
     ));
   ```

   Jika gagal, dialog gagal akan muncul.

   ```dart
   showDialog(
     context: context,
     barrierDismissible: false,
     builder: (BuildContext context) => const WarningDialog(
       description: "Login gagal, silahkan coba lagi",
     ));
   ```

#### Kesimpulan Alur Data dan Popup
- **Input data** divalidasi terlebih dahulu.
- **Data login** (email dan password) dikirim ke server.
- **Respon server** diperiksa, dan hasilnya menentukan tindakan selanjutnya.
- **Popup sukses atau gagal** akan ditampilkan berdasarkan hasil respon dari server.

## <a id="tambah"></a>Proses Tambah Produk

<img src="https://github.com/user-attachments/assets/f1c4b4b2-e35c-4b37-8092-a83d110d38fb" width="20%">
<img src="https://github.com/user-attachments/assets/1dd20efb-55e9-4636-a51b-5eb153282890" width="20%">

[Daftar Proses yang Terjadi>>](#proses)
Berikut adalah penjelasan mengenai fungsi **Tambah Produk**:

### Langkah-langkah untuk Menambah Produk:

1. **Pengaturan Formulir**:  
   Formulir digunakan untuk mengumpulkan detail produk seperti **Kode Produk**, **Nama Produk**, dan **Harga**. Setiap field ini memiliki `TextFormField` untuk validasi input.

2. **Validasi dan Pengiriman Formulir**:  
   Ketika pengguna mengklik tombol (berlabel "SIMPAN"), formulir akan memvalidasi input menggunakan fungsi validator sederhana (misalnya, memeriksa bahwa field tidak kosong).

3. **Memanggil API Tambah Produk**:  
   Jika validasi berhasil, fungsi `ProdukBloc.addProduk()` dipanggil, yang akan membuat permintaan HTTP POST ke backend untuk menyimpan produk baru. Endpoint API untuk ini didefinisikan dalam `ApiUrl.createProduk`.

4. **Dialog pada Keberhasilan/Kegagalan**:  
   Setelah produk berhasil ditambahkan, dialog keberhasilan akan ditampilkan, dan pengguna akan diarahkan kembali ke halaman daftar produk. Jika penambahan gagal, dialog peringatan akan ditampilkan.

### Fokus pada Metode `simpan()`:

```dart
void simpan() {
  setState(() {
    _isLoading = true;
  });
  
  // Membuat objek Produk baru untuk menyimpan data formulir
  Produk createProduk = Produk(id: null);
  createProduk.kodeProduk = _kodeProdukTextboxController.text;
  createProduk.namaProduk = _namaProdukTextboxController.text;
  createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
  
  // Memanggil metode API untuk menambahkan produk
  ProdukBloc.addProduk(produk: createProduk).then((value) {
    // Mengarahkan ke ProdukPage pada keberhasilan
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const ProdukPage()));
    
    // Menampilkan dialog sukses
    showDialog(
        context: context,
        builder: (BuildContext context) => const SuccessDialog(
              description: "Data berhasil disimpan",
            ));
  }, onError: (error) {
    // Menampilkan dialog kesalahan jika gagal
    showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
              description: "Simpan gagal, silahkan coba lagi",
            ));
  });
  
  // Mengatur ulang status loading
  setState(() {
    _isLoading = false;
  });
}
```

### Rincian Metode `simpan()`:

1. **Pengambilan Data Formulir**:  
   Data dari field formulir diambil menggunakan objek `TextEditingController` dan diberikan ke sebuah instance model `Produk`. Secara spesifik:
   - **Kode Produk**: Diambil dari `_kodeProdukTextboxController`.
   - **Nama Produk**: Diambil dari `_namaProdukTextboxController`.
   - **Harga Produk**: Diambil dari `_hargaProdukTextboxController` dan diparsing menjadi integer.

2. **Panggilan API**:  
   Metode `ProdukBloc.addProduk()` dipanggil untuk mengirim data produk ke backend menggunakan permintaan HTTP POST.

3. **Menangani Keberhasilan**:  
   Jika respons API berhasil, pengguna akan diarahkan ke **ProdukPage** (daftar produk), dan dialog keberhasilan akan ditampilkan.

4. **Menangani Kesalahan**:  
   Jika permintaan API gagal, dialog peringatan akan ditampilkan.

## <a id="tampil"></a>Proses Tampil Produk

<img src="https://github.com/user-attachments/assets/99b1e8c9-a127-47e5-9b9b-a29e394f3ecf" width="20%">

[Daftar Proses yang Terjadi>>](#proses)


### Struktur Kode

1. **`ProdukBloc` Class**: 
   - **Fungsi `getProduks`**: Mengambil data produk dari API dan mengonversinya menjadi list objek `Produk`.
   - **Fungsi `addProduk`, `updateProduk`, dan `deleteProduk`**: Masing-masing digunakan untuk menambah, memperbarui, dan menghapus produk dari API.

2. **`ProdukPage` Class**:
   - Merupakan halaman utama yang menampilkan daftar produk.
   - **`FutureBuilder`**: Menggunakan `FutureBuilder` untuk memanggil `getProduks()` dari `ProdukBloc` dan mengelola status pengambilan data (loading, error, atau sukses).

3. **`ListProduk` Class**:
   - Mengambil data produk dalam bentuk list dan menampilkannya menggunakan `ListView.builder`.
   - Menggunakan widget `ItemProduk` untuk menampilkan setiap produk.

4. **`ItemProduk` Class**:
   - Menerima objek `Produk` dan menampilkan nama dan harga produk dalam widget `ListTile`.
   - Menggunakan `GestureDetector` untuk menangani navigasi ke halaman detail produk saat pengguna mengklik item.

### Kode Penting

Berikut adalah bagian-bagian kode yang penting dalam proses menampilkan produk:

#### Memanggil API dan Mengambil Data
```dart
static Future<List<Produk>> getProduks() async {
  String apiUrl = ApiUrl.listProduk;
  var response = await Api().get(apiUrl);
  var jsonObj = json.decode(response.body);
  List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
  List<Produk> produks = [];
  for (int i = 0; i < listProduk.length; i++) {
    produks.add(Produk.fromJson(listProduk[i]));
  }
  return produks;
}
```
- Ini adalah fungsi yang melakukan permintaan HTTP ke API untuk mendapatkan daftar produk dan mengonversi data JSON menjadi objek `Produk`.

#### Menampilkan Daftar Produk
```dart
body: FutureBuilder<List>(
  future: ProdukBloc.getProduks(),
  builder: (context, snapshot) {
    if (snapshot.hasError) print(snapshot.error);
    return snapshot.hasData
        ? ListProduk(list: snapshot.data)
        : const Center(child: CircularProgressIndicator());
  },
)
```
- `FutureBuilder` digunakan untuk menangani status dari pengambilan data. Jika berhasil, akan memanggil `ListProduk` untuk menampilkan daftar produk.

#### Menampilkan Item Produk
```dart
class ListProduk extends StatelessWidget {
  final List? list;
  const ListProduk({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemProduk(produk: list![i]);
        });
  }
}
```
- `ListView.builder` digunakan untuk membuat daftar yang dapat digulir, di mana setiap item adalah widget `ItemProduk`.

### Kesimpulan

Kode di atas merupakan implementasi sederhana untuk menampilkan produk dari API ke dalam aplikasi Flutter. Melalui penggunaan `FutureBuilder`, data ditampilkan dengan lancar, dan widget yang terpisah memudahkan pengelolaan setiap bagian tampilan. Data produk diambil melalui `ProdukBloc` yang menangani semua interaksi dengan API.
     
## <a id="ubah"></a>Proses Ubah Produk

<img src="https://github.com/user-attachments/assets/344b2692-260c-434d-99a1-9708c0a951c3" width="20%">
<img src="https://github.com/user-attachments/assets/d8b19496-81fb-4f11-be01-d2c50f812d58" width="20%">
<img src="https://github.com/user-attachments/assets/0f16dbfc-2215-4c82-b436-fee427cf66d7" width="20%">

[Daftar Proses yang Terjadi>>](#proses)

Proses mengubah produk melibatkan beberapa langkah dan beberapa bagian kode penting. Berikut adalah penjelasan mengenai bagaimana proses ini dilakukan:

### 1. **Fungsi untuk Mengubah Produk**
Fungsi yang bertanggung jawab untuk memperbarui produk adalah `updateProduk` dalam kelas `ProdukBloc`.

```dart
static Future updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(int.parse(produk!.id!));
    var body = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.hargaProduk.toString()
    };
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
}
```

### Penjelasan Proses
1. **Membuat URL API**:
   - Pertama, fungsi ini membangun URL untuk permintaan pembaruan menggunakan `ApiUrl.updateProduk`, dengan ID produk yang ingin diubah.

2. **Menyusun Data**:
   - Selanjutnya, ia menyusun data yang akan dikirim ke server dalam bentuk `Map`. Data ini terdiri dari `kode_produk`, `nama_produk`, dan `harga`, diambil dari objek `produk` yang diberikan sebagai argumen.

3. **Mengirim Permintaan PUT**:
   - Fungsi ini kemudian mengirim permintaan `PUT` menggunakan `Api().put(apiUrl, jsonEncode(body))`, yang mengubah produk di server dengan data baru.

4. **Menangani Respons**:
   - Setelah menerima respons dari server, ia menguraikan JSON dari respons tersebut dan mengembalikan status yang menunjukkan apakah pembaruan berhasil atau tidak.

### 2. **Penggunaan Fungsi `updateProduk`**
Fungsi `updateProduk` biasanya akan dipanggil dari antarmuka pengguna, seperti dari halaman formulir produk, di mana pengguna dapat mengedit informasi produk. 

Contoh implementasinya bisa seperti ini:

```dart
void _submitUpdate() async {
    var status = await ProdukBloc.updateProduk(produk: produk);
    if (status) {
      // Tindakan setelah produk berhasil diperbarui
    } else {
      // Tindakan jika ada kesalahan
    }
}
```

### Kesimpulan
Proses mengubah produk melibatkan pembuatan URL API, pengumpulan data produk yang diperbarui, mengirim permintaan ke server, dan menangani respons. Ini memungkinkan pengguna untuk memperbarui informasi produk dengan cara yang terorganisir dan efisien.

## <a id="detail"></a>Proses Detail Produk


<img src="https://github.com/user-attachments/assets/3a2ec3b2-e914-43aa-a2cb-6499dc57767c" width="20%">

[Daftar Proses yang Terjadi>>](#proses)

Proses menampilkan detail produk dalam aplikasi Flutter ini melibatkan beberapa langkah, mulai dari pengambilan data produk hingga penampilan data tersebut dalam antarmuka pengguna. Berikut adalah penjelasan mengenai setiap langkah dalam proses ini:

### 1. **Pengambilan Data Produk**
   - **`getProduks()`**: Fungsi ini berada di dalam kelas `ProdukBloc` yang bertugas untuk mengambil daftar produk dari API. Data yang diterima dari API di-decode dari format JSON menjadi objek Dart dan diubah menjadi daftar objek `Produk`.
   - Fungsi ini dipanggil di dalam **`FutureBuilder`** pada `ProdukPage` untuk mendapatkan data produk.

### 2. **Menampilkan Daftar Produk**
   - **`ListProduk`**: Komponen ini menerima daftar produk yang diambil dan menampilkannya dalam bentuk daftar menggunakan `ListView.builder`.
   - Setiap item dalam daftar ditampilkan oleh **`ItemProduk`**, yang bertugas untuk merender setiap produk dalam bentuk `Card` yang berisi nama produk dan harganya.

### 3. **Navigasi ke Detail Produk**
   - Ketika pengguna mengetuk item produk (`ItemProduk`), aplikasi menggunakan **`GestureDetector`** untuk menangkap peristiwa ketukan. Hal ini memicu navigasi ke halaman detail produk dengan menggunakan **`Navigator.push()`**.
   - Dalam proses ini, instance `ProdukDetail` dibuat dengan mengoper objek produk yang dipilih sebagai argumen.

### 4. **Menampilkan Detail Produk**
   - **`ProdukDetail`**: Pada halaman ini, informasi detail produk ditampilkan. Data yang ditampilkan mencakup:
     - Kode Produk
     - Nama Produk
     - Harga Produk
   - Semua informasi ini diambil dari objek produk yang diterima dalam konstruktor `ProdukDetail`.

### 5. **Tombol Edit dan Hapus**
   - Pada halaman `ProdukDetail`, terdapat dua tombol: **EDIT** dan **DELETE**.
   - **Tombol EDIT**: Saat ditekan, pengguna dinavigasi ke halaman form produk (`ProdukForm`) untuk melakukan pengeditan.
   - **Tombol DELETE**: Ketika ditekan, aplikasi akan menampilkan dialog konfirmasi untuk memastikan apakah pengguna benar-benar ingin menghapus produk tersebut. Jika pengguna mengonfirmasi, fungsi `deleteProduk()` di `ProdukBloc` akan dipanggil untuk menghapus produk dari basis data.

### 6. **Menampilkan Dialog Konfirmasi**
   - Jika penghapusan berhasil, pengguna akan diberi tahu melalui dialog sukses. Jika gagal, dialog peringatan akan ditampilkan untuk memberi tahu pengguna bahwa penghapusan gagal.

### Alur Proses Menampilkan Detail Produk
1. Pengguna membuka halaman daftar produk (`ProdukPage`).
2. Data produk diambil dari API dan ditampilkan dalam daftar.
3. Pengguna memilih produk dari daftar.
4. Detail produk ditampilkan di halaman `ProdukDetail`.
5. Pengguna dapat mengedit atau menghapus produk melalui tombol yang disediakan.
6. Aplikasi memberikan umpan balik kepada pengguna terkait hasil operasi (edit atau hapus).

### Kesimpulan
Proses menampilkan detail produk mencakup pengambilan data, penampilan daftar, navigasi ke halaman detail, dan interaksi pengguna dengan tombol edit dan hapus. Ini memastikan bahwa pengguna memiliki pengalaman yang mulus dan responsif saat berinteraksi dengan aplikasi.

## <a id="hapus"></a>Proses Hapus Produk

<img src="https://github.com/user-attachments/assets/958913b1-9acb-4db1-a17c-732fbcb763ba" width="20%">
<img src="https://github.com/user-attachments/assets/b9a13fb4-b5d8-44fb-b1ce-fa43b999b8d3" width="20%">

[Daftar Proses yang Terjadi>>](#proses)

Berikut adalah highlight dari kode yang terlibat dalam mekanisme penghapusan data produk:

### 1. **Tombol Hapus di UI**

```dart
// Tombol Hapus
OutlinedButton(
  child: const Text("DELETE"),
  onPressed: () => confirmHapus(),
),
```

### 2. **Konfirmasi Hapus**

```dart
void confirmHapus() {
  AlertDialog alertDialog = AlertDialog(
    content: const Text("Yakin ingin menghapus data ini?"),
    actions: [
      // Tombol hapus
      OutlinedButton(
        child: const Text("Ya"),
        onPressed: () {
          ProdukBloc.deleteProduk(id: int.parse(widget.produk!.id!)).then(
              (value) => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProdukPage())),
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        const SuccessDialog(
                          description: "Hapus berhasil",
                        ))
              }, onError: (error) {
            showDialog(
                context: context,
                builder: (BuildContext context) => const WarningDialog(
                      description: "Hapus gagal, silahkan coba lagi",
                    ));
          });
        },
      ),
      // Tombol batal
      OutlinedButton(
        child: const Text("Batal"),
        onPressed: () => Navigator.pop(context),
      )
    ],
  );
  showDialog(builder: (context) => alertDialog, context: context);
}
```

### 3. **Menggunakan `ProdukBloc` untuk Menghapus Produk**

```dart
static Future<bool> deleteProduk({int? id}) async {
  String apiUrl = ApiUrl.deleteProduk(id!);
  var response = await Api().delete(apiUrl);
  var jsonObj = json.decode(response.body);
  return (jsonObj as Map<String, dynamic>)['data'];
}
```

### Ringkasan
- **Tombol Hapus** di UI memanggil fungsi `confirmHapus()`.
- **Fungsi `confirmHapus()`** menampilkan dialog konfirmasi dan menangani logika untuk memanggil `deleteProduk` dari `ProdukBloc`.
- **Metode `deleteProduk`** di `ProdukBloc` melakukan permintaan HTTP untuk menghapus produk dan mengembalikan hasilnya. 

Mekanisme ini memungkinkan pengguna untuk mengkonfirmasi tindakan penghapusan dan mendapatkan umpan balik berdasarkan hasil dari API.


## <a id="logout"></a>Proses Logout

<img src="https://github.com/user-attachments/assets/a8e0dba3-966d-498d-a6f6-5c47b98af00b" width="20%">
<img src="https://github.com/user-attachments/assets/5afdd05f-f246-46f9-ac88-7c888e84ed84" width="20%">

[Daftar Proses yang Terjadi>>](#proses)

Berikut adalah penjelasan mekanisme logout dalam kode yang Anda berikan:

### 1. **Tombol Logout di UI**

```dart
ListTile(
  title: const Text('Logout'),
  trailing: const Icon(Icons.logout),
  onTap: () async {
    await LogoutBloc.logout().then((value) => {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false),
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) =>
              const SuccessDialog(
                description: "Logout berhasil",
              ))
    });
  },
),
```

### 2. **Fungsi Logout**

- Ketika pengguna mengetuk **tombol Logout**, fungsi `onTap` dipanggil.
- Fungsi ini memanggil `LogoutBloc.logout()`, yang merupakan panggilan asinkron.

### 3. **LogoutBloc**

```dart
class LogoutBloc {
  static Future logout() async {
    await UserInfo().logout();
  }
}
```

- `LogoutBloc.logout()` mengandung pemanggilan metode `logout()` dari kelas `UserInfo`.
- Di dalam `UserInfo`, Anda mungkin memiliki logika yang menghapus data sesi pengguna, seperti menghapus token otentikasi atau informasi pengguna lainnya.

### 4. **Navigasi dan Dialog**

- Setelah logout berhasil, **navigasi** dilakukan untuk mengalihkan pengguna ke `LoginPage` dengan `Navigator.of(context).pushAndRemoveUntil()`. Ini akan menggantikan semua halaman di tumpukan navigasi dengan `LoginPage`.
- Sebuah dialog sukses ditampilkan menggunakan `showDialog`, memberikan umpan balik kepada pengguna bahwa logout berhasil.

### Ringkasan

1. **Pengguna mengklik tombol Logout**: Ini memicu fungsi `onTap` yang memanggil `LogoutBloc.logout()`.
2. **Logout**: Metode ini memanggil `UserInfo().logout()`, yang melakukan proses logout (misalnya, menghapus sesi pengguna).
3. **Navigasi**: Setelah logout, pengguna diarahkan kembali ke halaman login.
4. **Dialog sukses**: Dialog ditampilkan untuk memberi tahu pengguna bahwa proses logout telah berhasil.

Mekanisme ini memastikan bahwa pengguna keluar dari aplikasi dengan benar dan memberikan umpan balik visual melalui dialog setelah logout.
