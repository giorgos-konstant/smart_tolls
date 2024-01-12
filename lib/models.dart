//import 'dart:convert';

class User {
  final bool isAuth;
  final int userId;
  final String username;
  final String email;
  final String licensePlate;
  final double balance;
  final List<Transaction> transactions;

  User({
    required this.isAuth,
    required this.userId,
    required this.username,
    required this.email,
    required this.licensePlate,
    required this.balance,
    required this.transactions,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    int userId = json['userId'];
    List<Transaction> userTransactions = (json['transactions'] as List)
        .map((transactionJson) => Transaction.fromJson(transactionJson, userId))
        .toList();

    return User(
      isAuth: json['isAuth'],
      userId: userId,
      username: json['username'],
      email: json['email'],
      licensePlate: json['licensePlate'],
      balance: json['balance'],
      transactions: userTransactions,
    );
  }
}

class ChargePolicy {
  final double aktiDymaion1;
  final double aktiDymaion2;
  final double aktiDymaion3;
  final double aktiDymaion4;

  final double perivola1;
  final double perivola2;
  final double perivola3;
  final double perivola4;

  final double tei1;
  final double tei2;
  final double tei3;
  final double tei4;

  final double rio1;
  final double rio2;
  final double rio3;
  final double rio4;

  final double konpoleos1;
  final double konpoleos2;
  final double konpoleos3;
  final double konpoleos4;

  final double agandreou1;
  final double agandreou2;
  final double agandreou3;
  final double agandreou4;

  final double germanou1;
  final double germanou2;
  final double germanou3;
  final double germanou4;

  final double othamal1;
  final double othamal2;
  final double othamal3;
  final double othamal4;

  ChargePolicy({
    required this.aktiDymaion1,
    required this.aktiDymaion2,
    required this.aktiDymaion3,
    required this.aktiDymaion4,
    required this.perivola1,
    required this.perivola2,
    required this.perivola3,
    required this.perivola4,
    required this.tei1,
    required this.tei2,
    required this.tei3,
    required this.tei4,
    required this.rio1,
    required this.rio2,
    required this.rio3,
    required this.rio4,
    required this.konpoleos1,
    required this.konpoleos2,
    required this.konpoleos3,
    required this.konpoleos4,
    required this.agandreou1,
    required this.agandreou2,
    required this.agandreou3,
    required this.agandreou4,
    required this.germanou1,
    required this.germanou2,
    required this.germanou3,
    required this.germanou4,
    required this.othamal1,
    required this.othamal2,
    required this.othamal3,
    required this.othamal4,
  });

  factory ChargePolicy.fromJson(Map<String, dynamic> json) {
    return ChargePolicy(
      aktiDymaion1: json['aktiDymaion1'],
      aktiDymaion2: json['aktiDymaion2'],
      aktiDymaion3: json['aktiDymaion3'],
      aktiDymaion4: json['aktiDymaion4'],
      perivola1: json['perivola1'],
      perivola2: json['perivola2'],
      perivola3: json['perivola3'],
      perivola4: json['perivola4'],
      tei1: json['tei1'],
      tei2: json['tei2'],
      tei3: json['tei3'],
      tei4: json['tei4'],
      rio1: json['rio1'],
      rio2: json['rio2'],
      rio3: json['rio3'],
      rio4: json['rio4'],
      konpoleos1: json['konpoleos1'],
      konpoleos2: json['konpoleos2'],
      konpoleos3: json['konpoleos3'],
      konpoleos4: json['konpoleos4'],
      agandreou1: json['agandreou1'],
      agandreou2: json['agandreou2'],
      agandreou3: json['agandreou3'],
      agandreou4: json['agandreou4'],
      germanou1: json['germanou1'],
      germanou2: json['germanou2'],
      germanou3: json['germanou3'],
      germanou4: json['germanou4'],
      othamal1: json['othamal1'],
      othamal2: json['othamal2'],
      othamal3: json['othamal3'],
      othamal4: json['othamal4'],
    );
  }
}

class Transaction {
  final int userId;
  final String zone;
  final String tollName;
  final DateTime timeStamp;
  final double chargeAmount;

  Transaction({
    required this.userId,
    required this.zone,
    required this.tollName,
    required this.timeStamp,
    required this.chargeAmount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json, int userId) {
    return Transaction(
      userId: userId,
      zone: json['zone'],
      tollName: json['tollName'],
      timeStamp: json['timeStamp'],
      chargeAmount: json['charge'],
    );
  }
}

class TransactionHistory {
  final int userId;
  final List<Transaction> transactions;

  TransactionHistory({
    required this.userId,
    required this.transactions,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) {
    int userId = json['usedId'];

    List<Transaction> userTransactions = (json['transactions'] as List)
        .map((transactionJson) => Transaction.fromJson(transactionJson, userId))
        .toList();

    return TransactionHistory(
      userId: userId,
      transactions: userTransactions,
    );
  }
}
