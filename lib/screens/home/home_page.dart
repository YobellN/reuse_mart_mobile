import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/screens/catalogue/katalog_page.dart';
import 'package:reuse_mart_mobile/screens/informasi_umum/informasiPage.dart';
import 'package:reuse_mart_mobile/screens/merchandise/katalog_merch_page.dart';
import 'package:reuse_mart_mobile/screens/onboarding_screen/onboarding_screen.dart';
import 'package:reuse_mart_mobile/screens/profile/profilePage.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;
  final String? initialCategory;

  const HomePage({super.key, this.initialIndex = 0, this.initialCategory});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _token = '';
  String _role = '';
  String? _initialCategory;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _initialCategory = widget.initialCategory;
    getUser();
  }

  @override
  void dispose() {
    super.dispose();
    // Tidak perlu set _selectedIndex di dispose, cukup super.dispose();
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token') ?? '';
      _role = prefs.getString('role') ?? '';
    });
  }

  List<Map<String, dynamic>> get navItems => [
    {
      'icon': 'assets/icons/home.svg',
      'label': 'Home',
      'widget': InformasiPage(role: _role),
      'showFor': ['Pembeli', 'Penitip', 'Hunter', 'Kurir', ''],
    },
    {
      'icon': 'assets/icons/catalog.svg',
      'label': 'Katalog',
      'widget': KatalogPage(initialCategory: _initialCategory),

      'showFor': ['Pembeli', 'Penitip', 'Hunter', 'Kurir', ''],
    },
    {
      'icon': 'assets/icons/history.svg',
      'label': 'Merch',
      'widget': KatalogMerchPage(),
      'showFor': ['Pembeli'],
    },
    {
      'icon': 'assets/icons/user.svg',
      'label': 'Profil',
      'widget': ProfilePage(
        email: "ZtJLH@example.com",
        name: "John Doe",
        role: _role,
        photoUrl: "https://i.pravatar.cc/300?img=1",
        poin: 100,
        nomorTelpon: "08123456789",
      ),
      'showFor': ['Pembeli', 'Penitip', 'Hunter', 'Kurir'],
    },
    {
      'icon': 'assets/icons/login.svg',
      'label': 'Login',
      'widget': Container(),
      'showFor': [''],
    },
  ];

  List<BottomNavigationBarItem> get items {
    final filteredItems =
        navItems.where((item) => item['showFor'].contains(_role)).toList();
    return List.generate(filteredItems.length, (index) {
      final item = filteredItems[index];
      final iconData = item['icon'];
      final bool isSelected = _selectedIndex == index;

      return BottomNavigationBarItem(
        icon: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child:
              iconData is String
                  ? SvgPicture.asset(
                    iconData,
                    colorFilter: ColorFilter.mode(
                      isSelected ? AppColors.primary : AppColors.textSecondary,
                      BlendMode.srcIn,
                    ),
                    width: 26,
                    height: 26,
                  )
                  : Icon(
                    iconData as IconData,
                    color:
                        isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                    size: 26,
                  ),
        ),
        label: item['label'] as String,
      );
    });
  }

  List<Widget> get pages =>
      navItems
          .where((item) => item['showFor'].contains(_role))
          .map((item) => item['widget'] as Widget)
          .toList();

  void _onItemTapped(int index) async {
    if (items[index].label == 'Login' && _token == '') {
      final result = await Navigator.pushNamed(context, '/login');
      if (result == true) {
        setState(() {
          _selectedIndex = 0;
        });
        await getUser();
      }
      return;
    }

    if (items[index].label == 'Katalog') {
      setState(() {
        _initialCategory = null;
      });
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? AppBar(title: Text("ReuseMart")) : null,
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
