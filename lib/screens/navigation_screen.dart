import 'package:flutter/material.dart';
import 'package:news_app/provider/connectivity_provider.dart';
import 'package:provider/provider.dart';
import './main_screen.dart';
import './search_news_screen.dart';
import './favorite_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  var _selectedInex = 0;
  void _selectScreen(int index) {
    setState(() {
      _selectedInex = index;
    });
  }

  List<Widget> screens = [
    const MainScreen(),
    const SearchNewsScreen(),
    const FavoriteScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final isConnected = Provider.of<ConnectivityProvider>(context).isConnected;

    return isConnected
        ? Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                onTap: _selectScreen,
                currentIndex: _selectedInex,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.black,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Main'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: 'Search'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favorite'),
                ]),
            body: screens[_selectedInex],
          )
        : const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image(image: AssetImage('assets/images/no_internet.gif')),
            ));
  }
}
