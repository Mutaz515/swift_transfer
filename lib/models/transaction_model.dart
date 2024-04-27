// Enum to represent transaction types
enum TransactionType {
  debit,
  credit,
}

// Define a model class representing a Transaction
class TransactionModel {
  final num amount;
  final DateTime date;
  final TransactionType type;
  final String title;

  // Constructor
  TransactionModel({
    required this.amount,
    required this.date,
    required this.type,
    required this.title,
  });

  // Factory constructor for creating a Transaction object from a map
  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      type: json['type'] == 'debit'
          ? TransactionType.debit
          : TransactionType.credit,
      title: json['title'],
    );
  }

  // Method to convert Transaction object to a map
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type == TransactionType.debit ? 'debit' : 'credit',
      'title': title,
    };
  }
}
