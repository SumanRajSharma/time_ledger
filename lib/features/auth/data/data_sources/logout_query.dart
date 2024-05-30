class LogoutMutations {
  static String logout = '''
    mutation Logout(\$token: String!) {
      logout(token: \$token)
    }
  ''';
}
