import 'package:firstapp/icons.dart';
import 'package:firstapp/pages/meditation/meditation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.useLightMode,
    required this.handleBrightnessChange,
  });

  final bool useLightMode;
  final void Function(bool useLightMode) handleBrightnessChange;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: SvgIcon(assetName: "stickynote"),
            label: 'Diary',
          ),
          NavigationDestination(
            icon: SvgIcon(assetName: "relax"),
            label: 'Meditation',
          ),
          NavigationDestination(
            icon: SvgIcon(assetName: "mindfulness"),
            label: 'Triggers',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              TextButton(
                  onPressed: () =>
                      widget.handleBrightnessChange(!widget.useLightMode),
                  child: const Text("change"))
            ],
          ),
        ),
        const MeditationScreen(),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}
