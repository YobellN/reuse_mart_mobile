import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/penjualan.dart';
import 'package:reuse_mart_mobile/services/penjualan_service.dart';
import 'package:reuse_mart_mobile/screens/riwayat_transaksi_pembeli/card_riwayat_pembelian.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class RiwayatPembelianPage extends StatefulWidget {
  final String initialStatus;
  const RiwayatPembelianPage({super.key, this.initialStatus = 'Semua'});

  @override
  State<RiwayatPembelianPage> createState() => _RiwayatPembelianPageState();
}

class _RiwayatPembelianPageState extends State<RiwayatPembelianPage> {
  final List<String> _statusList = [
    'Semua',
    'Belum Dibayar',
    'Menunggu konfirmasi',
    'Disiapkan',
    'Dikirim',
    'Selesai',
    'Hangus',
  ];

  final ScrollController _statusScrollController = ScrollController();
  late String _selectedStatus;
  bool _isLoading = true;
  List<Penjualan> _penjualanList = [];

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.initialStatus;
    _fetchPenjualan();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = _statusList.indexOf(_selectedStatus);
      if (index != -1) {
        final itemWidth = 100.0;
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

  String? mapStatusToApi(String status) {
    switch (status) {
      case 'Belum Dibayar':
        return 'Menunggu Pembayaran';
      case 'Menunggu konfirmasi':
        return 'Diproses';
      case 'Disiapkan':
        return 'Disiapkan';
      case 'Menunggu Pengambilan':
        return 'Menunggu Pengambilan';
      case 'Dikirim':
        return 'Dikirim';
      case 'Selesai':
        return 'Selesai';
      case 'Hangus':
        return 'Hangus';
      default:
        return null;
    }
  }


  void _onStatusSelected(String status) {
    setState(() {
      _selectedStatus = status;
     
    });
    _fetchPenjualan();
  }

  Future<void> _fetchPenjualan() async {
    setState(() => _isLoading = true);
    // final statusQuery = _selectedStatus == 'Semua' ? null : _selectedStatus;
    final statusApi = mapStatusToApi(_selectedStatus);
    final data = await PenjualanService.getPenjualanPembeli(status: statusApi);
    setState(() {
      _penjualanList = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pesanan Saya', style: AppTextStyles.appBarText),
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

          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _penjualanList.isEmpty
                    ? const Center(
                      child: Text("Kamu belum memiliki riwayat transaksi"),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _penjualanList.length,
                      itemBuilder: (context, index) {
                        final trx = _penjualanList[index];
                        return RiwayatPembelianCard(penjualan: trx);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
