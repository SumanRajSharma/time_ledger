# Time_Ledger

Time_Ledger is a mobile application designed to assist independent disability workers in managing their work hours, tracking client details, and generating invoices efficiently. Built using Flutter for the frontend and leveraging MongoDB and GraphQL for the backend, Time_Ledger offers a robust solution for freelance workers in the healthcare sector.

## Features

- **Client Management**: Add and manage client information including care rates and types.
- **Hour Tracking**: Easily log hours worked for each client.
- **Invoice Generation**: Automatically generate invoices based on logged hours and client rates.
- **Secure Login**: User authentication to ensure data security.

## Getting Started

### Prerequisites

- Flutter (Latest version)
- Dart (Latest version)
- A MongoDB database
- GraphQL API setup

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/time_ledger.git
   ```
2. Navigate to the project directory:
   ```bash
   cd time_ledger
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the application:
   ```bash
   flutter run
   ```

## Usage

After launching the app, log in with your credentials. Add clients through the 'Manage Clients' section. To log hours, select a client and enter the hours worked. Invoices can be generated through the 'Generate Invoice' section and will automatically calculate the total amount based on the client's rate and logged hours.

## Architecture

This app implements clean architecture principles, dividing the structure into three layers:
- **Presentation Layer**: Contains UI components and state management.
- **Domain Layer**: Encapsulates business logic and use cases.
- **Data Layer**: Manages data handling with MongoDB and GraphQL interactions.

## Contributing

Contributions are welcome! For major changes, please open an issue first to discuss what you would like to change.

Please ensure to update tests as appropriate.

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

- Suman R Sharma - [sumanrjsharma@gmail.com](mailto:sumanrjsharma@gmail.com)
- [GitHub](https://github.com/sumanrajsharma)
