import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/service_request.dart';

class ServiceRequestTransactionsWidget extends StatelessWidget {
  final List<ServiceRequestTransaction> transactions;
  final String currency;

  const ServiceRequestTransactionsWidget({
    super.key,
    required this.transactions,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    if (transactions.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 64,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                'No Transactions',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Transaction history will appear here',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Payment Summary
        _buildPaymentSummary(context),
        const SizedBox(height: 16),
        
        // Transaction History
        _buildTransactionHistory(context),
      ],
    );
  }

  Widget _buildPaymentSummary(BuildContext context) {
    final theme = Theme.of(context);
    
    final totalPaid = transactions
        .where((t) => t.type == TransactionType.payment && 
                     t.status == TransactionStatus.completed)
        .fold(0.0, (sum, t) => sum + t.amount);
    
    final totalRefunded = transactions
        .where((t) => t.type == TransactionType.refund && 
                     t.status == TransactionStatus.completed)
        .fold(0.0, (sum, t) => sum + t.amount);
    
    final pendingAmount = transactions
        .where((t) => t.status == TransactionStatus.pending)
        .fold(0.0, (sum, t) => sum + t.amount);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Payment Summary',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    'Total Paid',
                    totalPaid,
                    currency,
                    Colors.green,
                    Icons.arrow_downward,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    'Refunded',
                    totalRefunded,
                    currency,
                    Colors.orange,
                    Icons.undo,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    'Pending',
                    pendingAmount,
                    currency,
                    Colors.blue,
                    Icons.schedule,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String label,
    double amount,
    String currency,
    Color color,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            NumberFormat.currency(symbol: currency).format(amount),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionHistory(BuildContext context) {
    final theme = Theme.of(context);
    final sortedTransactions = List<ServiceRequestTransaction>.from(transactions)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.history,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Transaction History',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${transactions.length} transactions',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedTransactions.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final transaction = sortedTransactions[index];
              return _buildTransactionItem(context, transaction);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    BuildContext context, 
    ServiceRequestTransaction transaction,
  ) {
    final theme = Theme.of(context);
    final isPositive = transaction.type.isPositive;
    final amountColor = isPositive ? Colors.green : Colors.red;

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getTransactionColor(transaction.type).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          _getTransactionIcon(transaction.type),
          color: _getTransactionColor(transaction.type),
          size: 20,
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              transaction.type.displayName,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '${isPositive ? '+' : '-'}${NumberFormat.currency(symbol: currency).format(transaction.amount.abs())}',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: amountColor,
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              _buildStatusChip(transaction.status),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  DateFormat('MMM d, y h:mm a').format(transaction.createdAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
            ],
          ),
          if (transaction.description != null) ...[
            const SizedBox(height: 4),
            Text(
              transaction.description!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        onSelected: (value) => _handleMenuAction(context, value, transaction),
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'details',
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('View Details'),
              dense: true,
            ),
          ),
          if (transaction.type == TransactionType.payment && 
              transaction.status == TransactionStatus.completed)
            const PopupMenuItem(
              value: 'refund',
              child: ListTile(
                leading: Icon(Icons.undo),
                title: Text('Process Refund'),
                dense: true,
              ),
            ),
          const PopupMenuItem(
            value: 'receipt',
            child: ListTile(
              leading: Icon(Icons.receipt),
              title: Text('Download Receipt'),
              dense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(TransactionStatus status) {
    Color color;
    switch (status) {
      case TransactionStatus.completed:
        color = Colors.green;
        break;
      case TransactionStatus.pending:
        color = Colors.orange;
        break;
      case TransactionStatus.processing:
        color = Colors.blue;
        break;
      case TransactionStatus.failed:
        color = Colors.red;
        break;
      case TransactionStatus.cancelled:
        color = Colors.grey;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Color _getTransactionColor(TransactionType type) {
    switch (type) {
      case TransactionType.payment:
        return Colors.green;
      case TransactionType.escrow:
        return Colors.blue;
      case TransactionType.release:
        return Colors.purple;
      case TransactionType.refund:
        return Colors.orange;
      case TransactionType.fee:
        return Colors.red;
    }
  }

  IconData _getTransactionIcon(TransactionType type) {
    switch (type) {
      case TransactionType.payment:
        return Icons.payment;
      case TransactionType.escrow:
        return Icons.security;
      case TransactionType.release:
        return Icons.lock_open;
      case TransactionType.refund:
        return Icons.undo;
      case TransactionType.fee:
        return Icons.receipt_long;
    }
  }

  void _handleMenuAction(
    BuildContext context, 
    String action, 
    ServiceRequestTransaction transaction,
  ) {
    switch (action) {
      case 'details':
        _showTransactionDetails(context, transaction);
        break;
      case 'refund':
        _showRefundDialog(context, transaction);
        break;
      case 'receipt':
        _downloadReceipt(context, transaction);
        break;
    }
  }

  void _showTransactionDetails(
    BuildContext context, 
    ServiceRequestTransaction transaction,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Transaction Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ID', transaction.id),
            _buildDetailRow('Type', transaction.type.displayName),
            _buildDetailRow('Amount', NumberFormat.currency(symbol: currency).format(transaction.amount)),
            _buildDetailRow('Status', transaction.status.displayName),
            if (transaction.description != null)
              _buildDetailRow('Description', transaction.description!),
            _buildDetailRow('Date', DateFormat('MMM d, y h:mm a').format(transaction.createdAt)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showRefundDialog(BuildContext context, ServiceRequestTransaction transaction) {
    final refundController = TextEditingController(
      text: transaction.amount.toString(),
    );
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Process Refund'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: refundController,
              decoration: InputDecoration(
                labelText: 'Refund Amount ($currency)',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason for Refund',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement refund logic
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Refund processed successfully')),
              );
            },
            child: const Text('Process Refund'),
          ),
        ],
      ),
    );
  }

  void _downloadReceipt(BuildContext context, ServiceRequestTransaction transaction) {
    // TODO: Implement receipt download
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Receipt downloaded successfully')),
    );
  }
}
