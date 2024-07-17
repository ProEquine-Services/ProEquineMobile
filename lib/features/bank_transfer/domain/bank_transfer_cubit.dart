import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/features/bank_transfer/data/all_bank_transfers_response_model.dart';
import 'package:proequine/features/bank_transfer/data/create_bank_transfer_request_model.dart';
import 'package:proequine/features/bank_transfer/data/create_bank_transfer_response_model.dart';
import 'package:proequine/features/bank_transfer/data/get_bank-account_response_model.dart';
import 'package:proequine/features/bank_transfer/data/save_bank_account_request_model.dart';
import 'package:proequine/features/bank_transfer/data/save_bank_account_response_model.dart';
import 'package:proequine/features/bank_transfer/domain/repo/bank_transfers_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/CoreModels/base_result_model.dart';
import '../../../core/data_source/remote_data_source.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/http/api_urls.dart';
import '../../../core/http/http_method.dart';
import '../../../core/utils/Printer.dart';
import '../../manage_account/data/upload_file_response_model.dart';

part 'bank_transfer_state.dart';

class BankTransferCubit extends Cubit<BankTransferState> {
  BankTransferCubit() : super(BankTransferInitial());

  int? limit = 8;
  List<dynamic> transfers = [];
  int count = 0;
  int total = 0;
  int offset = 0;
  late RefreshController refreshController;

  Future<void> getAllBankTransfers({
    int limit = 8,
    bool loadMore = false,
    bool isRefreshing = false,
  }) async {
    if (isRefreshing) {
      limit = 8;
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
      emit(GetAllBankTransfersLoading());
    }
    var response = await BankTransferRepository.getAllBankTransfers(
        offset: offset, limit: limit);
    if (response is GetAllBankTransfersResponseModel) {
      Print("Offset is $offset");
      count = response.count!;
      List<BankTransfer> transfersAsList = <BankTransfer>[];
      transfersAsList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (transfers.length < count) {
          transfers.addAll(transfersAsList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        transfers = transfersAsList;
      }
      emit(GetAllBankTransfersSuccessful(
          responseModel: List<BankTransfer>.from(transfers),
          offset: offset,
          count: count));
    } else if (response is BaseError) {
      if (offset > 0) offset = 0;
      emit(GetAllBankTransfersError(message: response.message));
    } else if (response is Message) {
      emit(GetAllBankTransfersError(message: response.content));
    }
  }

  Future<void> saveBankAccount(
      SaveBankAccountRequestModel saveBankAccountRequestModel) async {
    emit(SaveBankAccountLoading());
    var response = await BankTransferRepository.saveBankAccount(
        saveBankAccountRequestModel);
    if (response is SaveBankAccountResponseModel) {
      AppSharedPreferences.setBankAccount=true;
      emit(SaveBankAccountSuccessful(
          message: "Bank Account is saved successfully. ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(SaveBankAccountError(message: response.message));
    } else if (response is Message) {
      emit(SaveBankAccountError(message: response.content));
    }
  }

  Future<void> uploadFile(String file) async {
    emit(UploadTransferProofLoading());
    var response = await BankTransferRepository.uploadFile(file);
    if (response is UploadFileResponseModel) {
      emit(UploadTransferProofSuccessfully(fileUrl: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UploadTransferProofError(message: response.message));
    } else if (response is Message) {
      emit(UploadTransferProofError(message: response.content));
    }
  }

  Future<void> getBankAccount() async {
    emit(GetBankAccountLoading());
    var response = await BankTransferRepository.getBankAccount();
    if (response is GetBankAccountResponseModel) {
      emit(GetBankAccountSuccessfully(model: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(GetBankAccountError(message: response.message));
    } else if (response is Message) {
      emit(GetBankAccountError(message: response.content));
    }
  }


  Future<void> createBankTransfer(CreateBankTransferRequestModel createBankTransferRequestModel) async {
    emit(CreateBankPayLoading());
    var response = await BankTransferRepository.createBankTransfer(createBankTransferRequestModel);
    if (response is CreateBankTransferResponseModel) {
      emit(CreateBankPaySuccessfully(response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(CreateBankPayError(message: response.message));
    } else if (response is Message) {
      emit(CreateBankPayError(message: response.content));
    }
  }
  Future<void> pushTransfer(int id) async {
    emit(PushTransferLoading());
    var response = await BankTransferRepository.pushTransfer(id);
    if (response is EmptyModel) {
      emit(PushTransferSuccessfully('Your rransfer is submitted successfully.'));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(PushTransferError(message: response.message));
    } else if (response is Message) {
      emit(PushTransferError(message: response.content));
    }
  }
}
