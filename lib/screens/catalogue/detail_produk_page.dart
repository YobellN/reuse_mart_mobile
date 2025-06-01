import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/penitip.dart';
import 'package:reuse_mart_mobile/models/produk.dart';
import 'package:reuse_mart_mobile/services/product_service.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DetailProdukPage extends StatefulWidget {
  final Produk product;
  const DetailProdukPage({super.key, required this.product});

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  int _currentImage = 0;
  late final PageController _pageController;
  bool _showFullDesc = false;
  bool _isImageDialogOpen = false;

  List<Produk> _produkLain = [];
  bool _isLoadingProdukLain = false;

  Penitip? penitip;
  bool _isLoadingPenitip = true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentImage);
    _fetchPenitip();
    _fetchProdukLainPenitip();
  }

  Future<void> _fetchProdukLainPenitip() async {
    setState(() {
      _isLoadingProdukLain = true;
    });
    try {
      final penitipId =
          widget.product.detailPenitipan.penitipan.penitip.idPenitip;
      final produkList = await ProductService.fetchProductsPenitip(penitipId);
      // Exclude current product
      _produkLain =
          produkList
              .where((p) => p.idProduk != widget.product.idProduk)
              .toList();
    } catch (e) {
      _produkLain = [];
    }
    setState(() {
      _isLoadingProdukLain = false;
    });
  }

  Future<void> _fetchPenitip() async {
    setState(() {
      _isLoadingPenitip = true;
    });
    try {
      penitip = await ProductService.fetchPenitipById(
        widget.product.detailPenitipan.penitipan.penitip.idPenitip,
      );
    } catch (e) {
      penitip = null;
    }
    setState(() {
      _isLoadingPenitip = false;
    });
  }

  void _showImageDialog(String imageUrl) {
    if (_isImageDialogOpen) return;
    _isImageDialogOpen = true;
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(12),
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: AppColors.surface,
                      height: 300,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        color: AppColors.disabled,
                        height: 300,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            color: AppColors.textInverse,
                            size: 60,
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ),
    ).then((_) => _isImageDialogOpen = false);
  }

  Widget _buildImageCarousel(List fotoList, bool hasImages) {
    if (hasImages) {
      return Column(
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: GestureDetector(
              onTap:
                  () => _showImageDialog(
                    '${Api.storageUrl}foto_produk/${fotoList[_currentImage].pathFoto}',
                  ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: fotoList.length,
                  onPageChanged: (idx) => setState(() => _currentImage = idx),
                  itemBuilder: (context, idx) {
                    final foto = fotoList[idx].pathFoto;
                    return Image.network(
                      '${Api.storageUrl}foto_produk/$foto',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: AppColors.surface,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            color: AppColors.disabled,
                            child: const Icon(
                              Icons.broken_image,
                              color: AppColors.textInverse,
                              size: 60,
                            ),
                          ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Carousel indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              fotoList.length,
              (idx) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: _currentImage == idx ? 18 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color:
                      _currentImage == idx
                          ? AppColors.primary
                          : AppColors.disabled,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Thumbnails
          if (fotoList.length > 1)
            SizedBox(
              height: 56,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: fotoList.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, idx) {
                  final foto = fotoList[idx].pathFoto;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _currentImage = idx);
                      _pageController.animateToPage(
                        idx,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              _currentImage == idx
                                  ? AppColors.primary
                                  : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          '${Api.storageUrl}foto_produk/$foto',
                          height: 56,
                          width: 56,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: AppColors.surface,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                height: 56,
                                width: 56,
                                color: AppColors.disabled,
                                child: const Icon(
                                  Icons.broken_image,
                                  color: AppColors.textInverse,
                                  size: 24,
                                ),
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      );
    } else {
      // Better placeholder if no image
      return Center(
        child: Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.disabled, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_not_supported,
                color: AppColors.disabled,
                size: 60,
              ),
              const SizedBox(height: 8),
              Text(
                'Tidak ada gambar',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.disabled,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildProductInfo() {
    final produk = widget.product;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              formatHarga(produk.hargaProduk),
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          produk.namaProduk,
          style: AppTextStyles.heading2.copyWith(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.category, color: AppColors.accent, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                produk.kategori.namaKategori,
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            produk.waktuGaransi != null && produk.waktuGaransi!.isNotEmpty
                ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.success, AppColors.primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color.alphaBlend(
                          AppColors.success.withAlpha(46),
                          Colors.transparent,
                        ), // 0.18*255 ≈ 46
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.verified, color: Colors.white, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'Garansi: ',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formatTanggal(produk.waktuGaransi!),
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
                : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textSecondary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Color.alphaBlend(
                          AppColors.textSecondary.withAlpha(46),
                          Colors.transparent,
                        ), // 0.18*255 ≈ 46
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Tidak Bergaransi',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),

        // Price
      ],
    );
  }

  Widget _buildDescription() {
    final produk = widget.product;
    final isLong = produk.deskripsiProduk.length > 180;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deskripsi Produk',
          style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          _showFullDesc || !isLong
              ? produk.deskripsiProduk
              : produk.deskripsiProduk.substring(0, 120) + '...',
          style: AppTextStyles.body,
          maxLines: _showFullDesc ? 20 : 5,
          overflow: TextOverflow.ellipsis,
        ),
        if (isLong)
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: TextButton(
              onPressed: () => setState(() => _showFullDesc = !_showFullDesc),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                textStyle: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                alignment: Alignment.centerLeft,
              ),
              child: Text(
                _showFullDesc ? 'Lihat lebih sedikit' : 'Lihat selengkapnya',
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPenitipInfo(Penitip penitip) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Penitip',
          style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          color: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, color: AppColors.textInverse),
            ),
            title: Text(
              penitip.user.nama,
              style: AppTextStyles.bodyBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Rating:',
                      style: AppTextStyles.body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 2),
                    Text(
                      penitip.rating != null ? '${penitip.rating}/5' : '-',
                      style: AppTextStyles.body,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPenitipSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Penitip', style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            color: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person, color: AppColors.textInverse),
              ),
              title: Container(width: 80, height: 16, color: Colors.white),
              subtitle: Container(width: 60, height: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProdukLainPenitipSection() {
    if (_isLoadingProdukLain) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_produkLain.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          'Produk lain dari Penitip',
          style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _produkLain.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = _produkLain[index];
              final foto =
                  product.fotoProduk.isNotEmpty
                      ? product.fotoProduk.first.pathFoto
                      : null;
              return SizedBox(
                width: 180,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DetailProdukPage(product: product),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          child:
                              foto != null
                                  ? Image.network(
                                    '${Api.storageUrl}foto_produk/$foto',
                                    height: 110,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                              'assets/images/reuse-mart.png',
                                              height: 110,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                  )
                                  : Image.asset(
                                    'assets/images/reuse-mart.png',
                                    height: 110,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.namaProduk,
                                style: AppTextStyles.bodyBold,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
                                  Icon(
                                    Icons.category,
                                    size: 13,
                                    color: AppColors.accent,
                                  ),
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
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    size: 13,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      product
                                          .detailPenitipan
                                          .penitipan
                                          .penitip
                                          .user
                                          .nama,
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
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProdukLainPenitipSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text('Produk lain dari Penitip', style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 240,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 180,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 110,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: 100, height: 16, color: Colors.white),
                              const SizedBox(height: 4),
                              Container(width: 60, height: 14, color: Colors.white),
                              const SizedBox(height: 4),
                              Container(width: 80, height: 12, color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    final fotoList = widget.product.fotoProduk;
    final hasImages = fotoList.isNotEmpty;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          widget.product.namaProduk,
          style: AppTextStyles.heading3.copyWith(
            color: AppColors.textInverse,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageCarousel(fotoList, hasImages),
              const SizedBox(height: 16),
              _buildProductInfo(),
              const SizedBox(height: 16),
              _buildDescription(),
              const SizedBox(height: 16),
              if (_isLoadingPenitip)
                _buildPenitipSkeleton()
              else if (penitip != null)
                _buildPenitipInfo(penitip!)
              else
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Gagal memuat data penitip',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              if (!_isLoadingPenitip && _isLoadingProdukLain)
                _buildProdukLainPenitipSkeleton()
              else if (!_isLoadingPenitip)
                _buildProdukLainPenitipSection(),
            ],
          ),
        ),
      ),
    );
  }
}
