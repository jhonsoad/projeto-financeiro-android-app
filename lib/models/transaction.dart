class Transaction {
  final String id;
  final String type;
  final double amount;
  final String date;
  final String? proof;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    this.proof,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      date: json['date'],
      proof: json['proof'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'date': date,
      'proof': proof,
    };
  }
}
