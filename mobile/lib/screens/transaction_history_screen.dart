import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  // Sample transaction data - in a real app, this would come from an API
  final List<Transaction> _transactions = [
    Transaction(
      id: 1,
      transactionNumber: 'TXN-001',
      customerName: 'John Doe',
      paymentMethod: 'Cash',
      subtotal: 1259.97,
      taxAmount: 125.99,
      discountAmount: 0.0,
      totalAmount: 1385.96,
      amountPaid: 1400.0,
      changeAmount: 14.04,
      status: 'completed',
      notes: '',
      transactionDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 2,
      transactionNumber: 'TXN-002',
      customerName: 'Jane Smith',
      paymentMethod: 'Credit Card',
      subtotal: 79.99,
      taxAmount: 8.00,
      discountAmount: 0.0,
      totalAmount: 87.99,
      amountPaid: 87.99,
      changeAmount: 0.0,
      status: 'completed',
      notes: '',
      transactionDate: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    Transaction(
      id: 3,
      transactionNumber: 'TXN-003',
      customerName: 'Walk-in Customer',
      paymentMethod: 'Mobile Payment',
      subtotal: 999.99,
      taxAmount: 100.00,
      discountAmount: 0.0,
      totalAmount: 1099.99,
      amountPaid: 1099.99,
      changeAmount: 0.0,
      status: 'completed',
      notes: '',
      transactionDate: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
  ];

  final List<String> _filterOptions = ['All', 'Today', 'This Week', 'This Month'];
  String _selectedFilter = 'All';

  List<Transaction> get _filteredTransactions {
    switch (_selectedFilter) {
      case 'Today':
        return _transactions
            .where((txn) =>
                txn.transactionDate.day == DateTime.now().day &&
                txn.transactionDate.month == DateTime.now().month &&
                txn.transactionDate.year == DateTime.now().year)
            .toList();
      case 'This Week':
        final now = DateTime.now();
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        return _transactions
            .where((txn) =>
                txn.transactionDate.isAfter(startOfWeek) &&
                txn.transactionDate.isBefore(endOfWeek))
            .toList();
      case 'This Month':
        return _transactions
            .where((txn) =>
                txn.transactionDate.month == DateTime.now().month &&
                txn.transactionDate.year == DateTime.now().year)
            .toList();
      default:
        return _transactions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text('Filter:'),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: _filterOptions.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredTransactions.isEmpty
                ? const Center(
                    child: Text(
                      'No transactions found',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = _filteredTransactions[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(
                            transaction.transactionNumber,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(transaction.customerName),
                              const SizedBox(height: 4),
                              Text(
                                '${transaction.transactionDate.day}/${transaction.transactionDate.month}/${transaction.transactionDate.year}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    transaction.paymentMethod,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    '\$${transaction.totalAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: transaction.status == 'completed'
                                  ? Colors.green
                                  : Colors.orange,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              transaction.status,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          onTap: () {
                            _showTransactionDetails(transaction);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showTransactionDetails(Transaction transaction) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transaction Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('Transaction #: ${transaction.transactionNumber}'),
              const SizedBox(height: 8),
              Text('Customer: ${transaction.customerName}'),
              const SizedBox(height: 8),
              Text(
                  'Date: ${transaction.transactionDate.day}/${transaction.transactionDate.month}/${transaction.transactionDate.year}'),
              const SizedBox(height: 8),
              Text('Payment Method: ${transaction.paymentMethod}'),
              const SizedBox(height: 8),
              Text('Status: ${transaction.status}'),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subtotal:'),
                  Text('\$${transaction.subtotal.toStringAsFixed(2)}'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tax:'),
                  Text('\$${transaction.taxAmount.toStringAsFixed(2)}'),
                ],
              ),
              if (transaction.discountAmount > 0) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Discount:'),
                    Text('\$${transaction.discountAmount.toStringAsFixed(2)}'),
                  ],
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${transaction.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Amount Paid:'),
                  Text('\$${transaction.amountPaid.toStringAsFixed(2)}'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Change:'),
                  Text('\$${transaction.changeAmount.toStringAsFixed(2)}'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}