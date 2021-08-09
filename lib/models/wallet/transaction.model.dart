enum TransactionType { DEPOSIT, TRANSFER, CONVERT, WITHDRAW }

class TransactionModel {
  final dynamic transaction;
  final TransactionType transactionType;
  final DateTime createAt;

  TransactionModel({required this.transaction, required this.transactionType, required this.createAt});
}
