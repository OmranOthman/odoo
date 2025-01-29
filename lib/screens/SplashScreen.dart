import 'package:flutter/material.dart';
import 'package:odooproject/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // تأثير التلاشي عند تشغيل الشاشة
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // الانتقال بعد 5 ثوانٍ مع أنيميشن الانزلاق من الأسفل إلى الأعلى
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(_createSlideRoute());
    });
  }

  Route _createSlideRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // يبدأ من الأسفل
        const end = Offset.zero; // ينتهي عند موقعه الطبيعي
        const curve = Curves.easeInOut; // تسهيل الحركة لجعلها سلسة

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFA3449B), // لون بنفسجي
              Color(0xFFF9F5F9), // لون فاتح
              Color(0xFF94939B), // لون رمادي
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 3),
            child: Image.asset(
              'assets/logo.png',
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
