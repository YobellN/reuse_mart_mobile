import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class CataloguePage extends StatefulWidget {
  const CataloguePage({super.key});

  @override
  State<CataloguePage> createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Semua';
  final List<String> _categories = [
    'Semua',
    'Elektronik',
    'Fashion',
    'Rumah Tangga',
    'Buku',
    'Lainnya'
  ];

  // Dummy product data
  final List<Map<String, String>> _products = [
    {
      'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
      'name': 'Kamera Canon',
      'category': 'Elektronik',
      'penitip': 'Budi',
    },
    {
      'image': 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f',
      'name': 'Jaket Kulit',
      'category': 'Fashion',
      'penitip': 'Siti',
    },
    {
      'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      'name': 'Setrika Philips',
      'category': 'Rumah Tangga',
      'penitip': 'Andi',
    },
    {
      'image': 'https://images.unsplash.com/photo-1516979187457-637abb4f9353',
      'name': 'Novel Laskar Pelangi',
      'category': 'Buku',
      'penitip': 'Dewi',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter products by search and category
    final filteredProducts = _products.where((product) {
      final matchesCategory = _selectedCategory == 'Semua' || product['category'] == _selectedCategory;
      final matchesSearch = _searchController.text.isEmpty ||
        product['name']!.toLowerCase().contains(_searchController.text.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Katalog', style: AppTextStyles.heading2),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textInverse),
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Cari produk titipan...',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
                style: AppTextStyles.body,
              ),
            ),
            const SizedBox(height: 16),
            // Horizontal category slider
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;
                  return ChoiceChip(
                    label: Text(category, style: isSelected ? AppTextStyles.bodyBold.copyWith(color: AppColors.textInverse) : AppTextStyles.body),
                    selected: isSelected,
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    onSelected: (_) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            // Product list
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(child: Text('Tidak ada produk ditemukan', style: AppTextStyles.subtitle))
                  : ListView.separated(
                      itemCount: filteredProducts.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product image
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    product['image']!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      width: 100,
                                      height: 100,
                                      color: AppColors.disabled,
                                      child: const Icon(Icons.broken_image, color: AppColors.textInverse),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(product['name']!, style: AppTextStyles.heading3),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(Icons.category, size: 16, color: AppColors.accent),
                                            const SizedBox(width: 4),
                                            Text(product['category']!, style: AppTextStyles.caption),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(Icons.person, size: 16, color: AppColors.primary),
                                            const SizedBox(width: 4),
                                            Text('Penitip: ${product['penitip']}', style: AppTextStyles.caption),
                                          ],
                                        ),
                                      ],
                                    ),
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
      ),
    );
  }
}