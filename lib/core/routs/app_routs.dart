import 'package:flutter/material.dart';

// Auth
import 'package:sw2project/features/auth/presentaion/view/login.dart';
import 'package:sw2project/features/auth/presentaion/view/register.dart';
import 'package:sw2project/features/customer_flow/presentation/book_your_queue_number.dart';

// Customer Flow
import 'package:sw2project/features/customer_flow/presentation/choose_service.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/Deposit.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/Loan%20Inquiry.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/Withdrawal.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/customer_support.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/ticketrequest.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/open_account.dart';
import 'package:sw2project/features/customer_flow/presentation/screens/card_services.dart';
import 'package:sw2project/features/staff%20flow/presentation/screens/Queue%20Management.dart';
import 'package:sw2project/features/staff%20flow/presentation/screens/dashboard_screen.dart';
import 'package:sw2project/features/staff%20flow/presentation/screens/notification.dart';
import 'package:sw2project/features/staff%20flow/staff/presentaion/scan.dart';

// Staff Flow

// Splash
import 'package:sw2project/features/splash_screen/presentation/splash_screen.dart';
import 'package:sw2project/features/staff%20flow/staff/presentaion/staff_home.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';

  static const chooseService = '/choose-service';
  static const withdrawal = '/withdrawal';
  static const openAccount = '/open-account';
  static const cardServices = '/card-services';
  static const loanInquiry = '/loan-inquiry';
  static const customerSupport = '/customer-support';
  static const ticketRequest = '/ticket-request';
  static const bookQueue = '/book-queue';

  static const dashboard = '/dashboard';
  static const queueManagement = '/queue-management';
  static const staffHome = '/staff-home';
  static const notifications = '/notifications';
  static const qrScanner = '/qr-scanner';
static const dep = '/deposit';
  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashPage(),
    login: (context) => LoginPage(),
    register: (context) => RegisterPage(),

    // Customer
    chooseService: (context) => const ChooseServiceScreen(),
    withdrawal: (context) => const WithdrawalScreen(),
    openAccount: (context) => const Open_account(),
    cardServices: (context) => const  CardServices(),
    loanInquiry: (context) => const Loan_inquiry (),
    customerSupport: (context) => const Customer_support(),
    ticketRequest: (context) => const TicketRequestScreen(),
    bookQueue: (context) => const BookQueueScreen(),

    // Staff
    dashboard: (context) => const DashboardScreen(),
    queueManagement: (context) => const QueueManagementScreen(),
    staffHome: (context) => const StaffHome(),
    notifications: (context) => const NotificationsScreen(),
    qrScanner: (context) => const QrScannerScreen(),
    dep: (context) => const Deposit(),
  };
}