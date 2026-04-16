import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sw2project/features/auth/presentaion/Bloc/auth_bloc.dart';
import 'package:sw2project/features/auth/presentaion/Bloc/auth_event.dart';
import 'package:sw2project/features/auth/presentaion/Bloc/auth_state.dart';
import 'package:sw2project/injection_container.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static String routeName = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  // المتغير ده عشان نشغل بيه زرار العين (نخفي ونظهر الباسورد)
  bool isPasswordHidden = true;

  // نفس الألوان اللي استخدمناها في اللوجين عشان الـ Theme يكون واحد
  final Color primaryBlue = const Color(0xFF2398C3);
  final Color darkText = const Color(0xFF003B5C);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            // يرجع لصفحة اللوجين بعد التسجيل الناجح
            Navigator.pop(context); 
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
                child: Form(
                  key: formKey,
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
                      const SizedBox(height: 20),

                      // 2. حقل الاسم (Name)
                      Text(
                        "Name",
                        style: TextStyle(color: primaryBlue, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: nameController,
                        validator: (value) => value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Enter Your Name",
                          hintStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: Icon(Icons.edit, color: primaryBlue), // أيقونة القلم
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue, width: 2.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 3. حقل الإيميل (Email)
                      Text(
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
                          suffixIcon: Icon(Icons.mail_outline, color: primaryBlue), // أيقونة الظرف
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue, width: 2.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 4. حقل الباسورد (Password)
                      Text(
                        "Password",
                        style: TextStyle(color: primaryBlue, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: passwordController,
                        obscureText: isPasswordHidden, // مربوطة بالمتغير عشان تخفي وتظهر
                        validator: (value) => value!.isEmpty ? "Required" : null,
                        decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          // زرار العين
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordHidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              color: primaryBlue,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordHidden = !isPasswordHidden;
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue, width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: primaryBlue, width: 2.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // 5. زرار التسجيل
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  RegisterEvent(
                                    name: nameController.text.trim(),
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
                                "Sign up",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                      ),
                      const SizedBox(height: 25),

                      // خط رفيع أزرق (زي اللي في الصورة)
                      Divider(color: primaryBlue, thickness: 0.5, indent: 20, endIndent: 20),
                      const SizedBox(height: 20),

                      // 6. روابط تسجيل الدخول (اللي كانت ناقصة)
                      Column(
                        children: [
                          Text(
                            "Already have an Account?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // بيرجع لصفحة اللوجين
                            },
                            child: Text(
                              "Log in",
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