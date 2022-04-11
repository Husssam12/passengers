import 'dart:async';
import 'dart:convert';

import 'package:p_network/p_refresh_token.dart';
import 'package:shop_app/common/const/const.dart';

import '../../../../../core/storage/storage_service.dart';
import '../models/token.dart';

class TokenStorageImpl extends TokenStorage<AuthTokenModel>
    with ReactiveAuthStatusMixin {
  final IStorageService storageService;

  TokenStorageImpl(this.storageService) : super();

  @override
  FutureOr<void> delete(String? message) async {
    await storageService.remove(kTokenKey);
    super.delete(message);
  }

  @override
  FutureOr<void> write(AuthTokenModel? token) async {
    final data = token != null ? json.encode(token.toMap()) : null;
    await storageService.setString(kTokenKey, data);
    super.write(token);
  }

  @override
  AuthTokenModel? read() {
    final String? string = storageService.getString(kTokenKey);
    if (string != null) {
      return AuthTokenModel.fromMap(json.decode(string));
    }
    return null;
  }
}
