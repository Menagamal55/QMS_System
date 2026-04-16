import 'package:flutter/material.dart';
import 'package:sw2project/core/network/cach_helper.dart';
import 'package:sw2project/core/routs/app_routs.dart';
import 'package:sw2project/core/utils/colors.dart';
import 'package:sw2project/features/customer_flow/presentation/choose_service.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/Withdrawal.dart';
import 'package:sw2project/features/staff%20flow/presentation/screens/dashboard_screen.dart';
import 'package:sw2project/injection_container.dart';

import 'features/customer_flow/presentation/book_your_queue_number.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies(); 
   await CacheHelper.init(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primary,
          primary: AppColor.primary,
        ),
        scaffoldBackgroundColor: AppColor.background,
        fontFamily: 'Roboto',
        
      ),
     home: ChooseServiceScreen(),
      // initialRoute: AppRoutes.splash,  
      // routes: AppRoutes.getRoutes(),   
    );
  }
}