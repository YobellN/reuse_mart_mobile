import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/produk_titipan.dart';
import 'package:reuse_mart_mobile/services/product_service.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:reuse_mart_mobile/screens/riwayat_produk_penitip/card_produk_titipan.dart';

class RiwayatProdukPage extends StatefulWidget {
  final String initialStatus;
  final String idPenitip;
  final bool initialAvailability;

  const RiwayatProdukPage({
    super.key,
    required this.idPenitip,
    this.initialStatus = 'Semua',
    this.initialAvailability = true,
  });

  @override
  State<RiwayatProdukPage> createState() => _RiwayatProdukPageState();
}

class _RiwayatProdukPageState extends State<RiwayatProdukPage> {
  final List<String> _statusList = [
    'Semua',
    'Tersedia',
    'Terjual',
    'Produk untuk donasi',
    'Didonasikan',
    'Diambil',
    'Tidak Laku',
    'Akan Diambil',
  ];

  final ScrollController _statusScrollController = ScrollController();
  late String _selectedStatus;
  late bool _statusTersedia;
  bool _isLoading = true;
  List<ProdukTitipan> _allProduk = [];

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.initialStatus;
    _statusTersedia = widget.initialAvailability;
    _fetchProduk();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = _statusList.indexOf(_selectedStatus);
      if (index != -1) {
        const itemWidth = 100.0;
        final scrollTo =
            (itemWidth * index) -
            MediaQuery.of(context).size.width / 2 +
            itemWidth / 2;
        _statusScrollController.animateTo(
          scrollTo.clamp(0.0, _statusScrollController.position.maxScrollExtent),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onStatusSelected(String status) {
    setState(() {
      _selectedStatus = status;
    });
    _fetchProduk();
  }

  Future<void> _fetchProduk() async {
    setState(() => _isLoading = true);
    final data = await ProductService.fetchProdukTitipanPenitip(
      statusProduk:
          _selectedStatus == 'Semua' || _selectedStatus == 'Tersedia'
              ? null
              : _selectedStatus,
    );
    setState(() {
      _allProduk = data;
      _isLoading = false;
    });
  }

  List<ProdukTitipan> get _filteredProduk {
    if (_selectedStatus == 'Tersedia') {
      return _allProduk
          .where((item) => item.statusAkhirProduk == null)
          .toList();
    }
    return _allProduk;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Produk Saya', style: AppTextStyles.appBarText),
      ),
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
                          color: isSelected ? AppColors.primary : Colors.white,
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
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _filteredProduk.isEmpty
                    ? const Center(
                      child: Text(
                        "Kamu belum memiliki riwayat produk titipan disini",
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredProduk.length,
                      itemBuilder: (context, index) {
                        final item = _filteredProduk[index];
                        return ProdukTitipanCard(produk: item);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
