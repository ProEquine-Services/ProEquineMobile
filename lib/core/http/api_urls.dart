import '../../app_settings.dart';

class ApiURLs {
  static String baseUrl = AppSettings.baseUrl;

  static String basicApiUrl = "$baseUrl/v1";

  /// Auth URLs
  static String loginUSER = "$basicApiUrl/auth/login";
  static String registerUSER = "$basicApiUrl/auth/signUp";
  static String getNewToken = "$basicApiUrl/auth/refresh-token";
  static String sendVerificationCode =
      "$basicApiUrl/auth/ask-for-verify-phone-number-otp";

  static String updateUserName = "$basicApiUrl/auth/update-userName";
  static String updateName = "$basicApiUrl/Account/updateName";
  static String forgotPassword =
      "$basicApiUrl/auth/ask-for-forget-password-otp";
  static String updateNationality = "$basicApiUrl/Account/updateNationality";
  static String updateUserInfo = "$basicApiUrl/auth/update-user-info";
  static String updateCustomerDetails = "$basicApiUrl/auth/update-account-after-first-login";
  static String sendCredentials = "$basicApiUrl/auth/send-credentials";
  static String checkVerificationCode =
      "$basicApiUrl/auth/confirm-verify-phone-number";
  static String resetPassword = "$basicApiUrl/auth/confirm-forget-password";
  static String interests = "$basicApiUrl/auth/update-roles-and-disciplines";
  static String choseStables = "$basicApiUrl/auth/update-stable";

  /// Account information
  static String getUserDiscipline = "$basicApiUrl/userDisciplines";
  static String configurations = "$basicApiUrl/configurations/";
  static String getUserStables = "$basicApiUrl/userStables";
  static String uploadFile = "$basicApiUrl/upload";
  static String updateImage = "$basicApiUrl/auth/update-image";
  static String addSecondaryDiscipline = "$basicApiUrl/userDisciplines";
  static String addSecondaryStable = "$basicApiUrl/userStables";
  static String addNewStable = "$basicApiUrl/stables";

  static String updateSecondaryDiscipline =
      "$basicApiUrl/Account/updateSecondaryDiscipline";
  static String deleteDiscipline =
      "$basicApiUrl/Account/removeSecondaryDiscipline";
  static String deleteStable = "$basicApiUrl/userStables";
  static String changePassword = "$basicApiUrl/auth/reset-password";
  static String addBio = "$basicApiUrl/Account/addBioAndSocialMediaAccount";
  static String sendPhone = "$basicApiUrl/auth/ask-change-phone-number-otp";
  static String updatePhone =
      "$basicApiUrl/auth/confirm-change-phone-number-otp";
  static String updateSecondaryPhone = "$basicApiUrl/auth/update-second-number";
  static String addSecondaryNumber = "$basicApiUrl/Account/addSecondaryNumber";
  static String addAddress = "$basicApiUrl/auth/update-address";
  static String contactSupport = "$basicApiUrl/supportRequests";
  static String getUserData = "$basicApiUrl/auth/my-profile";
  static String sendVerificationEmail =
      "$basicApiUrl/auth/ask-for-verify-email-otp";
  static String sendUpdateVerificationEmail =
      "$basicApiUrl/auth/ask-change-email";
  static String checkVerificationEmail =
      "$basicApiUrl/auth/confrim-verify-email";
  static String updateMail = "$basicApiUrl/User/editemailaddress";
  static String checkUpdateMail = "$basicApiUrl/auth/confrim-verify-email";

  /// Events URLs
  static String allEvents = "$baseUrl/MobileApp/GetEvents";

  /// Horses URLs

  static String addHorse = "$basicApiUrl/horses";
  static String invitesAssociations =
      "$basicApiUrl/horseAssociations/user/invite";
  static String requestAssociations = "$basicApiUrl/horseAssociations/horse";
  static String horseAssociation = "$basicApiUrl/horseAssociations";
  static String horseAssociationApprove =
      "$basicApiUrl/horseAssociations/approve";
  static String horseAssociationReject =
      "$basicApiUrl/horseAssociations/reject";
  static String getHorses = "$basicApiUrl/horses/user";
  static String getUserHorses = "$basicApiUrl/horses/user";
  static String getAcceptedHorses =
      "$basicApiUrl/horses/user-with-approved-invite-associations";
  static String updateHorseCondition =
      "$baseUrl/api/Horse/updateHorseCondition";
  static String removeHorse = "$basicApiUrl/horses";
  static String horsesWithAssociated = "$basicApiUrl/horses/user-with-approved-invite-associations";


  ///horses docs
  static String addHorseDocument = "$basicApiUrl/horseDocuments/";
  static String editHorseDocument = "$basicApiUrl/horseDocuments/";
  static String removeHorseDocument = "$basicApiUrl/horseDocuments/delete";
  static String allDocuments = "$basicApiUrl/horseDocuments/horse-documents";
  static String verifyHorse = "$basicApiUrl/horses/verification-document";

  /// stables and places APIs

  static String getStables = "$basicApiUrl/stables/public";
  static String getAllPlaces = "$basicApiUrl/places/public";
  static String getUserPlaces = "$basicApiUrl/places/user";
  static String addNewPlace = "$basicApiUrl/places/";

  /// support request
  static String getAllRequests = "$basicApiUrl/supportRequests/user";

  /// wallet
  static String getWallet = "$basicApiUrl/accounts/my-account";
  static String saveBankAccount = "$basicApiUrl/accounts/update-bank-account";
  static String getBankAccount = "$basicApiUrl/accounts/my-account";
  static String getTransactions = "$basicApiUrl/accounts/my-transactions";
  static String getPaymentDetails = "$basicApiUrl/payment";

  /// bank account:
  static String bankTransfers = "$basicApiUrl/bankTransfer";
  static String pushTransfer = "$basicApiUrl/bankTransfer/push";


  /// ProEquine Services
  static String createTransport = "$basicApiUrl/transports";
  static String createShipping = "$basicApiUrl/shippings/";
  static String pushShipping = "$basicApiUrl/shippings/push";
  static String getShippingRequest = "$basicApiUrl/shippings/user";
  static String getTransports = "$basicApiUrl/transports/user";
  static String pushTransport = "$basicApiUrl/transports/push";


  /// ProEquine Selective Services
  static String getSelectiveService = "$basicApiUrl/selective-services";
  static String joinSelectiveService = "$basicApiUrl/selective-services/join";
  // static String createShipping = "$basicApiUrl/shippings/";


  /// ProEquine Notifications
  static String userNotifications = "$basicApiUrl/notifications/user";
  static String notificationsCount = "$basicApiUrl/notifications/count";


  /// Invoices
  static String userInvoices = "$basicApiUrl/invoices/user";
  static String payInvoiceByWallet = "$basicApiUrl/invoices/pay-using-my-wallet";
  // static String notificationsCount = "$basicApiUrl/notifications/count";
}
