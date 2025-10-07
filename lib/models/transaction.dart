class Transaction {
  final String id;
  final String type;
  final double amount;
  final String date;

  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
  });

  // Métodos para converter para/de JSON (para salvar no shared_preferences)
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'date': date,
    };
  }
}