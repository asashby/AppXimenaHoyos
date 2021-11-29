class MPPostDataModel{
  final String payment_method_id, description;
  final int transaction_amount, installments;
  final Payer payer;

  MPPostDataModel({
    required this.transaction_amount,
    required this.payment_method_id,
    required this.description,
    required this.installments,
    required this.payer
  });
}

class Payer{
  final String name, email;
  Payer({
    required this.name,
    required this.email
  });
}