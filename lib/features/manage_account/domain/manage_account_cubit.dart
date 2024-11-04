import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/manage_account/domain/repo/manage_account_repository.dart';
import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/CoreModels/empty_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../user/data/register_response_model.dart';
import '../data/add_address_request_model.dart';
import '../data/add_secondary_number_request_model.dart';
import '../data/add_secondary_number_response_model.dart';
import '../data/change_password_request_model.dart';
import '../data/configuration_response_model.dart';
import '../data/confirm_change_phone_number_response_model.dart';
import '../data/edit_phone_request_model.dart';
import '../data/update_main_number_request_model.dart';
import '../data/update_secondary_number_request_model.dart';
import '../data/upload_file_response_model.dart';
import '../data/user_data_response_model.dart';
import '../data/user_info_request_model.dart';

part 'manage_account_state.dart';

class ManageAccountCubit extends Cubit<ManageAccountState> {
  ManageAccountCubit() : super(ManageAccountInitial());

  Future<void> changePassword(
      ChangePasswordRequestModel updatePasswordRequestModel) async {
    emit(ChangePasswordLoading());
    var response = await ManageAccountRepository.changePassword(
        updatePasswordRequestModel);
    if (response is RegisterResponseModel) {
      // AppSharedPreferences.setPersonId = response.authenticationResponse!.personId.toString();
      emit(ChangePasswordSuccessful(
          message: "Password changed successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(ChangePasswordError(message: response.message));
    } else if (response is Message) {
      emit(ChangePasswordError(message: response.content));
    }
  }

  Future<void> uploadFile(String file) async {
    emit(UploadFileLoading());
    var response = await ManageAccountRepository.uploadFile(file);
    if (response is UploadFileResponseModel) {
      emit(UploadFileSuccessful(fileUrl: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UploadFileError(message: response.message));
    } else if (response is Message) {
      emit(UploadFileError(message: response.content));
    }
  }

  Future<void> updateProfileImage(String imageUrl) async {
    emit(UpdateImageLoading());
    var response = await ManageAccountRepository.updateUserImage(imageUrl);
    if (response is UserDataResponseModel) {
      emit(UpdateImageSuccessful(response: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdateImageError(message: response.message));
    } else if (response is Message) {
      emit(UpdateImageError(message: response.content));
    }
  }

  Future<void> updateUserInfo(UserInfoRequestModel userInfoRequestModel) async {
    emit(UpdateUserInfoLoading());
    var response =
        await ManageAccountRepository.updateUserInfo(userInfoRequestModel);
    if (response is UserDataResponseModel) {
      AppSharedPreferences.inputName=response.firstName!;
      emit(UpdateUserInfoSuccessful(
          message: "Date Of Birth Updated Successfully".tra));
    } else if (response is BaseError) {
      emit(UpdateUserInfoError(message: response.message));
    } else if (response is Message) {
      emit(UpdateUserInfoError(message: response.content));
    }
  }

  Future<void> sendPhoneNumber(
      EditPhoneRequestModel editPhoneRequestModel) async {
    emit(SendPhoneLoading());
    var response =
        await ManageAccountRepository.sendPhoneNumber(editPhoneRequestModel);
    if (response is EmptyModel) {
      emit(SendPhoneSuccessful(message: "New OTP code is sent".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(SendPhoneError(message: response.message));
    } else if (response is Message) {
      emit(SendPhoneError(message: response.content));
    }
  }

  Future<void> updatePhoneNumber(
      UpdateMainNumberRequestModel updateMainNumberRequestModel) async {
    emit(UpdatePhoneLoading());
    var response = await ManageAccountRepository.updatePhoneNumber(
        updateMainNumberRequestModel);
    if (response is ConfirmChangePhoneNumberResponseModel) {
      AppSharedPreferences.phoneVerified = response.verifiedPhoneNumber;
      AppSharedPreferences.inputPhoneNumber = response.phoneNumber!;

      emit(UpdatePhoneSuccessful(message: "Phone Updated successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdatePhoneError(message: response.message));
    } else if (response is Message) {
      emit(UpdatePhoneError(message: response.content));
    }
  }

  Future<void> updateSecondaryNumber(
      UpdateSecondaryNumberRequestModel
          updateSecondaryNumberRequestModel) async {
    emit(UpdateSecondaryPhoneLoading());
    var response = await ManageAccountRepository.updateSecondaryPhoneNumber(
        updateSecondaryNumberRequestModel);
    if (response is UserDataResponseModel) {
      //
      emit(UpdatePhoneSecondarySuccessful(
          message: "Phone Updated successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdatePhoneSecondaryError(message: response.message));
    } else if (response is Message) {
      emit(UpdatePhoneSecondaryError(message: response.content));
    }
  }

  Future<void> addAddress(AddAddressRequestModel addAddressRequestModel) async {
    emit(AddAddressLoading());
    var response =
        await ManageAccountRepository.addAddress(addAddressRequestModel);
    if (response is EmptyModel) {
      emit(AddAddressSuccessfully(
          message: "The Address has been added successfully ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(AddAddressError(message: response.message));
    } else if (response is Message) {
      emit(AddAddressError(message: response.content));
    }
  }

  Future<void> addSecondaryNumber(
      AddSecondaryNumberRequestModel addSecondaryNumberRequestModel) async {
    emit(AddSecondaryPhoneLoading());
    var response = await ManageAccountRepository.addSecondaryNumber(
        addSecondaryNumberRequestModel);
    if (response is AddSecondaryNumberResponseModel) {
      emit(AddSecondaryPhoneSuccessful(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(AddSecondaryPhoneError(message: response.message));
    } else if (response is Message) {
      emit(AddSecondaryPhoneError(message: response.content));
    }
  }

  Future<void> getUser() async {
    emit(GetUserLoading());
    var response = await ManageAccountRepository.getUserData();
    if (response is UserDataResponseModel) {
      AppSharedPreferences.emailVerified = response.verifiedEmail;
      AppSharedPreferences.inputName=response.firstName!;

      emit(GetUserSuccessful(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(GetUserError(message: response.message));
    } else if (response is Message) {
      emit(GetUserError(message: response.content));
    }
  }

  Future<void> getConfiguration() async {
    emit(GetConfigurationLoading());
    var response = await ManageAccountRepository.getConfiguration();
    if (response is ConfigurationResponseModel) {
      emit(GetConfigurationSuccessfully(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(GetConfigurationError(message: response.message));
    } else if (response is Message) {
      emit(GetConfigurationError(message: response.content));
    }
  }

// Future<void> addBio(AddBioRequestModel addBioRequestModel) async {
//   emit(AddBioLoading());
//   var response = await ManageAccountRepository.addBio(addBioRequestModel);
//   if (response is EmptyModel) {
//     emit(AddBioSuccessful(
//         message: "Social Accounts has been added successfully".tra));
//   } else if (response is BaseError) {
//     Print("messaggeeeeeeeee${response.message}");
//     emit(AddBioError(message: response.message));
//   } else if (response is Message) {
//     emit(AddBioError(message: response.content));
//   }
// }
}
