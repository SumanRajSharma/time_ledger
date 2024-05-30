const String createClientQuery = '''
mutation CreateClient(
  \$name: String!, 
  \$address: String!, 
  \$participantName: String!, 
  \$participantNumber: String!, 
  \$careTypes: [CareTypeInput!]!, 
  \$rate: RateInput!
) {
  createClient(
    clientInput: {
      name: \$name,
      address: \$address,
      participant_name: \$participantName,
      participant_number: \$participantNumber,
      care_type: \$careTypes,
      rate: \$rate
    }
  ) {
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
