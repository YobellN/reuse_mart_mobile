import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/produk_hunter.dart';
import 'package:reuse_mart_mobile/screens/riwayat_komisi_hunter/card_riwayat_komisi.dart';
import 'package:reuse_mart_mobile/services/hunter_service.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RiwayatKomisiPage extends StatefulWidget {
  final String initialStatus;
  const RiwayatKomisiPage({super.key, this.initialStatus = 'Semua'});

  @override
  State<RiwayatKomisiPage> createState() => _RiwayatKomisiPageState();
}

class _RiwayatKomisiPageState extends State<RiwayatKomisiPage> {
  List<ProdukHunter>? _listProdukHunting;
  bool _isLoading = true;
  final List<String> _statusList = ['Semua', 'Selesai', 'Menunggu', 'Batal'];

  final ScrollController _statusScrollController = ScrollController();

  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.initialStatus;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = _statusList.indexOf(_selectedStatus);
      if (index != -1) {
        final itemWidth = 100.0;
        final scrollTo =
            (itemWidth * index) -
            MediaQuery.of(context).size.width / 2 +
            itemWidth / 2;
        // CEK: controller sudah attach ke posisi
        if (_statusScrollController.hasClients) {
          _statusScrollController.animateTo(
            scrollTo.clamp(
              0.0,
              _statusScrollController.position.maxScrollExtent,
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
    _fetchBarangkHunting(status: _selectedStatus);
  }

  Future<void> _fetchBarangkHunting({String? status}) async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final cachedProduk = prefs.getString('cached_riwayat_barang_hunting${'_$status'}');
    if (cachedProduk != null) {
      final data = json.decode(cachedProduk) as List;
      setState(() {
        _listProdukHunting = data.map((item) => ProdukHunter.fromJson(item)).toList();
        _isLoading = false;
      });
      return;
    }

    final data = await HunterService.getRiwayatBarangHunting(status: status);
    setState(() {
      _listProdukHunting = data;
      _isLoading = false;
    });
  }

  void _onStatusSelected(String status) {
    setState(() {
      _selectedStatus = status;
    });

    _fetchBarangkHunting(status: status);
  }

  Widget _buildSkeleton() {
    return Skeletonizer(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.border, width: 0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 80, height: 16, color: Colors.grey.shade300),
                  Container(width: 50, height: 16, color: Colors.grey.shade300),
                ],
              ),
            ),
            const SizedBox(height: 2),
            // Body
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 85,
                  height: 85,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 16,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: 80,
                              height: 14,
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 70,
                            height: 16,
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.border, width: 0.5),
                ),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 120,
                  height: 16,
                  color: Colors.grey.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Komisi Saya', style: AppTextStyles.appBarText),
      ),
      //BAGIAN FILTER STATUS TRANSAKSI
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 52,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ListView.separated(
              controller: _statusScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _statusList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final status = _statusList[index];
                final isSelected = _selectedStatus == status;
                return GestureDetector(
                  onTap: () => _onStatusSelected(status),
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.only(top: 14),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color:
                              isSelected
                                  ? AppColors.primary
                                  : Colors.transparent,
                          width: 3,
                        ),
                      ),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                        color:
                            isSelected
                                ? AppColors.primary
                                : Colors.grey.shade700,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          //  LIST PESANAN
          Expanded(
            child:
                _isLoading 
                    ? ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) => _buildSkeleton(),
                    )
                    : RefreshIndicator(
                      onRefresh: () => _fetchBarangkHunting(status: _selectedStatus),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _listProdukHunting?.length ?? 0,
                        itemBuilder: (context, index) {
                          return RiwayatKomisiCard(
                            produk: _listProdukHunting![index],
                          );
                        },
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
