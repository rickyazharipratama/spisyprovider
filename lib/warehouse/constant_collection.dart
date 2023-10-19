class ConstantCollection{

  static final ConstantCollection repository = ConstantCollection();

  DatabaseConstants get database => DatabaseConstants();
  ErrorConstants get errors => ErrorConstants();
  RouterConstants get routers => RouterConstants();
  

}

class DatabaseConstants{
  
  String tableStudent = "student";
  String tableUser = "user";

}

class ErrorConstants{
  String loginFailed = "Nama Pengguna / kata sandi yang anda masukkan tidak terdaftar.";
  String usernameEmpty = "Silakan masukkan nama pengguna Anda.";
  String passwordEmpty = "Silakan masukkan kata sandi Anda.";
  String nameFormEmpty = "Silakan masukkan nama siswa.";
  String addressFormEmpty = "Silakan masukkan alamat msiswa.";
  String birthFormEmpty = "Silakan pilih tanggal lahir siswa.";
  String genderUnselected = "Silakan pilih jenis kelamin siswa.";
}


class RouterConstants{

  final RouterLocationConstants location = RouterLocationConstants();
  final RouterNameConstants name = RouterNameConstants();
  final PathParameters params = PathParameters();
}

class RouterLocationConstants{
   String index = "/";
   String listStudent = "/listStudent";
   String splash = "/splash";
   String login = "/login";
   String form = "/form";
   String logout = "/logout";
   String dialog = "/dialog";
}

class RouterNameConstants{
  String index = "landing_page";
  String listStudent = "ListSTudent";
  String splash = "splash";
  String login = "login";
  String form = "form";
  String logout="logout";
  String dialog = "dialog";
}

class PathParameters{
  String loading = "loading";
}