import 'package:workbridge/core/constants/api_constants.dart';
import 'package:workbridge/core/network/dio_client.dart';
import 'package:workbridge/core/utils/secure_storage_service.dart';
import 'package:workbridge/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> register({required String firstName, required String lastName, required String email, required String password, required String role});

  Future<UserModel> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;
  final SecureStorageService _secureStorageService;

  AuthRemoteDataSourceImpl(this._dioClient, this._secureStorageService);

  @override
  Future<UserModel> register({required String firstName, required String lastName, required String email, required String password, required String role}) async {
    final response = await _dioClient.post(ApiConstants.register, data: {'firstName': firstName, 'lastName': lastName, 'email': email, 'password': password, 'role': role});

    final data = response.data as Map<String, dynamic>;

    // Save tokens and user info to Secure Storage
    final accessToken = data['accessToken'] as String?;
    if (accessToken != null) {
      await _secureStorageService.saveToken(accessToken);
    }

    final userRole = data['role'] as String?;
    if (userRole != null) {
      await _secureStorageService.saveUserRole(userRole);
    }

    return UserModel.fromJson(data);
  }

  @override
  Future<UserModel> login({required String email, required String password}) async {
    final response = await _dioClient.post(ApiConstants.login, data: {'email': email, 'password': password});

    final data = response.data as Map<String, dynamic>;

    // Save token and role to SecureStorageService
    final accessToken = data['accessToken'] as String?;
    if (accessToken != null) {
      await _secureStorageService.saveToken(accessToken);
    }

    final userRole = data['role'] as String?;
    if (userRole != null) {
      await _secureStorageService.saveToken(userRole);
    }

    return UserModel.fromJson(data);
  }
}
