import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reuse_mart_mobile/screens/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:reuse_mart_mobile/models/top_seller.dart';
import 'package:reuse_mart_mobile/services/top_seller_service.dart';
import 'package:intl/intl.dart';


class InformasiPage extends StatefulWidget {
  final String role;
  const InformasiPage({super.key, required this.role});

  @override
  State<InformasiPage> createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
  int _current = 0;

  TopSeller? topSeller;
  bool isLoadingTopSeller = true;

  @override
  void initState() {
    super.initState();
    fetchTopSellerData();
  }

  Future<void> fetchTopSellerData() async {
    List<TopSeller> cached = await TopSellerService.getCachedTopSellers();

    if (cached.isNotEmpty) {
      setState(() {
        topSeller = cached.first;
        isLoadingTopSeller = false;
      });
    }

    List<TopSeller> fresh = await TopSellerService.fetchTopSellers();

    if (fresh.isNotEmpty &&
        fresh.first.idTopSeller != cached.first.idTopSeller) {
      setState(() {
        topSeller = fresh.first;
      });
    }
  }


  final List<CarouselData> carouselData = const [
    CarouselData(
      title: 'Aman dan Mudah ',
      desc:
          'Titipkan barang bekas dengan praktis, tanpa harus repot jual sendiri. Tim ReUseMart yang urus semuanya.',
      image: 'assets/homePage/green-bag.webp',
    ),
    CarouselData(
      title: 'Pantau Barang Titipan',
      desc:
          'Lacak status barang bekas yang kamu titipkan—mulai dari proses QC, penjualan, hingga donasi. Semua transparan dan real-time.',
      image: 'assets/homePage/report.png',
    ),
    CarouselData(
      title: 'Kontribusi Sosial',
      desc:
          'Barang tak terjual akan didonasikan ke organisasi sosial yang membutuhkan. Kamu tetap dapat poin.',
      image: 'assets/homePage/donasi.png',
    ),
    CarouselData(
      title: 'Dapatkan Reward',
      desc:
          'Transaksi atau donasi barang memberimu poin. Tukarkan dengan merchandise eksklusif.',
      image: 'assets/homePage/reward.png',
    ),
  ];

  final List<Map<String, dynamic>> kategoriBarang = [
    {
      "label": "Elektronik",
      "icon": Icons.electrical_services,
      "color": Colors.lightBlue,
    },
    {"label": "Pakaian", "icon": Icons.checkroom, "color": Colors.indigo},
    {"label": "Mainan", "icon": Icons.toys, "color": Colors.pink},
    {"label": "Otomotif", "icon": Icons.directions_car, "color": Colors.orange},
    {"label": "Kosmetik", "icon": Icons.brush, "color": Colors.green},

    {"label": "Perabot", "icon": Icons.chair, "color": Colors.redAccent},
    {"label": "Kantor", "icon": Icons.desktop_windows, "color": Colors.purple},
    {
      "label": "Bayi & Anak",
      "icon": Icons.child_friendly,
      "color": Colors.teal,
    },
    {"label": "Outdoor", "icon": Icons.park, "color": Colors.cyan},
    {"label": "Buku", "icon": Icons.menu_book, "color": Colors.deepOrange},
  ];

  final kategoriPilihan = [
    {
      "label": "Elektronik",
      "value": "Elektronik & Gadget",
      "icon": "assets/homePage/laptop.webp",
    },
    {
      "label": "Hobi",
      "value": "Hobi, Mainan, & Koleksi",
      "icon": "assets/homePage/console.webp",
    },
    {
      "label": "Kosmetik",
      "value": "Kosmetik & Perawatan Diri",
      "icon": "assets/homePage/lipstick.webp",
    },
    {
      "label": "Otomotif",
      "value": "Otomotif & Aksesori",
      "icon": "assets/homePage/wheel.png",
    },
    {
      "label": "Pakaian",
      "value": "Pakaian & Aksesori",
      "icon": "assets/homePage/clothes.webp",
    },
  ];

  Widget _buildTopSellerSection() {
    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - 1);
    final bulanLalu = DateFormat('MMMM', 'id_ID').format(lastMonth);

