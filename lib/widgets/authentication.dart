class Authentication {
  bool isLoggedIn = false;

  Future<bool> login(String username, String password) async {
    // Verificar las credenciales, por ejemplo, haciendo una solicitud HTTP
    if (username == 'Angel' && password == '123' ||
        username == 'Iran' && password == '321') {
      isLoggedIn = true;
      return true;
    } else {
      return false;
    }
  }

  void logout() {
    isLoggedIn = false;
  }
}
