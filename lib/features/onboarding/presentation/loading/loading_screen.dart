import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:go_router/go_router.dart';

class EcoCycleLoadingScreen extends StatefulWidget {
  final bool isAutoNavigate;

  const EcoCycleLoadingScreen({
    super.key,
    this.isAutoNavigate = true,
  });

  @override
  State<EcoCycleLoadingScreen> createState() => _EcoCycleLoadingScreenState();
}

class _EcoCycleLoadingScreenState extends State<EcoCycleLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String _logoAsset = 'web/EcoCycle.png';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Try to pick a custom logo asset if included in pubspec
    _chooseLogoAsset();

    // If autoNavigate, start real initialization (replace _doInit with real work)
    if (widget.isAutoNavigate) {
      _start();
    }
  }

  Future<void> _start() async {
    try {
      // TODO: replace the line below with your real initialization code,
      // e.g. await MyService.instance.initialize(), open DB, or fetch config.
      await Future.delayed(const Duration(seconds: 2));
    } catch (e) {
      // handle initialization error if needed
    }
    if (!mounted) return;
    context.go('/onboarding');
  }

  Future<void> _chooseLogoAsset() async {
    try {
      final manifestContent = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);
      if (manifestMap.containsKey('web/EcoCycle.png')) {
        setState(() {
          _logoAsset = 'web/EcoCycle.png';
        });
        return;
      }
      if (manifestMap.containsKey('web/EcoCycle.png')) {
        setState(() {
          _logoAsset = 'web/EcoCycle.png';
        });
      }
    } catch (_) {
      // ignore and keep default
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _controller,
              child: Image.asset(
                _logoAsset,
                width: 120,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
    }