import 'package:cloud_firestore/cloud_firestore.dart'
    hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

const double initialBaseBalance = 2500.00;

class TransactionProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Transaction> _transactions = [];
  double _balance = initialBaseBalance;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;

  List<Transaction> get transactions => _transactions;
  double get balance => _balance;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  DocumentSnapshot? get lastDocument => _lastDocument;

  void _calculateTotalBalance() {
    final total = _transactions.fold(
      initialBaseBalance,
      (sum, item) => sum + item.amount,
    );
    _balance = total;
  }

  Future<void> loadTransactions({
    String? category,
    DateTime? date,
  }) async {
    final user = _auth.currentUser;
    if (user == null || _isLoading) return;

    _isLoading = true;
    _hasMore = true;
    _transactions.clear();
    _lastDocument = null;
    notifyListeners();

    Query query = _firestore
        .collection('transactions')
        .where('userId', isEqualTo: user.uid)
        .orderBy('id', descending: true);

    if (category != null) {
      query = query.where('type', isEqualTo: category);
    }
    if (date != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(date);
      query = query.where('date', isEqualTo: formattedDate);
    }

    final snapshot = await query.limit(10).get();
    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
    }

    _transactions = snapshot.docs
        .map(
          (doc) => Transaction.fromJson(
            doc.data() as Map<String, dynamic>,
          ),
        )
        .toList();

    _calculateTotalBalance();
    _isLoading = false;
    if (_transactions.length < 10) {
      _hasMore = false;
    }
    notifyListeners();
  }

  Future<void> loadMoreTransactions({
    String? category,
    DateTime? date,
  }) async {
    final user = _auth.currentUser;
    if (user == null || _isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    notifyListeners();

    Query query = _firestore
        .collection('transactions')
        .where('userId', isEqualTo: user.uid)
        .orderBy('id', descending: true);

    if (category != null) {
      query = query.where('type', isEqualTo: category);
    }
    if (date != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(date);
      query = query.where('date', isEqualTo: formattedDate);
    }

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    final snapshot = await query.limit(10).get();
    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
    }

    final newTransactions = snapshot.docs
        .map(
          (doc) => Transaction.fromJson(
            doc.data() as Map<String, dynamic>,
          ),
        )
        .toList();

    _transactions.addAll(newTransactions);
    _calculateTotalBalance();

    if (newTransactions.length < 10) {
      _hasMore = false;
    }

    _isLoadingMore = false;
    notifyListeners();
  }

  Future<void> addTransaction(
    String type,
    double amount,
    String? proof,
  ) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final newTransaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      amount: amount,
      date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
      proof: proof,
      userId: user.uid,
    );

    await _firestore
        .collection('transactions')
        .doc(newTransaction.id)
        .set(newTransaction.toJson());

    _transactions.insert(0, newTransaction);
    _calculateTotalBalance();
    notifyListeners();
  }

  Future<void> deleteTransaction(String id) async {
    await _firestore.collection('transactions').doc(id).delete();
    _transactions.removeWhere((tx) => tx.id == id);
    _calculateTotalBalance();
    notifyListeners();
  }

  Future<void> editTransaction(Transaction updatedTransaction) async {
    await _firestore
        .collection('transactions')
        .doc(updatedTransaction.id)
        .update(updatedTransaction.toJson());

    final index = _transactions.indexWhere(
      (tx) => tx.id == updatedTransaction.id,
    );
    if (index != -1) {
      _transactions[index] = updatedTransaction;
    }
    _calculateTotalBalance();
    notifyListeners();
  }
}
