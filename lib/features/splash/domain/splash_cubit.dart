import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine_dev/features/splash/data/env_response_model.dart';
import 'package:proequine_dev/features/splash/domain/repo/splash_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proequine_dev/features/user/data/register_response_model.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/printer.dart';
import '../../../core/utils/secure_storage/secure_storage_helper.dart';


part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  String? envUrl;

  Future<void> refreshToken(String refreshToken) async {
    var response = await SplashRepository.refreshToken(refreshToken);
    if (response is RegisterResponseModel) {
      await SecureStorage().setRefreshToken(response.refreshToken!);
      await SecureStorage().setToken(response.accessToken!);
      await SecureStorage().setUserId(response.id.toString());
      AppSharedPreferences.emailVerified=response.verifiedEmail;
      if (response is RefreshSuccessfully) {
        Print(response);
      } else if (response is BaseError) {
        Print(response);
      } else if (response is Message) {
        Print(response);
      }
    }
  }

// Future<void> getEnv(String buildNumber) async {
//   var response = await SplashRepository.getTheEnvironment(buildNumber);
//   if (response is EnvResponseModel) {
//     await SecureStorage().setUrl(response.environmentURL!);
//     AppSharedPreferences.setEnvType=response.environmentURL!;
//     Print('AppSharedPreferences.getEnvType${SecureStorage().getUrl()}');
//     envUrl = response.environmentURL!;
//     if (response is BaseError) {
//       Print(response);
//     } else if (response is Message) {
//       Print(response);
//     }
//   }
// }
// Future<void> getVersion()async{
//   var response= await SplashRepository.versionModel();
//   print('this is response for all getVersion');
//   if(response is VersionResponseModel){
//     emit(VersionSuccessful(versionModel:
//     response
//     ));
//   }
//
//   else if(response is Message){
//     emit(VersionError(message: response.content));
//   }
// }
}
