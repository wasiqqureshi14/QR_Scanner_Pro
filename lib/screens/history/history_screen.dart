
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner_pro/core/theme/app_color.dart';
import 'package:qr_scanner_pro/screens/history/widgets/history_item_card.dart';
import '../../state/history_state.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'All';

  Future<void> _deleteItem(String id) async {
    await context.read<HistoryState>().deleteHistory(id);
  }

  Future<void> _clearAllHistory() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Text(
            'Clear All History?',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to delete all QR history? This action cannot be undone.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text(
                'Clear All',
                style: TextStyle(color: AppColors.error),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      await context.read<HistoryState>().clearHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Scan History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Consumer<HistoryState>(
            builder: (context, historyState, child) {
              if (historyState.history.isEmpty) {
                return const SizedBox.shrink();
              }

              return IconButton(
                onPressed: _clearAllHistory,
                tooltip: 'Clear All',
                icon: const Icon(
                  Icons.delete_sweep_outlined,
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: Consumer<HistoryState>(
          builder: (context, historyState, child) {
            if (historyState.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            final allHistory = historyState.history;

            final filteredHistory = allHistory.where((item) {
              if (_selectedFilter == 'Scanned') {
                return item.type == 'scanned';
              }

              if (_selectedFilter == 'Generated') {
                return item.type == 'generated';
              }

              return true;
            }).toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your QR History',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        '${allHistory.length} QR codes saved',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          _buildFilterButton('All'),
                          const SizedBox(width: 8),
                          _buildFilterButton('Scanned'),
                          const SizedBox(width: 8),
                          _buildFilterButton('Generated'),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: filteredHistory.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          itemCount: filteredHistory.length,
                          itemBuilder: (context, index) {
                            final item = filteredHistory[index];

                            return HistoryItemCard(
                              key: ValueKey(item.id),
                              item: item,
                              onDelete: () {
                                _deleteItem(item.id);
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterButton(String filter) {
    final bool isSelected = _selectedFilter == filter;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = filter;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 11,
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : AppColors.card,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            filter,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: isSelected
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.history,
              size: 75,
              color: AppColors.textSecondary,
            ),

            const SizedBox(height: 15),

            const Text(
              'No History Found',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              _selectedFilter == 'All'
                  ? 'Your scanned and generated QR codes will appear here.'
                  : 'No ${_selectedFilter.toLowerCase()} QR codes found.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
