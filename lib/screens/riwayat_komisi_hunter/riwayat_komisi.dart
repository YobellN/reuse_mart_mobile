import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/screens/riwayat_komisi_hunter/card_riwayat_komisi.dart';
import 'package:reuse_mart_mobile/screens/riwayat_transaksi_pembeli/card_riwayat_pembelian.dart' hide ProdukRiwayat;
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class RiwayatKomisiPage extends StatefulWidget {
  final String initialStatus;
  const RiwayatKomisiPage({super.key, this.initialStatus = 'Semua'});

  @override
  State<RiwayatKomisiPage> createState() => _RiwayatKomisiPageState();
}

class _RiwayatKomisiPageState extends State<RiwayatKomisiPage> {
  final List<String> _statusList = [
    'Semua',
    'Selesai',
    'Menunggu',
    'Batal',
  ];

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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return RiwayatKomisiCard(
                  namaPenitip: 'boscollection',
                  status: 'Selesai',
                  produkList: [
                    ProdukRiwayat(
                      nama: 'Celana Jogger Panjang Jogger Swe...',
                      kategori: 'Pakaian & Aksesori',
                      harga: 74869,
                      foto: 'assets/icons/reuse-mart-icon.png',
                    ),
                    ProdukRiwayat(
                      nama: 'Celana Jogger Panjang Jogger Swe...',
                      kategori: 'Pakaian & Aksesori',
                      harga: 74869,
                      foto: 'assets/icons/reuse-mart-icon.png',
                    ),
                  ],
                  totalJumlah: 1,
                  totalHarga: 86025,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
