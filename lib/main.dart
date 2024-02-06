import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopin/screens/product_details_screen.dart';
import 'package:shopin/screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App Using Provider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        colorScheme: const ColorScheme.dark(
          background: Color.fromARGB(255, 36, 36, 36),
        ),
      ),
      home: const ProductsOverviewScreen(),
      routes: {
        ProductDetailsScreen.routeName: (context) =>
            const ProductDetailsScreen(),
      },
    );
  }
}
