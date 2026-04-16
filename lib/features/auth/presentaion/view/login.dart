import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw2project/core/routs/app_routs.dart';
import 'package:sw2project/features/auth/presentaion/Bloc/auth_bloc.dart';
import 'package:sw2project/features/auth/presentaion/Bloc/auth_event.dart';
import 'package:sw2project/features/auth/presentaion/Bloc/auth_state.dart';
import 'package:sw2project/features/auth/presentaion/view/register.dart';
import 'package:sw2project/injection_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String routeName = "LoginPage";

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    // الألوان المستخرجة من الصورة عشان نطابق الديزاين
    const Color primaryBlue = Color(0xFF2398C3); // الأزرق السماوي بتاع الزراير والحدود
    const Color darkText = Color(0xFF003B5C); // الأزرق الغامق بتاع النص اللي تحت

    return BlocProvider(
      create: (_) => sl<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          } else if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
            // ضيفي الـ Navigator هنا للصفحة اللي بعدها
            // Navigator.pushReplacementNamed(context, AppRoutes.staffHome);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            // الـ SafeArea والـ SingleChildScrollView مهمين جداً عشان الكيبورد لما يفتح ميغطيش على الشاشة
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                child: Form(
                  key: formKey,
                  // خلينا الـ CrossAxisAlignment.stretch عشان العناصر تاخد عرض الشاشة كله
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. اللوجو
                      Center(
                        child: Image.asset(
                          'assets/images/splash.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // 2. حقل الإيميل
                      const Text(
                        "Email",
                        style: TextStyle(color: primaryBlue, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: emailController,
                        validator: (value) => value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Enter Your Email",
                          hintStyle: const TextStyle(color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: primaryBlue, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: primaryBlue, width: 2.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 3. حقل الباسورد
                      const Text(
                        "Password",
                        style: TextStyle(color: primaryBlue, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true, // عشان يخفي الباسورد
                        validator: (value) => value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: primaryBlue, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: primaryBlue, width: 2.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // 4. زرار Log in
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  LoginEvent(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ),
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                "Log in",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                      ),
                      const SizedBox(height: 30),

                      // خط رفيع أزرق (زي اللي في الصورة تحت الزرار بشوية)
                      const Divider(color: primaryBlue, thickness: 0.5, indent: 20, endIndent: 20),
                      const SizedBox(height: 30),

                      // 5. روابط التسجيل تحت بعض متسنترين
                      Column(
                        children: [
                          const Text(
                            "Don’t have an Account?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context,  AppRoutes.register);
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}