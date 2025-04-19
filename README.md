# wifi_ftp_app

![App Icon](assets\icon\icon.png)

A Flutter application that implements an FTP server, allowing users to transfer files over Wi-Fi. This app is designed to provide a simple and efficient way to manage file transfers between devices on the same network.

## Features

- **FTP Server**: Start and stop an FTP server directly from the app.
- **Anonymous Login**: Users can log in anonymously without needing credentials.
- **User Management**: Admin users can set credentials for secure access.
- **Wi-Fi Connectivity Check**: Ensure the device is connected to Wi-Fi before starting the server.
- **Permissions Handling**: Request and manage necessary permissions for file access.

## Getting Started

### Prerequisites

- Flutter SDK installed on your machine.
- An Android device or emulator for testing.

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/wifi_ftp_app.git
   cd wifi_ftp_app
   ```

2. Install the dependencies:
   ```bash
   flutter pub get
   ```

3. Ensure you have the necessary permissions set in your `AndroidManifest.xml` for file access and network connectivity.

### Usage

1. Run the app on your device or emulator:
   ```bash
   flutter run
   ```

2. Use the UI to start the FTP server. You can log in as an anonymous user or with admin credentials.

3. Access the FTP server from any FTP client using the device's IP address and the specified port (default is 2121).

## Contributing

Contributions are welcome! If you have suggestions for improvements or new features, please fork the repository and submit a pull request.

1. Fork the project.
2. Create your feature branch:
   ```bash
   git checkout -b feature/YourFeature
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add some feature"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/YourFeature
   ```
5. Open a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Flutter](https://flutter.dev) - The framework used for building this application.
- [Apache FTPServer](http://mina.apache.org/ftpserver-project/) - The FTP server implementation used in this project.

For help getting started with Flutter development, view the [online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on mobile development, and a full API reference.
