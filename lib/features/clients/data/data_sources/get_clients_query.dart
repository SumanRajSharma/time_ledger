const String getClientsQuery = r'''
  query {
    getClients {
      id
      name
      address
      participant_name
      participant_number
      care_type {
        care_title
        description
      }
      rate {
        monday
        tuesday
        wednesday
        thursday
        friday
        saturday
        sunday
        public_holiday
      }
    }
  }
''';
