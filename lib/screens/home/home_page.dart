import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/screens/catalogue/katalog_page.dart';
import 'package:reuse_mart_mobile/screens/informasi_umum/informasiPage.dart';
import 'package:reuse_mart_mobile/screens/profile/profilePage.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _token = '';
  String _role = '';

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
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
      'icon': Icons.home,
      'label': 'Home',
      'widget': InformasiPage(role: _role),
      'showFor': ['Pembeli', 'Penitip', 'Hunter', 'Kurir', ''],
    },
    {
      'icon': Icons.list_alt,
      'label': 'Katalog',
      'widget': KatalogPage(),
      'showFor': ['Pembeli', 'Penitip', 'Hunter', 'Kurir', ''],
    },
    {
      'icon': Icons.history,
      'label': 'Riwayat',
      'widget': Center(child: Text('Riwayat', style: AppTextStyles.heading2)),
      'showFor': ['Pembeli', 'Penitip', 'Hunter', 'Kurir'],
    },
    {
      'icon': Icons.person,
      'label': 'Profil',
      'widget': ProfilePage(
        email: "ZtJLH@example.com",
        name: "John Doe",
        role: _role,
        photoUrl: "https://i.pravatar.cc/300?img=1",
      ),
      'showFor': ['Pembeli', 'Penitip', 'Hunter', 'Kurir'],
    },
    {
      'icon': Icons.login,
      'label': 'Login',
      'widget': Container(),
      'showFor': [''],
    },
  ];

  List<BottomNavigationBarItem> get items =>
      navItems
          .where((item) => item['showFor'].contains(_role))
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(item['icon'] as IconData),
              label: item['label'] as String,
            ),
          )
          .toList();

  List<Widget> get pages =>
      navItems.map((item) => item['widget'] as Widget).toList();

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
