class WalletModel {
  WalletModel({
    this.balance,
    this.balanceAgency,
    this.balanceCommission,
    this.addressWallet,
  });

  int? balance;
  int? balanceAgency;
  int? balanceCommission;
  String? addressWallet;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        balance: json["balance"],
        balanceAgency: json["balance_agency"],
        balanceCommission: json["balance_commission"],
        addressWallet: json["address_wallet"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "balance_agency": balanceAgency,
        "balance_commission": balanceCommission,
        "address_wallet": addressWallet,
      };
}
