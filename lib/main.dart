import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:metro_project/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://kpughuodxdjsodscurmf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtwdWdodW9keGRqc29kc2N1cm1mIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ2Njk0ODcsImV4cCI6MjA3MDI0NTQ4N30.v52H1nXyx3-WcJjdYbGRZ5km4kddDQFODUPfoyaNZNY',
  );
  runApp(MetroApp());
}

class MetroApp extends StatelessWidget {
  const MetroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
