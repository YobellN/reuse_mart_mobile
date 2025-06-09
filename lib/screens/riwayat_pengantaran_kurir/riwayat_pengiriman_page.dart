import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/models/kurir.dart';
import 'package:reuse_mart_mobile/services/kurir_service.dart';
import 'package:reuse_mart_mobile/screens/riwayat_pengantaran_kurir/card_riwayat_pengiriman.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class RiwayatPengirimanKurirPage extends StatefulWidget {
  final String? initialStatus;

  const RiwayatPengirimanKurirPage({super.key, this.initialStatus});

  @override
  State<RiwayatPengirimanKurirPage> createState() =>
      _RiwayatPengirimanKurirPageState();
}

class _RiwayatPengirimanKurirPageState
    extends State<RiwayatPengirimanKurirPage> {
  final List<String> _statusList = [
    'Semua',
    'Menunggu Kurir',
    'Diambil oleh kurir',
    'Selesai',
    'Dibatalkan',
  ];

  String _selectedStatus = 'Semua';
  List<PengirimanKurir> _pengirimanList = [];
  List<PengirimanKurir> _filteredList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.initialStatus != null &&
        _statusList.contains(widget.initialStatus)) {
      _selectedStatus = widget.initialStatus!;
    }
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);
    final data = await KurirService.getRiwayatPengiriman();
    if (mounted) {
      setState(() {
        _pengirimanList = data;
        _filterData();
        _isLoading = false;
      });
    }
  }

  void _filterData() {
    if (_selectedStatus == 'Semua') {
      _filteredList = _pengirimanList;
    } else {
      _filteredList =
          _pengirimanList
              .where((p) => p.statusPengiriman == _selectedStatus)
              .toList();
    }
  }

  Future<void> _selesaikanPengiriman(String idPenjualan) async {
    try {
      final success = await KurirService.updateStatusPengiriman(idPenjualan);

      if (success == 'Pengiriman berhasil dikonfirmasi selesai' && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pengiriman berhasil dikonfirmasi selesai'),
          ),
        );
        _fetchData();
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gagal menyelesaikan pengiriman'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terjadi kesalahan'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Riwayat Pengiriman',
          style: AppTextStyles.appBarText,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 52,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _statusList.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final status = _statusList[index];
                final isSelected = _selectedStatus == status;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedStatus = status;
                      _filterData();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
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

          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _filteredList.isEmpty
                    ? const Center(child: Text('Tidak ada pengiriman'))
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredList.length,
                      itemBuilder: (context, index) {
                        final pengiriman = _filteredList[index];
                        return RiwayatPengirimanCard(
                          pengiriman: pengiriman,
                          onSelesaiPressed:
                              pengiriman.statusPengiriman ==
                                      "Diambil oleh kurir"
                                  ? () => _selesaikanPengiriman(
                                    pengiriman.idPenjualan,
                                  )
                                  : null,
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
