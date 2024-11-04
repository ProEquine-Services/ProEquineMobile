import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/horses/domain/repo/horse_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/CoreModels/empty_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../manage_account/data/upload_file_response_model.dart';
import '../data/accepted_invites_response_model.dart';
import '../data/add_horse_document_request_model.dart';
import '../data/add_horse_request_model.dart';
import '../data/edit_document_request_model.dart';
import '../data/get_horses_documents_response_model.dart';
import '../data/get_user_horses_response_model.dart';
import '../data/horse_response_model.dart';
import '../data/horse_verify_response_model.dart';
import '../data/update_horse_request_model.dart';
import '../data/user_and_associated_horses_response_model.dart';
import '../data/verify_horse_request_model.dart';

part 'horse_state.dart';

class HorseCubit extends Cubit<HorseState> {
  HorseCubit() : super(HorseInitial());

  int? limit = 8;
  List<dynamic> horses = [];
  List<dynamic> userHorses = [];
  List<dynamic> userAndAssociatedHorses = [];
  List<dynamic> horsesDocuments = [];
  List<dynamic> acceptedHorses = [];
  int count = 0;
  int documentsCount = 0;
  int acceptedCount = 0;
  int userHorsesCount = 0;
  int userAndAssociatedHorsesCount = 0;
  int total = 0;
  int offset = 0;
  int documentsOffset = 0;
  int userHorsesOffset = 0;
  int userAndAssociatedHorsesOffset = 0;
  int acceptedOffset = 0;
  late RefreshController refreshController;

