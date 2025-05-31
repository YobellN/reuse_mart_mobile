import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/produk.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class DetailProdukPage extends StatefulWidget {
  final Produk product;
  const DetailProdukPage({super.key, required this.product});

  @override
  State<DetailProdukPage> createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  int _currentImage = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentImage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
              // Image carousel
              if (hasImages)
                Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: fotoList.length,
                          onPageChanged:
                              (idx) => setState(() => _currentImage = idx),
                          itemBuilder: (context, idx) {
                            final foto = fotoList[idx].pathFoto;
                            return Image.network(
                              '${Api.storageUrl}foto_produk/$foto',
                              fit: BoxFit.cover,
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
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
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
                )
              else
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/reuse-mart.png',
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              // Product name
              Text(
                widget.product.namaProduk,
                style: AppTextStyles.heading2.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.category, color: AppColors.accent, size: 18),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      widget.product.kategori.namaKategori,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  widget.product.waktuGaransi != null &&
                          widget.product.waktuGaransi!.isNotEmpty
                      ? Container(
                        margin: const EdgeInsets.only(left: 8),
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
                              color: AppColors.success.withOpacity(0.18),
                              blurRadius: 8,
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
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Garansi: ',
                              style: AppTextStyles.caption.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.product.waktuGaransi!,
                              style: AppTextStyles.caption.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                      : Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textSecondary,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.textSecondary.withOpacity(0.18),
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
              const SizedBox(height: 16),
              Text(
                formatHarga(widget.product.hargaProduk),
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              // Description
              Text(
                'Deskripsi Produk',
                style: AppTextStyles.heading3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.product.deskripsiProduk,
                style: AppTextStyles.body,
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 18),
              // Penitip
              Text(
                'Penitip',
                style: AppTextStyles.heading3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                color: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person, color: AppColors.textInverse),
                  ),
                  title: Text(
                    widget.product.detailPenitipan.penitipan.penitip.user.nama,
                    style: AppTextStyles.bodyBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    widget.product.detailPenitipan.penitipan.penitip.user.email,
                    style: AppTextStyles.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
