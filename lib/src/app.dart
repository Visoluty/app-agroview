import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/analysis_viewmodel.dart';
import 'services/api_service.dart';
import 'services/analysis_service.dart';
import 'theme/app_theme.dart';
import 'ui/pages/login_page.dart';
import 'ui/pages/register_page.dart';
import 'ui/pages/dashboard_page.dart';
import 'ui/pages/capture_page.dart';
import 'ui/pages/analysis_detail_page.dart';
import 'ui/pages/history_page.dart';
import 'ui/pages/profile_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final authViewModel = context.read<AuthViewModel>();
      
      // Se não está autenticado e não está na página de login/registro
      if (!authViewModel.isAuthenticated && 
          !state.matchedLocation.startsWith('/login') && 
          !state.matchedLocation.startsWith('/register')) {
        return '/login';
      }
      
      // Se está autenticado e está na página de login/registro
      if (authViewModel.isAuthenticated && 
          (state.matchedLocation == '/login' || state.matchedLocation == '/register')) {
        return '/dashboard';
      }
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/capture',
        name: 'capture',
        builder: (context, state) => const CapturePage(),
      ),
      GoRoute(
        path: '/analysis/:id',
        name: 'analysis-detail',
        builder: (context, state) {
          final analysisId = state.pathParameters['id']!;
          return AnalysisDetailPage(analysisId: analysisId);
        },
      ),
      GoRoute(
        path: '/history',
        name: 'history',
        builder: (context, state) => const HistoryPage(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppTheme.errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Página não encontrada',
              style: AppTheme.lightTheme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'A página que você está procurando não existe.',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Voltar ao Dashboard'),
            ),
          ],
        ),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) {
            final authViewModel = context.read<AuthViewModel>();
            return AnalysisViewModel(AnalysisService(authViewModel.apiService));
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'AgroView',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
