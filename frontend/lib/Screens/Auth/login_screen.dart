import 'package:devup/Screens/Auth/register_screen.dart';
import 'package:devup/Screens/Dashboard/dashboard.dart';
import 'package:devup/Values/values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Dev',
                    style: TextStyle(
                      fontFamily: 'Unbounded',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Up',
                        style: TextStyle(
                          fontFamily: 'Unbounded',
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: [AppColors.primary, AppColors.secondary],
                            ).createShader(Rect.fromLTWH(0.0, 0.0, 70.0, 40.0)),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Level Up Your Coding Skills',
                  style: TextStyle(
                    fontFamily: 'Unbounded',
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 60),
              Text(
                'Вход',
                style: TextStyle(
                  fontFamily: 'Unbounded',
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 24),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'Введите ваш email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _passwordController,
                label: 'Пароль',
                hint: 'Введите ваш пароль',
                icon: Icons.lock_outline,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _rememberMe,
                          activeColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Запомнить меня',
                        style: TextStyle(
                          fontFamily: 'Montserrat', // <--- ЗДЕСЬ МЕНЯЕМ!
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Забыли пароль
                    },
                    child: Text(
                      'Забыли пароль?',
                      style: TextStyle(
                        fontFamily: 'Unbounded',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              _buildPrimaryButton(
                text: 'Войти',
                onPressed: () {
                  Get.offAll(() => Dashboard());
                },
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  'или войдите с помощью',
                  style: TextStyle(
                    fontFamily: 'Montserrat', // <--- ЗДЕСЬ МЕНЯЕМ!
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    icon: Icons.g_mobiledata,
                    color: Color(0xFFDB4437),
                    onPressed: () {},
                  ),
                  SizedBox(width: 16),
                  _buildSocialButton(
                    icon: Icons.facebook,
                    color: Color(0xFF4267B2),
                    onPressed: () {},
                  ),
                  SizedBox(width: 16),
                  _buildSocialButton(
                    icon: Icons.apple,
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Нет аккаунта?',
                    style: TextStyle(
                      fontFamily: 'Montserrat', // <--- ЗДЕСЬ МЕНЯЕМ!
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => RegisterScreen());
                    },
                    child: Text(
                      'Зарегистрироваться',
                      style: TextStyle(
                        fontFamily: 'Unbounded',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Unbounded',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.textLight.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: TextStyle(
              fontFamily: 'Unbounded',
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: 'Montserrat', // <--- ПЛЕЙСХОЛДЕР НА MONT!
                fontSize: 16,
                color: AppColors.textLight,
              ),
              prefixIcon: Icon(
                icon,
                color: AppColors.textSecondary,
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Unbounded',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: color,
          size: 30,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
