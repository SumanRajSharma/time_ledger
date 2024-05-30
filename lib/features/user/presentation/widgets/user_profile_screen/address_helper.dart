class Address {
  final String streetNumber;
  final String streetName;
  final String suburb;
  final String state;
  final String postalCode;

  Address({
    required this.streetNumber,
    required this.streetName,
    required this.suburb,
    required this.state,
    required this.postalCode,
  });

  @override
  String toString() {
    return '$streetNumber $streetName, $suburb, $state, $postalCode';
  }
}

Address parseAddress(String address) {
  final parts = address.split(',').map((part) => part.trim()).toList();

  if (parts.length != 4) {
    throw const FormatException('Invalid address format');
  }

  final streetParts = parts[0].split(' ');
  final streetNumber = streetParts.first;
  final streetName = streetParts.skip(1).join(' ');

  final suburb = parts[1];
  final state = parts[2];
  final postalCode = parts[3];

  return Address(
    streetNumber: streetNumber,
    streetName: streetName,
    suburb: suburb,
    state: state,
    postalCode: postalCode,
  );
}
