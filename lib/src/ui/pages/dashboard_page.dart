import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../theme/app_theme.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/analysis_viewmodel.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnalysisViewModel>().loadRecentAnalyses();
      context.read<AnalysisViewModel>().loadAnalysisStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        title: Row(
          children: [
            const Icon(
              Icons.agriculture,
              color: AppTheme.secondaryGreen,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'Dashboard',
              style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                color: AppTheme.primaryGreen,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              onPressed: () {
                // TODO: Implementar notificações
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notificações em desenvolvimento')),
                );
              },
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: AppTheme.secondaryGreen,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header com título e perfil
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AgroView',
                          style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                        Text(
                          'Sistema de Classificação',
                          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.lightText,
                          ),
                        ),
                      ],
                    ),
                    Consumer<AuthViewModel>(
                      builder: (context, authViewModel, child) {
                        return GestureDetector(
                          onTap: () => context.go('/profile'),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              color: AppTheme.secondaryGreen,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Card de análises hoje
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Consumer<AnalysisViewModel>(
                  builder: (context, analysisViewModel, child) {
                    final stats = analysisViewModel.stats;
                    return Container(
                      width: double.infinity,
                      height: 128,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppTheme.secondaryGreen, AppTheme.lightGreen],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Análises Hoje',
                                    style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${stats?.totalAnalyses ?? 0}',
                                    style: AppTheme.lightTheme.textTheme.displayMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '+12% vs ontem',
                                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.analytics,
                              color: Colors.white,
                              size: 64,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              
              // Grid de ações
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildActionCard(
                      icon: Icons.add_circle_outline,
                      title: 'Nova Análise',
                      subtitle: 'Classificar grãos',
                      color: AppTheme.secondaryGreen,
                      onTap: () => context.go('/capture'),
                    ),
                    _buildActionCard(
                      icon: Icons.history,
                      title: 'Histórico',
                      subtitle: 'Ver análises',
                      color: AppTheme.impurityColor,
                      onTap: () => context.go('/history'),
                    ),
                    _buildActionCard(
                      icon: Icons.compare_arrows,
                      title: 'Comparar',
                      subtitle: 'Lotes',
                      color: AppTheme.moldyColor,
                      onTap: () {
                        // TODO: Implementar comparação
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Funcionalidade em desenvolvimento')),
                        );
                      },
                    ),
                    _buildActionCard(
                      icon: Icons.assessment,
                      title: 'Relatórios',
                      subtitle: 'Gerar dados',
                      color: AppTheme.limeGreen,
                      onTap: () {
                        // TODO: Implementar relatórios
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Funcionalidade em desenvolvimento')),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Análises recentes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Análises Recentes',
                          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go('/history'),
                          child: const Text('Ver todas'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Consumer<AnalysisViewModel>(
                      builder: (context, analysisViewModel, child) {
                        if (analysisViewModel.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        
                        final recentAnalyses = analysisViewModel.recentAnalyses;
                        
                        if (recentAnalyses.isEmpty) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppTheme.borderColor),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.analytics_outlined,
                                  size: 48,
                                  color: AppTheme.lightText,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Nenhuma análise encontrada',
                                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                                    color: AppTheme.lightText,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Comece fazendo sua primeira análise',
                                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.lightText,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        
                        return Column(
                          children: recentAnalyses.take(2).map((analysis) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _buildAnalysisCard(analysis),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.borderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightText,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisCard(analysis) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => context.go('/analysis/${analysis.id}'),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.borderColor),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.lightCardBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.grain,
                            color: AppTheme.getGrainColor(analysis.grainType),
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${analysis.grainType} - Lote #${analysis.id.substring(0, 8)}',
                              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                                color: AppTheme.primaryGreen,
                              ),
                            ),
                            Text(
                              'Hoje, ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                                color: AppTheme.lightText,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.getGrainColor(analysis.grainType),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Tipo 1',
                        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildMetric('Umidade', '12.5%'),
                    _buildMetric('Impurezas', '1.2%'),
                    _buildMetric('Avariados', '2.8%'),
                  ],
                ),
                const SizedBox(height: 12),
                LinearPercentIndicator(
                  percent: analysis.purityPercentage / 100,
                  width: double.infinity,
                  lineHeight: 8,
                  animation: true,
                  animateFromLastPercent: true,
                  progressColor: AppTheme.getGrainColor(analysis.grainType),
                  backgroundColor: AppTheme.borderColor,
                  padding: EdgeInsets.zero,
                ),
                const SizedBox(height: 8),
                Text(
                  'Qualidade: ${analysis.purityPercentage.toStringAsFixed(0)}% - ${AppTheme.getQualityText(analysis.purityPercentage)}',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.getGrainColor(analysis.grainType),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightText,
            fontSize: 11,
          ),
        ),
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.primaryGreen,
          ),
        ),
      ],
    );
  }
}
