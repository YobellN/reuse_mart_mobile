import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/merchandise.dart';
import 'package:reuse_mart_mobile/screens/catalogue/skeleton_image.dart';
import 'package:reuse_mart_mobile/services/merch_service.dart';
import 'package:reuse_mart_mobile/utils/api.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

class KatalogMerchPage extends StatefulWidget {
  const KatalogMerchPage({super.key});

  @override
  State<KatalogMerchPage> createState() => _KatalogMerchPageState();
}

class _KatalogMerchPageState extends State<KatalogMerchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Merchandise> _listMerch = [];
  List<Merchandise> _filteredMerch = [];
  bool _isLoading = true;
  bool _loadingKlaim = false;

  @override
  void initState() {
    super.initState();
    _fetchMerchandise();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredMerch = _listMerch;
      } else {
        _filteredMerch =
            _listMerch
                .where(
                  (merch) =>
                      merch.namaMerchandise.toLowerCase().contains(query),
                )
                .toList();
      }
    });
  }

  Future<void> _fetchMerchandise() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final prefs = await SharedPreferences.getInstance();
      final merch = prefs.getString('cached_merchandise');
      if (merch != null) {
        setState(() {
          _listMerch =
              (json.decode(merch) as List)
                  .map((e) => Merchandise.fromJson(e))
                  .toList();
          _filteredMerch = _listMerch;
          _isLoading = false;
        });
      }

      final freshMerch = await MerchService.fetchMerchandise();
      if (!mounted) return;
      setState(() {
        _listMerch = freshMerch;
        _filteredMerch = freshMerch;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildMerchGrid(List<Merchandise> merch) {
    return GridView.builder(
      itemCount: merch.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        final merchandise = merch[index];
        return _buildMerchCard(merchandise);
      },
    );
  }

  Widget _buildMerchCard(Merchandise merchandise) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement detail navigation
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(14),
              ),
              child: SkeletonImage(
                imageUrl:
                    '${Api.storageUrl}foto_merchandise/${merchandise.fotoMerchandise}',
                width: double.infinity,
                height: 140,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    merchandise.namaMerchandise,
                    style: AppTextStyles.bodyBold.copyWith(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.card_giftcard,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${merchandise.poinPenukaran} Poin',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.inventory_2_rounded,
                        size: 15,
                        color: AppColors.accent,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Stok: ${merchandise.stok}',
                        style: AppTextStyles.caption.copyWith(fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          _loadingKlaim
                              ? null
                              : () {
                                showDialog<bool>(
                                  context: context,
                                  builder:
                                      (context) =>
                                          _buildConfirmationDialog(merchandise),
                                );
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _loadingKlaim
                                ? AppColors.disabled
                                : AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        textStyle: AppTextStyles.bodyBold.copyWith(
                          color: Colors.white,
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Klaim'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMerchGridSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.6,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 80, height: 16, color: Colors.white),
                        const SizedBox(height: 4),
                        Container(width: 60, height: 14, color: Colors.white),
                        const SizedBox(height: 4),
                        Container(width: 80, height: 12, color: Colors.white),
                        const SizedBox(height: 2),
                        Container(width: 80, height: 12, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          hintText: 'Cari merchandise...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
        style: AppTextStyles.body,
      ),
    );
  }

  Widget _buildConfirmationDialog(Merchandise merchandise) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          Icon(Icons.help_outline, color: AppColors.primary),
          const SizedBox(width: 8),
          Text('Konfirmasi Klaim', style: AppTextStyles.heading3),
        ],
      ),
      content: Text(
        'Apakah Anda yakin ingin klaim merchandise ini? (${merchandise.namaMerchandise})',
        style: AppTextStyles.body,
      ),

      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textSecondary,
            textStyle: AppTextStyles.body,
          ),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context, true);
            setState(() {
              _loadingKlaim = true;
            });
            final response = await MerchService.klaimMerchandise(
              merchandise.idMerchandise,
            );
            if (response != '') {
              setState(() {
                _loadingKlaim = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    response,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textInverse,
                    ),
                  ),
                  backgroundColor:
                      response.contains('Berhasil') == true
                          ? AppColors.primary
                          : AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                ),
              );
              response.contains('Berhasil') == true
                  ? await _fetchMerchandise()
                  : null;
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            textStyle: AppTextStyles.bodyBold.copyWith(color: Colors.white),
            elevation: 0,
          ),
          child: const Text('Klaim'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Katalog Merchandise',
          style: AppTextStyles.heading3.copyWith(color: AppColors.textInverse),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _fetchMerchandise,
                child: Builder(
                  builder: (context) {
                    if (_isLoading) {
                      return _buildMerchGridSkeleton();
                    }
                    if (_filteredMerch.isEmpty) {
                      return ListView(
                        children: [
                          SizedBox(
                            height: 300,
                            child: Center(
                              child: Text('Tidak ada merchandise.'),
                            ),
                          ),
                        ],
                      );
                    }
                    return _buildMerchGrid(_filteredMerch);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