  Future<void> addHorse(AddHorseRequestModel addHorseRequestModel) async {
    emit(AddHorseLoading());
    var response = await HorseRepository.addHorse(addHorseRequestModel);
    if (response is HorseResponseModel) {
      emit(AddHorseSuccessfully(message: "Horse added is successfully.".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(AddHorseError(message: response.message));
    } else if (response is Message) {
      emit(AddHorseError(message: response.content));
    }
  }

  Future<void> updateHorse(
      UpdateHorseRequestModel updateHorseRequestModel) async {
    emit(UpdateHorseLoading());
    var response = await HorseRepository.updateHorse(updateHorseRequestModel);
    if (response is HorseResponseModel) {
      emit(UpdateHorseSuccessfully(
          message: "Horse details is updated.".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdateHorseError(message: response.message));
    } else if (response is Message) {
      emit(UpdateHorseError(message: response.content));
    }
  }

  Future<void> uploadFile(String file) async {
    emit(UploadFileLoading());
    var response = await HorseRepository.uploadFile(file);
    if (response is UploadFileResponseModel) {
      emit(UploadFileSuccessful(fileUrl: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UploadFileError(message: response.message));
    } else if (response is Message) {
      emit(UploadFileError(message: response.content));
    }
  }
  Future<void> uploadNationalFileFile(String file) async {
    emit(UploadNationalPassportFileLoading());
    var response = await HorseRepository.uploadFile(file);
    if (response is UploadFileResponseModel) {
      emit(UploadNationalPassportFileSuccessful(fileUrl: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UploadNationalPassportFileError(message: response.message));
    } else if (response is Message) {
      emit(UploadNationalPassportFileError(message: response.content));
    }
  }

  Future<void> removeHorse(int horseId) async {
    emit(RemoveHorseLoading());
    var response = await HorseRepository.removeHorse(horseId);
    if (response is EmptyModel) {
      emit(RemoveHorseSuccessfully(
          message: "Horse is removed successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(RemoveHorseError(message: response.message));
    } else if (response is Message) {
      emit(RemoveHorseError(message: response.content));
    }
  }

  Future<void> addHorseDocument(
      CreateHorseDocumentsRequestModel createHorseDocumentsRequestModel) async {
    emit(AddHorseDocumentLoading());
    var response = await HorseRepository.addHorseDocument(
        createHorseDocumentsRequestModel);
    if (response is EmptyModel) {
      emit(AddHorseDocumentSuccessfully(
          message: "Horse documents are submitted successfully.".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(AddHorseDocumentError(message: response.message));
    } else if (response is Message) {
      emit(AddHorseDocumentError(message: response.content));
    }
  }

  Future<void> editHorseDocument(
      EditHorseDocumentsRequestModel editHorseDocumentRequestModel) async {
    emit(EditHorseDocumentLoading());
    var response =
        await HorseRepository.editHorseDocument(editHorseDocumentRequestModel);
    if (response is EmptyModel) {
      emit(EditHorseDocumentSuccessfully(
          message: "Horse documents are submitted successfully.".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(EditHorseDocumentError(message: response.message));
    } else if (response is Message) {
      emit(EditHorseDocumentError(message: response.content));
    }
  }

  Future<void> removeHorseDocument(int docId) async {
    emit(RemoveHorseDocumentLoading());
    var response = await HorseRepository.removeHorseDocument(docId);
    if (response is EmptyModel) {
      emit(RemoveHorseDocumentSuccessfully(
          message: "Horse documents are removed successfully".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(RemoveHorseDocumentError(message: response.message));
    } else if (response is Message) {
      emit(RemoveHorseDocumentError(message: response.content));
    }
  }

  Future<void> verifyHorse(
      HorseVerificationRequestModel horseVerificationRequestModel) async {
    emit(VerifyHorseLoading());
    var response = await HorseRepository.verifyHorse(
        horseVerificationRequestModel: horseVerificationRequestModel);
    if (response is HorseVerificationResponseModel) {
      emit(VerifyHorseSuccessfully(
          message: "Horse documents are submitted successfully.".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(VerifyHorseError(message: response.message));
    } else if (response is Message) {
      emit(VerifyHorseError(message: response.content));
    }
  }

  Future<void> getAllHorses(
      {int limit = 1000,
      bool loadMore = false,
      bool isRefreshing = false,
      String? fullName}) async {
    if (isRefreshing) {
      limit = 1000;
      offset = 0;
    }
    if (loadMore) {
      offset = limit + offset;
      Print('offset1 $offset');
      if (count <= offset) {
        Print("Done");
        return;
      }
    } else {
      offset = 0;
      emit(GetHorsesLoading());
    }
    var response =
        await HorseRepository.getHorses(offset: offset, limit: limit);
    if (response is HorsesResponseModel) {
      Print("Offset is $offset");
      count = response.count!;
      List<Horse> horsesAsList = <Horse>[];
      horsesAsList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (horses.length < count) {
          horses.addAll(horsesAsList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        horses = horsesAsList;
      }
      // AppSharedPreferences.saveDataWithExpiration(
      //     horses[1], Duration(minutes: 1));
      emit(GetHorsesSuccessfully(
          horses: List<Horse>.from(horses), offset: offset, count: count));
    } else if (response is BaseError) {
      if (offset > 0) offset = 0;
      emit(GetHorsesError(message: response.message));
    } else if (response is Message) {
      emit(GetHorsesError(message: response.content));
    }
  }

  Future<void> getAllUserHorses(
      {int limit = 1000,
        bool loadMore = false,
        bool isRefreshing = false,
        String? fullName}) async {
    if (isRefreshing) {
      limit = 1000;
      offset = 0;
    }
    if (loadMore) {
      offset = limit + offset;
      if (count <= offset) {
        return;
      }
    } else {
      offset = 0;
      emit(GetUserHorsesLoading());
    }
    var response =
    await HorseRepository.getUserHorses(offset: offset, limit: limit,fullName: fullName);
    if (response is HorsesResponseModel) {
      count = response.count!;
      List<Horse> horsesAsList = <Horse>[];
      horsesAsList = response.rows!;

      if (loadMore) {
        if (horses.length < count) {
          horses.addAll(horsesAsList);
        } else {
          return;
        }
      } else {
        horses = horsesAsList;
      }
      // AppSharedPreferences.saveDataWithExpiration(
      //     horses[1], Duration(minutes: 1));
      emit(GetUserHorsesSuccessfully(
          horses: List<Horse>.from(horses), offset: offset, count: count));
    } else if (response is BaseError) {
      if (offset > 0) offset = 0;
      emit(GetUserHorsesError(message: response.message));
    } else if (response is Message) {
      emit(GetUserHorsesError(message: response.content));
    }
  }

  Future<void> getAllAcceptedHorses(
      {int limit = 8,
        bool loadMore = false,
        bool isRefreshing = false,
        String? fullName}) async {
    if (isRefreshing) {
      limit = 8;
      acceptedOffset = 0;
    }
    if (loadMore) {
      acceptedOffset = limit + acceptedOffset;
      Print('offset1 $acceptedOffset');
      if (acceptedCount <= acceptedOffset) {
        Print("Done");
        return;
      }
    } else {
      acceptedOffset = 0;
      emit(GetAcceptedHorsesLoading());
    }
    var response =
    await HorseRepository.getAcceptedHorses(offset: acceptedOffset, limit: limit);
    if (response is AcceptedInvitesResponseModel) {
      Print("Offset is $acceptedOffset");
      acceptedCount = response.count!;
      List<InviteResponseModel> acceptedHorsesAsList = <InviteResponseModel>[];
      acceptedHorsesAsList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (horses.length < count) {
          acceptedHorses.addAll(acceptedHorsesAsList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        acceptedHorses = acceptedHorsesAsList;
      }
      // AppSharedPreferences.saveDataWithExpiration(
      //     horses[1], Duration(minutes: 1));
      emit(GetAcceptedHorsesSuccessfully(
          horses: List<InviteResponseModel>.from(acceptedHorses), offset: acceptedOffset, count: acceptedCount));
    } else if (response is BaseError) {
      if (acceptedOffset > 0) acceptedOffset = 0;
      emit(GetAcceptedHorsesError(message: response.message));
    } else if (response is Message) {
      emit(GetAcceptedHorsesError(message: response.content));
    }
  }

  Future<void> getAllHorseDocuments({
    int limit = 8,
    required int horseId,
    bool loadMore = false,
    bool isRefreshing = false,
  }) async {
    if (isRefreshing) {
      limit = 8;
      documentsOffset = 0;
    }
    if (loadMore) {
      documentsOffset = limit + documentsOffset;
      Print('offset1 $documentsOffset');
      if (documentsCount <= documentsOffset) {
        Print("Done");
        return;
      }
    } else {
      documentsOffset = 0;
      emit(GetHorsesDocumentsLoading());
    }
    var response = await HorseRepository.getDocuments(
        offset: documentsOffset, limit: limit, horseId: horseId);
    if (response is AllHorseDocumentsResponseModel) {
      Print("Offset is $documentsOffset");
      documentsCount = response.count!;
      List<HorseDocuments> documentsAsList = <HorseDocuments>[];
      documentsAsList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (horsesDocuments.length < documentsCount) {
          horsesDocuments.addAll(documentsAsList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        horsesDocuments = documentsAsList;
      }
      emit(GetHorsesDocumentsSuccessfully(
          documents: List<HorseDocuments>.from(horsesDocuments),
          offset: documentsOffset,
          count: documentsCount));
    } else if (response is BaseError) {
      if (documentsOffset > 0) documentsOffset = 0;
      emit(GetHorsesDocumentsError(message: response.message));
    } else if (response is Message) {
      emit(GetHorsesDocumentsError(message: response.content));
    }
  }



  Future<void> getAllUserAndAssociatedHorse({
    int limit = 8,
    String? name,
    bool loadMore = false,
    bool isRefreshing = false,
  }) async {
    if (isRefreshing) {
      limit = 8;
      userAndAssociatedHorsesOffset = 0;
    }
    if (loadMore) {
      userAndAssociatedHorsesOffset = limit + userAndAssociatedHorsesOffset;
      Print('offset1 $userAndAssociatedHorsesOffset');
      if (userAndAssociatedHorsesCount <= userAndAssociatedHorsesOffset) {
        Print("Done");
        return;
      }
    } else {
      userAndAssociatedHorsesOffset = 0;
      emit(GetUserAndAssociatedHorsesLoading());
    }
    var response = await HorseRepository.getUserAndAssociatedHorses(
        offset: userAndAssociatedHorsesOffset, limit: limit,name: name);
    if (response is UserAndAssociatedHorsesResponseModel) {
      Print("Offset is $userAndAssociatedHorsesOffset");
      userAndAssociatedHorsesCount = response.count!;
      List<UserAndAssociatedHorses> userHorsesList = <UserAndAssociatedHorses>[];
      userHorsesList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (userAndAssociatedHorses.length < userAndAssociatedHorsesCount) {
          userAndAssociatedHorses.addAll(userHorsesList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        userAndAssociatedHorses = userHorsesList;
      }
      emit(GetUserAndAssociatedHorsesSuccessfully(
          horses: List<UserAndAssociatedHorses>.from(userAndAssociatedHorses),
          offset: userAndAssociatedHorsesOffset,
          count: userAndAssociatedHorsesCount));
    } else if (response is BaseError) {
      if (userAndAssociatedHorsesOffset > 0) userAndAssociatedHorsesOffset = 0;
      emit(GetUserAndAssociatedHorsesError(message: response.message));
    } else if (response is Message) {
      emit(GetUserAndAssociatedHorsesError(message: response.content));
    }
  }
}
