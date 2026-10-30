import 'package:flutter/material.dart';
import '../models/notice.dart';
import '../services/school_data_service.dart';
import '../theme/app_colors.dart';

class NoticesScreen extends StatefulWidget {
  const NoticesScreen({super.key});

  @override
  State<NoticesScreen> createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Exam', 'General', 'Sports', 'Academic'];

  @override
  Widget build(BuildContext context) {
    final notices = SchoolDataService().getNotices();
    final filtered = _selectedFilter == 'All'
        ? notices
        : notices.where((n) => n.category == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Official Notices & Circulars', style: TextStyle(fontFamily: 'Outfit', fontSize: 17, fontWeight: FontWeight.bold)),
            Text('SMRISS GGSSS Mall Road Bathinda', style: TextStyle(fontSize: 11, color: AppColors.outline)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            color: AppColors.surfaceContainerLowest,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final f = _filters[index];
                  final isSelected = f == _selectedFilter;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = f),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryContainer : AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(
                          color: isSelected ? AppColors.primaryContainer : AppColors.outlineVariant,
                        ),
                      ),
                      child: Text(
                        f,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final notice = filtered[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                    border: Border(
                      left: BorderSide(
                        color: notice.isUrgent ? AppColors.secondary : AppColors.tertiary,
                        width: 4,
                      ),
                      top: const BorderSide(color: AppColors.outlineVariant),
                      right: const BorderSide(color: AppColors.outlineVariant),
                      bottom: const BorderSide(color: AppColors.outlineVariant),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: notice.isUrgent ? AppColors.secondary.withOpacity(0.1) : AppColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              notice.isUrgent ? 'URGENT CIRCULAR' : notice.category.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: notice.isUrgent ? AppColors.secondary : AppColors.primary,
                              ),
                            ),
                          ),
                          Text(
                            notice.date,
                            style: const TextStyle(fontSize: 11, color: AppColors.outline, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notice.title,
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notice.description,
                        style: const TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant, height: 1.4),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Downloading official PDF for "${notice.title}"')),
                              );
                            },
                            icon: const Icon(Icons.download, size: 16),
                            label: const Text('Download Circular (PDF)', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
