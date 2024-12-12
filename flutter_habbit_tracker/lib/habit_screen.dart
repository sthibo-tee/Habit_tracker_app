import 'package:flutter/material.dart';
import 'database.dart';

class HabitScreen extends StatefulWidget{
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() {
    return _HabitScreenState();
  }
}

class _HabitScreenState extends State<HabitScreen> {
  List<Map<String, dynamic>> habits = [];
  List<Map<String, dynamic>> habitsLogs = [];

  @override
  void initState() {
    setState(() {
      super.initState();
      _fetchData();
    });
  }

  void initDatabase() async {
    await Databasehelper.initDatabase();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data1 = await Databasehelper.database.query('habits');
    final data2 = await Databasehelper.database.query('habit_logs');
    setState(() {
      habits = data1;
      habitsLogs = data2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits'),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        elevation: 5,
      ),

      body: Column(
        children: [
          const SizedBox(height: 30,),
          const Text('Habits:'),
          Expanded(
            child: habits.isEmpty
            ? const Center(child: Text('No Habits yet!'))
            : ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                final habit = habits[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: habit['name'],
                    subtitle: habit['description'],
                    trailing: habit['streak'],
                  ),
                );
              }
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: null,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton:const  FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: null,
        tooltip: 'Add Habit',
        child: Icon(Icons.add),
      ),
    );
  }
}