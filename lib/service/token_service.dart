// data/services/secure_token_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class SecureTokenService {
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  bool isTokenExpired(String token) {
    try {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      DateTime expiryDate =
          DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      return DateTime.now().isAfter(expiryDate);
    } catch (e) {
      return true;
    }
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }
}
