const String getUserQuery = '''
query {
  me {
    id
    email
    fullName
    address
    phoneNumber
    ABN
    bankDetails {
      accountName
      accountNumber
      BSB
    }
  }
}
''';
