class PaymentIdStorage {
  static String? paymentId;
}

void savePaymentId(String paymentId) {
  PaymentIdStorage.paymentId = paymentId;
}

String? getPaymentId() {
  return PaymentIdStorage.paymentId;
}