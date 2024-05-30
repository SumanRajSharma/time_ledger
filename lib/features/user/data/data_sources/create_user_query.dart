const String createUserQuery = '''
mutation CreateUser(\$email: String!, \$fullName: String!, \$phoneNumber: String!, \$password: String!) {
  createUser(userInput: {
    email: \$email,
    fullName: \$fullName,
    phoneNumber: \$phoneNumber,
    password: \$password
  }) {
    id
    email
  }
}
''';
