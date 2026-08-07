import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeSupabaseIfConfigured();
  runApp(const MiestaApp());
}

Future<void> _initializeSupabaseIfConfigured() async {
  const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
  if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
    return;
  }

  await Supabase.initialize(url: supabaseUrl, publishableKey: supabaseAnonKey);
}
