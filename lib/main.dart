import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
  final String darkKey = "darkModeKey";

  // buat sebuah method 
  getDataDarkModeSetting() async {
  // Constuructor Nilai Future maka perlu await dan get ini
  final prefs = await SharedPreferences.getInstance();
  final result =  prefs.getBool(darkKey);
  if(result != null){
    isDark = result;
  // untuk menyimpan perubahan state/data
    setState(() {
    });
  }
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataDarkModeSetting();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Kasus DarkMode',
      // untuk memanggil tema
      darkTheme: isDark ? ThemeData.dark() : ThemeData.light(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Setting Dark Mode'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                size: 50.0,
                color: isDark ? Colors.blue : Colors.orange,
              ),
              SizedBox(
                height: 4.0,
              ),
              Switch(
                  value: isDark,
                  onChanged: (value) async {
                    isDark = !isDark;
                    // untuk mendapat atau get data
                    final prefs = await SharedPreferences.getInstance();
                    // untuk menyimpan
                    await prefs.setBool(darkKey,isDark);
                    //setState untuk membuild ulang atau merefresh setiap perubahan state/data
                    setState(() {});
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
