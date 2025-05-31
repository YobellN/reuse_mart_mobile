import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/produk.dart';
import 'package:reuse_mart_mobile/screens/catalogue/detail_produk_page.dart';
import 'package:reuse_mart_mobile/services/product_service.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class KatalogPage extends StatefulWidget {
  const KatalogPage({super.key});

  @override
  State<KatalogPage> createState() => _KatalogPageState();
}

class _KatalogPageState extends State<KatalogPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Semua';

  final List<String> _categories = [
    'Semua',
    'Elektronik & Gadget',
    'Hobi, Mainan, & Koleksi',
    'Kosmetik & Perawatan Diri',
    'Otomotif & Aksesori',
    'Pakaian & Aksesori',
    'Perabotan Rumah Tangga',
    'Peralatan Kantor & Industri',
    'Perlengkapan Bayi & Anak',
    'Perlengkapan Taman & Outdoor',
    'Buku, Alat Tulis, & Peralatan Sekolah',
  ];

  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  List<Produk> _allProducts = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchInitialProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchInitialProducts() async {
    setState(() {
      _isLoadingMore = true;
    });
    try {
      final products = await ProductService.fetchProducts(_currentPage, 6);
      setState(() {
        _allProducts = products;
        _hasMore = products.length == 6;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  Future<void> _fetchMoreProducts() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() {
      _isLoadingMore = true;
    });
    try {
      final nextPage = _currentPage + 1;
      final products = await ProductService.fetchProducts(nextPage, 6);
      setState(() {
        _currentPage = nextPage;
        _allProducts.addAll(products);
        _hasMore = products.length == 6;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _hasMore) {
      _fetchMoreProducts();
    }
  }

  Widget _buildSearchBar() {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        decoration: const InputDecoration(
          hintText: 'Cari produk titipan...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
        style: AppTextStyles.body,
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          return ChoiceChip(
            label: Text(
              category,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? AppColors.primary : Colors.grey.shade300,
                width: 1,
              ),
            ),
            selected: isSelected,
            selectedColor: AppColors.primary,
            backgroundColor: Colors.white,
            onSelected: (_) {
              setState(() {
                _selectedCategory = category;
              });
            },
            elevation: 1,
            pressElevation: 2,
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(List<Produk> filteredProducts) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo is ScrollEndNotification &&
            _scrollController.position.pixels >=
                _scrollController.position.maxScrollExtent - 200) {
          _fetchMoreProducts();
        }
        return false;
      },
      child: GridView.builder(
        controller: _scrollController,
        itemCount: filteredProducts.length + (_isLoadingMore ? 1 : 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          if (index == filteredProducts.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final product = filteredProducts[index];
          final foto =
              product.fotoProduk.isNotEmpty
                  ? product.fotoProduk.first.pathFoto
                  : null;
          return _buildProductCard(product, foto);
        },
      ),
    );
  }

  Widget _buildProductCard(Produk product, String? foto) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProdukPage(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  child:
                      foto != null
                          ? Image.network(
                            '${Api.storageUrl}foto_produk/$foto',
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Image(
                                image: const AssetImage(
                                  'assets/icons/reuse-mart-icon.png',
                                ),
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                            errorBuilder:
                                (context, error, stackTrace) => Image(
                                  image: const AssetImage(
                                    'assets/icons/reuse-mart-icon.png',
                                  ),
                                  height: 140,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                          )
                          : Image.asset(
                            'assets/images/reuse-mart.png',
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                ),
                if (product.waktuGaransi != null)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.success.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 13,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            'Garansi',
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.namaProduk,
                      style: AppTextStyles.bodyBold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatHarga(product.hargaProduk),
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.category, size: 13, color: AppColors.accent),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            product.kategori.namaKategori,
                            style: AppTextStyles.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.person, size: 13, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            product.detailPenitipan.penitipan.penitip.user.nama,
                            style: AppTextStyles.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
  }

  // Future<void> _refreshProducts() async {
  //   setState(() {
  //     _currentPage = 1;
  //     _allProducts.clear();
  //     _hasMore = true;
  //   });
  //   await _fetchInitialProducts();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Katalog Produk',
          style: AppTextStyles.heading3.copyWith(color: AppColors.textInverse),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildCategoryChips(),
            const SizedBox(height: 16),
            Expanded(
              child:
                  _allProducts.isEmpty && _isLoadingMore
                      ? const Center(child: CircularProgressIndicator())
                      : Builder(
                        builder: (context) {
                          final filteredProducts =
                              _allProducts.where((product) {
                                final matchesCategory =
                                    _selectedCategory == 'Semua' ||
                                    product.kategori.namaKategori ==
                                        _selectedCategory;
                                final matchesSearch =
                                    _searchController.text.isEmpty ||
                                    product.namaProduk.toLowerCase().contains(
                                      _searchController.text.toLowerCase(),
                                    );
                                return matchesCategory && matchesSearch;
                              }).toList();
                          if (filteredProducts.isEmpty && !_isLoadingMore) {
                            return Center(
                              child: Text(
                                'Tidak ada produk ditemukan',
                                style: AppTextStyles.subtitle,
                              ),
                            );
                          }
                          return _buildProductGrid(filteredProducts);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
