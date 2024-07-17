import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine/features/user/data/check_verification_request_model.dart';
import 'package:proequine/features/user/data/interests_request_model.dart';
import 'package:proequine/features/user/data/register_request_model.dart';
import 'package:proequine/features/user/data/reset_password_request_model.dart';
import 'package:proequine/features/user/data/send_verify_request_forgot_password.dart';
import 'package:proequine/features/stables/data/stable-model.dart';
import 'package:proequine/features/user/data/update_email_request_model.dart';
import 'package:proequine/features/user/domain/repo/user_repository.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../data/check_mail_request_model.dart';
import '../data/login_request_model.dart';
import '../data/register_response_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  List<StableModel> itemList = [];
  List<String> stablesNames = [];

  Future<void> login(LoginRequestModel loginRequestModel) async {
    /// here we emit loading state while contact with server
    emit(LoginLoading());

    /// return the response from server
    var response = await UserRepository.login(loginRequestModel);

    /// if server return the same model so it's success state
    if (response is RegisterResponseModel) {
      /// store our token in shared pref
      await SecureStorage().setRefreshToken(response.refreshToken!);
      await SecureStorage().setToken(response.accessToken!);
      await SecureStorage().setUserId(response.id.toString());
      AppSharedPreferences.phoneVerified = response.verifiedPhoneNumber;
      AppSharedPreferences.inputName = response.firstName!;
      AppSharedPreferences.emailVerified = response.verifiedEmail;
      AppSharedPreferences.choseStable = response.steps!.isAddMainStable!;
      AppSharedPreferences.typeSelected = response.steps!.isAddRole!;
      AppSharedPreferences.inputPhoneNumber = response.phoneNumber!;
      AppSharedPreferences.inputEmailAddress = response.email!;
      AppSharedPreferences.hasUserAccountName = response.steps!.isAddUserName!;
      // AppSharedPreferences.inputUserName = loginRequestModel.userName!;

      /// this type of Printing working only on debug mode so maintains high performance app

      /// this message will show as a toast if the status is success
      emit(LoginSuccessful(message: "login successfully".tra));
    } else if (response is BaseError) {
      /// message will return from our handling errors in Dio
      Print("messaggeeeeeeeee${response.message}");
      emit(LoginError(message: response.message));
    } else if (response is Message) {
      /// this message will return from the server in case we have error
      emit(LoginError(message: response.content));
    }
  }

  Future<void> register(RegisterRequestModel registerRequestModel) async {
    emit(RegisterLoading());
    var response = await UserRepository.register(registerRequestModel);
    if (response is RegisterResponseModel) {
      await SecureStorage().setRefreshToken(response.refreshToken!);
      await SecureStorage().setToken(response.accessToken!);
      await SecureStorage().setUserId(response.id.toString());
      AppSharedPreferences.inputPhoneNumber = registerRequestModel.phoneNumber!;
      AppSharedPreferences.inputName = registerRequestModel.firstName!;

      // AppSharedPreferences.setPersonId = response.personId.toString();
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

      emit(RegisterSuccessful(message: "Account created successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(RegisterError(message: response.message));
    } else if (response is Message) {
      emit(RegisterError(message: response.content));
    }
  }

  Future<void> sendVerificationCode() async {
    emit(SendVerificationLoading());
    var response = await UserRepository.sendVerification();
    if (response is EmptyModel) {
      emit(SendVerificationSuccessful(
          message: "New OTP code is sent".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(SendVerificationError(message: response.message));
    } else if (response is Message) {
      emit(SendVerificationError(message: response.content));
    }
  }

  Future<void> checkVerificationCode(
      CheckVerificationCodeRequestModel
          checkVerificationCodeRequestModel) async {
    emit(CheckVerificationLoading());
    var response = await UserRepository.checkVerification(
        checkVerificationCodeRequestModel);
    if (response is RegisterResponseModel) {
      AppSharedPreferences.phoneVerified = response.verifiedPhoneNumber;
      AppSharedPreferences.emailVerified = response.verifiedEmail;
      AppSharedPreferences.choseStable = response.steps!.isAddMainStable!;
      AppSharedPreferences.typeSelected = response.steps!.isAddRole!;
      AppSharedPreferences.inputPhoneNumber = response.phoneNumber!;
      AppSharedPreferences.inputEmailAddress = response.email!;
      AppSharedPreferences.hasUserAccountName = response.steps!.isAddUserName!;

      emit(CheckVerificationSuccessful(message: "Checked successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(CheckVerificationError(message: response.message));
    } else if (response is Message) {
      emit(CheckVerificationError(message: response.content));
    }
  }

  Future<void> sendVerificationCodeForgotPassword(
      SendForgotPasswordVerifyRequestModel
          sendForgotPasswordVerifyRequestModel) async {
    emit(ForgotPasswordLoading());
    var response = await UserRepository.sendVerificationCodeForgotPassword(
        sendForgotPasswordVerifyRequestModel);
    if (response is EmptyModel) {
      emit(
          ForgotPasswordSuccessful(message: "New OTP code is sent ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(ForgotPasswordError(message: response.message));
    } else if (response is Message) {
      emit(ForgotPasswordError(message: response.content));
    }
  }

  Future<void> checkUsername(String userName) async {
    emit(CheckUsernameLoading());
    var response = await UserRepository.checkUsername(userName);
    if (response is RegisterResponseModel) {
      AppSharedPreferences.emailVerified = response.verifiedEmail;
      AppSharedPreferences.choseStable = response.steps!.isAddMainStable!;
      AppSharedPreferences.typeSelected = response.steps!.isAddRole!;
      AppSharedPreferences.inputPhoneNumber = response.phoneNumber!;
      AppSharedPreferences.inputEmailAddress = response.email!;
      AppSharedPreferences.hasUserAccountName = response.steps!.isAddUserName!;
      emit(CheckUsernameSuccessful(

          message: "Username has added successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(CheckUsernameError(message: response.message));
    } else if (response is Message) {
      emit(CheckUsernameError(message: response.content));
    }
  }

  // Future<void> forgotPassword(
  //     SendMailVerificationRequestModel sendVerificationRequestModel) async {
  //   emit(ForgotPasswordLoading());
  //   var response =
  //       await UserRepository.forgotPassword(sendVerificationRequestModel);
  //   if (response is EmptyModel) {
  //     emit(ForgotPasswordSuccessful(message: 'Verification code sent successfully'));
  //   } else if (response is BaseError) {
  //     Print("messaggeeeeeeeee${response.message}");
  //     emit(ForgotPasswordError(message: response.message));
  //   } else if (response is Message) {
  //     emit(ForgotPasswordError(message: response.content));
  //   }
  // }

  Future<void> resetPassword(
      ResetPasswordRequestModel resetPasswordRequestModel) async {
    emit(ResetPasswordLoading());
    var response =
        await UserRepository.resetPassword(resetPasswordRequestModel);
    if (response is RegisterResponseModel) {
      await SecureStorage().setRefreshToken(response.refreshToken!);
      await SecureStorage().setToken(response.accessToken!);
      await SecureStorage().setUserId(response.id.toString());
      AppSharedPreferences.phoneVerified = response.verifiedPhoneNumber;
      AppSharedPreferences.emailVerified = response.verifiedEmail;
      AppSharedPreferences.choseStable = response.steps!.isAddMainStable!;
      AppSharedPreferences.typeSelected = response.steps!.isAddRole!;
      AppSharedPreferences.inputPhoneNumber = response.phoneNumber!;
      AppSharedPreferences.inputEmailAddress = response.email!;
      AppSharedPreferences.hasUserAccountName = response.steps!.isAddUserName!;
      emit(ResetPasswordSuccessful(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(ResetPasswordError(message: response.message));
    } else if (response is Message) {
      emit(ResetPasswordError(message: response.content));
    }
  }

  Future<void> interests(InterestsRequestModel interestsRequestModel) async {
    emit(SelectInterestsLoading());
    var response = await UserRepository.interests(interestsRequestModel);
    if (response is RegisterResponseModel) {
      AppSharedPreferences.emailVerified = response.verifiedEmail;
      AppSharedPreferences.choseStable = response.steps!.isAddMainStable!;
      AppSharedPreferences.typeSelected = response.steps!.isAddRole!;
      AppSharedPreferences.inputPhoneNumber = response.phoneNumber!;
      AppSharedPreferences.inputEmailAddress = response.email!;

      AppSharedPreferences.hasUserAccountName = response.steps!.isAddUserName!;
      emit(SelectInterestsSuccessful(message: "Selected Successfully".tra));

    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(SelectInterestsError(message: response.message));
    } else if (response is Message) {
      emit(SelectInterestsError(message: response.content));
    }
  }

  Future<void> sendMailVerificationCode() async {
    emit(SendMailVerificationLoading());
    var response = await UserRepository.sendMailVerification();
    if (response is EmptyModel) {
      emit(SendMailVerificationSuccessful(
          message: "Code has sent successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(SendMailVerificationError(message: response.message));
    } else if (response is Message) {
      emit(SendMailVerificationError(message: response.content));
    }
  }

  Future<void> sendUpdateMailVerificationCode(String email) async {
    emit(SendUpdateMailVerificationLoading());
    var response = await UserRepository.sendCodeForUpdateEmail(email);
    if (response is EmptyModel) {
      emit(SendUpdateMailVerificationSuccessful(
          message: "Code has sent successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(SendUpdateMailVerificationError(message: response.message));
    } else if (response is Message) {
      emit(SendUpdateMailVerificationError(message: response.content));
    }
  }

  Future<void> checkMailVerificationCode(
      CheckMailVerificationRequestModel
          checkMailVerificationRequestModel) async {
    emit(CheckMailVerificationLoading());
    var response = await UserRepository.checkMailVerification(
        checkMailVerificationRequestModel);
    if (response is RegisterResponseModel) {
      AppSharedPreferences.emailVerified = response.verifiedEmail;
      emit(CheckMailVerificationSuccessful(
          message: "E-mail updated successfully.".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(CheckMailVerificationError(message: response.message));
    } else if (response is Message) {
      emit(CheckMailVerificationError(message: response.content));
    }
  }

  Future<void> updateMail(UpdateMailRequestModel updateMailRequestModel) async {
    emit(UpdateMailLoading());
    var response = await UserRepository.updateMail(updateMailRequestModel);
    if (response is EmptyModel) {
      emit(UpdateMailSuccessful(message: "code has been sent".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdateMailError(message: response.message));
    } else if (response is Message) {
      emit(UpdateMailError(message: response.content));
    }
  }

  Future<void> checkUpdatedMail(
      String otpCode) async {
    emit(CheckUpdateMailLoading());
    var response =
        await UserRepository.checkUpdateMail(otpCode);
    if (response is RegisterResponseModel) {
      AppSharedPreferences.emailVerified = true;
      emit(CheckUpdateMailSuccessful(
          message: "Email Updated successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(CheckUpdateMailError(message: response.message));
    } else if (response is Message) {
      emit(CheckUpdateMailError(message: response.content));
    }
  }
}
