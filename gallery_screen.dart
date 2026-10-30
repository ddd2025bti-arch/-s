import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GalleryItem {
  final String id;
  final String title;
  final String category;
  final String date;
  final String imageUrl;
  final String description;

  const GalleryItem({
    required this.id,
    required this.title,
    required this.category,
    required this.date,
    required this.imageUrl,
    required this.description,
  });
}

class GalleryScreen extends StatefulWidget {
  final bool showBackButton;

  const GalleryScreen({
    super.key,
    this.showBackButton = true,
  });

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String _selectedCategory = 'All Albums';

  final List<String> _categories = [
    'All Albums',
    'Smart Labs',
    'Sports & Athletics',
    'Eco-Club & Greenery',
    'Cultural & Heritage',
    'Campus Infrastructure',
  ];

  final List<GalleryItem> _galleryItems = const [
    GalleryItem(
      id: 'g1',
      title: 'Robotics & STEM Innovation Lab',
      category: 'Smart Labs',
      date: '24 Oct 2026',
      imageUrl: 'https://images.unsplash.com/photo-1581092921461-eab62e97a780?w=600&q=80',
      description: 'Senior students testing automated robotics projects in the newly upgraded government STEM smart facility.',
    ),
    GalleryItem(
      id: 'g2',
      title: 'Annual Athletic Meet 100m Dash',
      category: 'Sports & Athletics',
      date: '18 Oct 2026',
      imageUrl: 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=600&q=80',
      description: 'Inter-house athletic trials on the sprawling Mall Road athletic ground.',
    ),
    GalleryItem(
      id: 'g3',
      title: 'Harit Punjab Tree Plantation',
      category: 'Eco-Club & Greenery',
      date: '12 Oct 2026',
      imageUrl: 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=600&q=80',
      description: 'Principal Sir planting sacred medicinal trees alongside student council representatives.',
    ),
    GalleryItem(
      id: 'g4',
      title: 'State Giddha & Folk Song Team',
      category: 'Cultural & Heritage',
      date: '04 Oct 2026',
      imageUrl: 'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=600&q=80',
      description: 'Our award-winning traditional Punjabi folk dance troupe after securing 1st rank in district youth fest.',
    ),
    GalleryItem(
      id: 'g5',
      title: 'Modern Chemistry Analytical Lab',
      category: 'Smart Labs',
      date: '28 Sep 2026',
      imageUrl: 'https://images.unsplash.com/photo-1532094349884-543bc11b234d?w=600&q=80',
      description: 'Class 12th Medical students performing titration and qualitative salt analysis.',
    ),
    GalleryItem(
      id: 'g6',
      title: 'Heritage Entrance Arches & Campus',
      category: 'Campus Infrastructure',
      date: '15 Sep 2026',
      imageUrl: 'https://images.unsplash.com/photo-1562774053-701939374585?w=600&q=80',
      description: 'Historic architectural arches and lush gardens of SMRISS GGSSS Mall Road Bathinda.',
    ),
  ];

  void _showImagePreview(GalleryItem item) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 240,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item.category,
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
                          ),
                        ),
                        Text(item.date, style: const TextStyle(fontSize: 11, color: AppColors.outline)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      style: const TextStyle(fontFamily: 'Outfit', fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant, height: 1.4),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Downloading high-res photo: ${item.title}')),
                            );
                          },
                          icon: const Icon(Icons.download, size: 16),
                          label: const Text('Download'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedCategory == 'All Albums'
        ? _galleryItems
        : _galleryItems.where((i) => i.category == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: widget.showBackButton,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('School Gallery Wireframe', style: TextStyle(fontFamily: 'Outfit', fontSize: 17, fontWeight: FontWeight.bold)),
            Text('SMRISS GGSSS Mall Road Bathinda', style: TextStyle(fontSize: 11, color: AppColors.outline)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Categories Horizontal Scroll
          Container(
            color: AppColors.surfaceContainerLowest,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = cat == _selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
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
                        cat,
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
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.82,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final item = filtered[index];
                return GestureDetector(
                  onTap: () => _showImagePreview(item),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.outlineVariant),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                item.imageUrl,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.zoom_in, color: Colors.white, size: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.primary),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.category,
                                    style: const TextStyle(fontSize: 10, color: AppColors.secondary, fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    item.date,
                                    style: const TextStyle(fontSize: 9, color: AppColors.outline),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
