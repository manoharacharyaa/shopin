import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopin/colors/colors.dart';
import 'package:shopin/firebase_options.dart';
import 'package:shopin/providers/auth.dart';
import 'package:shopin/providers/cart.dart';
import 'package:shopin/providers/orders.dart';
import 'package:shopin/providers/products.dart';
import 'package:shopin/screens/auth_screen.dart';
import 'package:shopin/screens/cart_screen.dart';
import 'package:shopin/screens/orders_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopin/screens/edit_product_screen.dart';
import 'package:shopin/screens/product_details_screen.dart';
import 'package:shopin/screens/products_overview_screen.dart';
import 'package:shopin/screens/user_product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(null, [], null),
          update: (context, auth, previousProducts) => Products(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
            auth.userId,
          ),
        ),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders(null.toString(), [], null.toString()),
          update: (context, auth, previousOrders) => Orders(
            auth.token,
            previousOrders == null ? [] : previousOrders.orders,
            auth.userId,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Shop App Using Provider',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            colorScheme: const ColorScheme.dark(
              background: kbackground,
            ),
            textTheme: TextTheme(
              bodySmall: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              bodyMedium: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              bodyLarge: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
              titleSmall: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // home: const ProductsOverviewScreen(),
          home:
              auth.isAuth ? const ProductsOverviewScreen() : const AuthScreen(),
          routes: {
            ProductDetailsScreen.routeName: (context) =>
                const ProductDetailsScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
            OrdersScreen.routeName: (context) => const OrdersScreen(),
            UserProductScreen.routeName: (context) => const UserProductScreen(),
            EditProductScreen.routeName: (context) => const EditProductScreen(),
          },
        ),
      ),
    );
  }
}
