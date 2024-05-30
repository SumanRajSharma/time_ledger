class LoginQueries {
  static const String loginMutation = '''
    mutation Login(\$email: String!, \$password: String!) {
      login(email: \$email, password: \$password) {
        userId
        token
        tokenExpiration
      }
    }
  ''';
}
