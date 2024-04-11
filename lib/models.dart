class User {
  final String userId;
  final String username;
  final String email;
  final String licensePlate;
  late final double balance;
  final String deviceId;
  final List<Transaction> transactions;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.licensePlate,
    required this.balance,
    required this.deviceId,
    required this.transactions,
  });

  User.fromJson(Map<String, dynamic> json)
      : userId = json['_id'] as String,
        username = json['username'] as String,
        email = json['email'] as String,
        licensePlate = json['licensePlate'] as String,
        balance = json['balance'] as double,
        deviceId = json['device']['deviceId'] as String,
        transactions = json['transactions']
            .map<Transaction>((item) => Transaction.fromJson(item))
            .toList();
}

class ChargePolicy {
  final List<ZonePolicy> zonePolicies;

  ChargePolicy({
    required this.zonePolicies,
  });

  ChargePolicy.fromJson(List<dynamic> json)
      : zonePolicies =
            json.map((zoneJson) => ZonePolicy.fromJson(zoneJson)).toList();
}

class ZonePolicy {
  final String zone;
  final List<Region> regions;

  ZonePolicy({
    required this.zone,
    required this.regions,
  });

  ZonePolicy.fromJson(Map<String, dynamic> json)
      : zone = json['zone'],
        regions = json['regions']
            .map<Region>((item) => Region.fromJson(item))
            .toList();
}

class Region {
  final String name;
  final Prices prices;

  Region({
    required this.name,
    required this.prices,
  });

  Region.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        prices = Prices.fromJson(json['prices']);
}

class Prices {
  final double timeZone1;
  final double timeZone2;
  final double timeZone3;
  final double timeZone4;

  Prices({
    required this.timeZone1,
    required this.timeZone2,
    required this.timeZone3,
    required this.timeZone4,
  });

  Prices.fromJson(Map<String, dynamic> json)
      : timeZone1 = json['08-12'] as double,
        timeZone2 = json['12-17'] as double,
        timeZone3 = json['17-20'] as double,
        timeZone4 = json['20-22'] as double;
}

class Transaction {
  final String userId;
  final String zone;
  final String tollName;
  final String timeStamp;
  final double chargeAmount;

  Transaction({
    required this.userId,
    required this.zone,
    required this.tollName,
    required this.timeStamp,
    required this.chargeAmount,
  });

  Transaction.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as String,
        zone = json['zone'] as String,
        tollName = json['tollName'] as String,
        timeStamp = json['timeStamp'] as String,
        chargeAmount = json['chargeAmount'] as double;
}
