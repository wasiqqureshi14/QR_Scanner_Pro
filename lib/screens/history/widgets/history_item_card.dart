
import 'package:flutter/material.dart';
import 'package:qr_scanner_pro/core/theme/app_color.dart';
import 'package:qr_scanner_pro/core/utils/helpers.dart';
import 'package:qr_scanner_pro/models/qr_history_model.dart';


class HistoryItemCard extends StatelessWidget {
  final QRHistoryModel item;
  final VoidCallback onDelete;

  const HistoryItemCard({
    super.key,
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bool isScanned = item.type == 'scanned';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: (isScanned
                      ? AppColors.secondary
                      : AppColors.primary)
                  .withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isScanned
                  ? Icons.qr_code_scanner
                  : Icons.qr_code_2,
              color: isScanned
                  ? AppColors.secondary
                  : AppColors.accent,
              size: 25,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 7),

                Row(
                  children: [
                    Text(
                      isScanned ? 'Scanned' : 'Generated',
                      style: TextStyle(
                        color: isScanned
                            ? AppColors.secondary
                            : AppColors.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(width: 10),

                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      '${AppHelpers.formatDate(item.createdAt)}  ${AppHelpers.formatTime(item.createdAt)}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onDelete,
            tooltip: 'Delete',
            icon: const Icon(
              Icons.delete_outline,
              color: AppColors.error,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
