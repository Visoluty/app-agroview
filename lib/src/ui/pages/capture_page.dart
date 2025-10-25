import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../theme/app_theme.dart';
import '../../viewmodels/analysis_viewmodel.dart';
import '../../models/api_model.dart';

class CapturePage extends StatefulWidget {
  const CapturePage({super.key});

  @override
  State<CapturePage> createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  GrainType _selectedGrainType = GrainType.soja;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightGreen,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.agriculture,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'AgroView',
              style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              onPressed: () {
                // TODO: Implementar ajuda
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ajuda em desenvolvimento')),
                );
              },
              icon: const Icon(
                Icons.help_outline,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Card de instruções
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: AppTheme.primaryGreen.withOpacity(0.1),
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.camera_alt_outlined,
                        color: AppTheme.lightGreen,
                        size: 64,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Capturar Imagem dos Grãos',
                        textAlign: TextAlign.center,
                        style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Tire uma foto ou selecione uma imagem da galeria para análise e classificação dos grãos',
                        textAlign: TextAlign.center,
                        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.secondaryText,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Seletor de tipo de grão
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tipo de Grão',
                      style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.dividerColor, width: 1.5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<GrainType>(
                          value: _selectedGrainType,
                          isExpanded: true,
                          items: GrainType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type.displayName),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedGrainType = value;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Preview da imagem
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                  color: _selectedImage != null ? Colors.white : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _selectedImage != null ? AppTheme.lightGreen : const Color(0xFFE0E0E0),
                    width: 2,
                  ),
                ),
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: kIsWeb
                            ? Image.network(
                                _selectedImage!.path,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                      )
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_outlined,
                              color: Color(0xFFCCCCCC),
                              size: 48,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Imagem aparecerá aqui',
                              style: TextStyle(
                                color: Color(0xFFAAAAAA),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 32),
              
              // Botões de ação
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt, size: 24),
                      label: const Text('Abrir Câmera'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.lightGreen,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library, size: 24),
                      label: const Text('Escolher da Galeria'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.lightGreen,
                        side: const BorderSide(color: AppTheme.lightGreen, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<AnalysisViewModel>(
                    builder: (context, analysisViewModel, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: _selectedImage != null && !analysisViewModel.isProcessingImage
                              ? () => _processImage(analysisViewModel)
                              : null,
                          icon: analysisViewModel.isProcessingImage
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Icon(Icons.analytics, size: 24),
                          label: Text(analysisViewModel.isProcessingImage ? 'Processando...' : 'Analisar Grãos'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondaryText,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao selecionar imagem: ${e.toString()}'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  Future<void> _processImage(AnalysisViewModel analysisViewModel) async {
    if (_selectedImage == null) return;

    analysisViewModel.clearError();

    final success = await analysisViewModel.processImage(
      _selectedImage!,
      _selectedGrainType.displayName,
    );

    if (success && mounted) {
      // Navegar para a página de detalhes da análise
      final processResult = analysisViewModel.processResult;
      if (processResult != null) {
        context.go('/analysis/${processResult.analysisId}');
      }
    } else if (mounted && analysisViewModel.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(analysisViewModel.error!),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }
}
