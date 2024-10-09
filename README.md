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
6. [Proses Hapus Produk](#hapus)
7. [Proses Detail Produk](#detail)
8. [Proses Logout](#logout)

### <a id="register"></a>Proses Registrasi   

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

### <a id="login"></a>Proses Login   

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

### Kesimpulan Alur Data dan Popup
- **Input data** divalidasi terlebih dahulu.
- **Data login** (email dan password) dikirim ke server.
- **Respon server** diperiksa, dan hasilnya menentukan tindakan selanjutnya.
- **Popup sukses atau gagal** akan ditampilkan berdasarkan hasil respon dari server.
