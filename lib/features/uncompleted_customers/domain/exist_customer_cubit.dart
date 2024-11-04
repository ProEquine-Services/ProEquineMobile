import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/CoreModels/empty_model.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/uncompleted_customers/data/update_exist_account_request_model.dart';
import 'package:proequine_dev/features/uncompleted_customers/domain/repo/exist_customer_repository.dart';
import 'package:proequine_dev/features/user/data/login_response_model.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

part 'exist_customer_state.dart';

class ExistCustomerCubit extends Cubit<ExistCustomerState> {
  ExistCustomerCubit() : super(ExistCustomerInitial());

  Future<void> updateExistCustomer(UpdateExistAccountRequestModel updateExistCustomer) async {
    emit(UpdateCustomerDetailsLoading());
    var response = await ExistCustomerRepository.updateExistCustomerDetails(updateExistCustomer);
    if (response is LoginResponseModel) {
      await SecureStorage().setRefreshToken(response.refreshToken!);
      await SecureStorage().setToken(response.accessToken!);
      await SecureStorage().setUserId(response.id.toString());
      AppSharedPreferences.inputPhoneNumber = response.phoneNumber!;
      AppSharedPreferences.inputName = response.firstName!;
      AppSharedPreferences.emailVerified = response.verifiedEmail;
      AppSharedPreferences.choseStable = response.steps!.isAddMainStable!;
      AppSharedPreferences.typeSelected = response.steps!.isAddRole!;
      AppSharedPreferences.inputPhoneNumber = response.phoneNumber!;
      AppSharedPreferences.inputEmailAddress = response.email!;
      AppSharedPreferences.hasUserAccountName = response.steps!.isAddUserName!;
      String? refreshToken = await SecureStorage().getRefreshToken();
      String? accessToken = await SecureStorage().getToken();
      String? userId = await SecureStorage().getUserId();
      Print("access token $accessToken");
      Print("refresh token $refreshToken");
      Print("userId $userId");

      emit(UpdateCustomerDetailsSuccessfully(message: "Account updated successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdateCustomerDetailsError(message: response.message));
    } else if (response is Message) {
      emit(UpdateCustomerDetailsError(message: response.content));
    }
  }


  Future<void> sendCredentials(int userId) async {
    emit(SendCredentialsLoading());
    var response = await ExistCustomerRepository.sendCredentials(userId);
    if (response is EmptyModel) {
      emit(SendCredentialsSuccessfully(message: "Credentials sent successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(SendCredentialsError(message: response.message));
    } else if (response is Message) {
      emit(SendCredentialsError(message: response.content));
    }
  }
}