    final sellerName = topSeller?.penitip.user.nama ?? 'Tidak ada top seller';
    final rating = topSeller?.avgRating ?? 0.0;
    final jumlahTerjual = topSeller?.totalProduk ?? 0;
    final pendapatan = topSeller?.totalPenjualan ?? 0;
   

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Seller Bulan $bulanLalu",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF9C4), Color(0xFFFFFDE7)],
                begin: Alignment.bottomLeft,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.shade300, width: 0.7),
            ),
            child: Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/homePage/badge.webp',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        sellerName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.inventory_2,
                            size: 16,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "$jumlahTerjual produk terjual",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.attach_money,
                            size: 16,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Penjualan $bulanLalu ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(pendapatan)}",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "$rating / 5.0",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayRole = widget.role;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //SECTION CAROUSEL SLIDER
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 216,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(36),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 18,
                    child: Text(
                      'Selamat datang ${displayRole.isEmpty ? "" : displayRole}!',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 0,
                    right: 0,
                    child: CarouselSlider.builder(
                      itemCount: carouselData.length,
                      options: CarouselOptions(
                        height: 210,
                        viewportFraction: 0.93,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final item = carouselData[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            item.desc,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    Image.asset(
                                      item.image,
                                      height: 110,
                                      width: 110,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              AnimatedSmoothIndicator(
                                activeIndex: _current,
                                count: carouselData.length,
                                effect: const ExpandingDotsEffect(
                                  dotHeight: 6,
                                  dotWidth: 6,
                                  expansionFactor: 2.0,
                                  spacing: 6,
                                  activeDotColor: AppColors.emeraldGreen,
                                  dotColor: Colors.black26,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              //SECTION KATEGORI PRODUK PILIHAN (clickable)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kategori Produk Pilihan",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 5,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(kategoriPilihan.length, (index) {
                        final kategori = kategoriPilihan[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => HomePage(
                                      initialIndex: 1,
                                      initialCategory: kategori["value"],
                                    ),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.surface,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 3,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.asset(
                                    kategori["icon"] ??
                                        'assets/icons/default.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                kategori["label"] ?? "Kategori",
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const HomePage(initialIndex: 1),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          "Lihat lebih banyak",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              //SECTION TOP SELLER
              _buildTopSellerSection(),
              const SizedBox(height: 24),
              //SECTION KATEGORI BARANG TITIPAN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Kategori Barang Titipan",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: GridView.count(
                        crossAxisCount: 5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 0.75,
                        children: List.generate(kategoriBarang.length, (index) {
                          final kategori = kategoriBarang[index];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kategori["color"].withOpacity(0.2),
                                ),
                                child: Icon(
                                  kategori["icon"],
                                  color: kategori["color"],
                                  size: 26,
                                ),
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                height: 30,
                                child: Text(
                                  kategori["label"],
                                  style: const TextStyle(fontSize: 11),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              //SECTION INFORMASI PENITIPAN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Informasi Penitipan",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // KIRI
                          Container(
                            width: 70,
                            height: 160,
                            decoration: const BoxDecoration(
                              color: AppColors.darkPastelGreen,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.fromBorderSide(
                                    BorderSide(
                                      color: AppColors.darkPastelGreen,
                                      width: 1,
                                    ),
                                  ),
                                ),

                                child: const Icon(
                                  Icons.inventory_2_rounded,
                                  color: AppColors.darkPastelGreen,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),

                          // KANAN
                          Expanded(
                            child: Container(
                              height: 160,
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                                border: Border.fromBorderSide(
                                  BorderSide(
                                    color: AppColors.darkPastelGreen,
                                    width: 0.8,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Syarat Penitipan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.inventory,
                                        size: 16,
                                        color: AppColors.softPastelGreen,
                                      ),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          'Barang harus dalam kondisi layak.',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: AppColors.softPastelGreen,
                                      ),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          'Durasi penitipan maksimal 30 hari.',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 16,
                                        color: AppColors.softPastelGreen,
                                      ),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          'Bisa diperpanjang jika belum terjual.',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.card_giftcard,
                                        size: 16,
                                        color: AppColors.softPastelGreen,
                                      ),
                                      SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          'Barang tidak terjual bisa didonasikan.',
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
                  ],
                ),
              ),

              const SizedBox(height: 24),
              //SECTION FITUR REUSEMART
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Tentang Kami",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 16),
                    FeatureItem(
                      icon: Icons.recycling,
                      title: "Misi Kami",
                      desc:
                          "ReuseMart membantu mengurangi limbah dan mendorong ekonomi sirkular melalui jual beli dan donasi barang bekas.",
                    ),
                    FeatureItem(
                      icon: Icons.lock_outline,
                      title: "Penitipan Aman",
                      desc:
                          "Titipkan barang bekas dengan mudah. Tim kami urus pemasaran hingga pengiriman, tanpa kamu harus repot.",
                    ),
                    FeatureItem(
                      icon: Icons.card_giftcard,
                      title: "Reward & Donasi",
                      desc:
                          "Setiap transaksi dan donasi barang memberikanmu poin yang bisa ditukar menjadi hadiah menarik.",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFBBF7D0)),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: const Color(0xFF10B981)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF065F46),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CarouselData {
  final String title;
  final String desc;
  final String image;

  const CarouselData({
    required this.title,
    required this.desc,
    required this.image,
  });
}
