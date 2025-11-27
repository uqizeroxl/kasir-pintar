class Transaction {
  final int id;
  final String transactionNumber;
  final String customerName;
  final String paymentMethod;
  final double subtotal;
  final double taxAmount;
  final double discountAmount;
  final double totalAmount;
  final double amountPaid;
  final double changeAmount;
  final String status;
  final String notes;
  final DateTime transactionDate;

  Transaction({
    required this.id,
    required this.transactionNumber,
    required this.customerName,
    required this.paymentMethod,
    required this.subtotal,
    required this.taxAmount,
    required this.discountAmount,
    required this.totalAmount,
    required this.amountPaid,
    required this.changeAmount,
    required this.status,
    required this.notes,
    required this.transactionDate,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      transactionNumber: json['transaction_number'],
      customerName: json['customer_name'] ?? 'Walk-in Customer',
      paymentMethod: json['payment_method'] ?? 'Cash',
      subtotal: (json['subtotal'] as num).toDouble(),
      taxAmount: (json['tax_amount'] as num).toDouble(),
      discountAmount: (json['discount_amount'] as num).toDouble(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      amountPaid: (json['amount_paid'] as num).toDouble(),
      changeAmount: (json['change_amount'] as num).toDouble(),
      status: json['status'] ?? 'completed',
      notes: json['notes'] ?? '',
      transactionDate: DateTime.parse(json['transaction_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transaction_number': transactionNumber,
      'customer_name': customerName,
      'payment_method': paymentMethod,
      'subtotal': subtotal,
      'tax_amount': taxAmount,
      'discount_amount': discountAmount,
      'total_amount': totalAmount,
      'amount_paid': amountPaid,
      'change_amount': changeAmount,
      'status': status,
      'notes': notes,
      'transaction_date': transactionDate.toIso8601String(),
    };
  }
}