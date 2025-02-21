import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connections',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.notifications))
        ],
      ),
      body: Column(
  children: [
    // 20% of screen height
    Flexible(
      flex: 3, // 2 parts out of 10 (20%)
      child: Container(
        color: Colors.blue, // Example color
        child: Center(child: Text("20% Height", style: TextStyle(color: Colors.white))),
      ),
    ),

    // 80% of screen height
    Flexible(
      flex: 17, // 8 parts out of 10 (80%)
      child: Container(
        color: Colors.green, // Example color
        child: Center(child: Text("80% Height", style: TextStyle(color: Colors.white))),
      ),
    ),
  ],
),

    );
  }
}