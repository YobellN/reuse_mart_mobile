import 'package:flutter/material.dart';
import 'package:reuse_mart_mobile/screens/catalogue/katalog_page.dart';
import 'package:reuse_mart_mobile/screens/informasi_umum/informasiPage.dart';
import 'package:reuse_mart_mobile/screens/profile/profilePage.dart';
import 'package:reuse_mart_mobile/utils/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    InformasiPage(),
    KatalogPage(),
    Center(child: Text('Riwayat', style: AppTextStyles.heading2)),
    ProfilePage(email: "ZtJLH@example.com", name: "John Doe", role: "Hunter", photoUrl: "https://i.pravatar.cc/300?img=1",)
  ];

  static const List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Katalog'),
    BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? AppBar(title: Text("ReuseMart", style: AppTextStyles.heading3)) : null,
      body: _pages[_selectedIndex],
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
