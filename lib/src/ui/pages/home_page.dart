import 'package:flutter/material.dart';

const String logoAssetPath = 'assets/images/logo.png';
const String fallbackImageUrl = 'https://via.placeholder.com/300x150/1E8F4A/FFFFFF?text=Logo+Placeholder';
const double maxLogoWidth = 300;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agroview'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: const SafeArea(
        child: Center(
          child: LogoImage(),
        ),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth * 0.4;
        final double width = maxWidth > maxLogoWidth ? maxLogoWidth : maxWidth;

        return Image.asset(
          logoAssetPath,
          width: width,
          fit: BoxFit.contain,
          semanticLabel: 'Application Logo',
          errorBuilder: (context, error, stackTrace) {
            // Fallback para imagem de rede se o asset não existir
            return Image.network(
              fallbackImageUrl,
              width: width,
              fit: BoxFit.contain,
              semanticLabel: 'Fallback Application Logo',
              errorBuilder: (context, error, stackTrace) {
                // Fallback final se ambas as imagens falharem
                return Container(
                  width: width,
                  height: width * 0.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E8F4A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.photo,
                    color: Colors.white,
                    size: 40,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}