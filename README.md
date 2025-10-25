# AgroView Mobile App

Aplicativo móvel Flutter para análise de grãos, desenvolvido seguindo a arquitetura MVVM.

## 📱 Funcionalidades

- **Autenticação**: Login e registro de usuários
- **Dashboard**: Visualização de análises recentes e estatísticas
- **Captura de Imagem**: Análise de grãos através de fotos da câmera ou galeria
- **Histórico**: Lista de todas as análises realizadas
- **Detalhes da Análise**: Visualização detalhada dos resultados
- **Perfil**: Gerenciamento de dados do usuário

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework de desenvolvimento móvel
- **Provider**: Gerenciamento de estado
- **Dio**: Cliente HTTP para comunicação com API
- **Go Router**: Navegação entre telas
- **Image Picker**: Captura de imagens da câmera/galeria
- **Shared Preferences**: Armazenamento local de dados
- **Google Fonts**: Tipografia personalizada

## 📋 Pré-requisitos

- Flutter SDK (versão 3.0 ou superior)
- Dart SDK
- Android Studio / Xcode (para desenvolvimento)
- Backend AgroView rodando em `http://localhost:3000`

## 🚀 Instalação e Execução

### 1. Clone o repositório
```bash
git clone <url-do-repositorio>
cd app-agroview
```

### 2. Instale as dependências
```bash
flutter pub get
```

### 3. Gere os arquivos de serialização JSON
```bash
flutter packages pub run build_runner build
```

### 4. Execute o aplicativo

#### Android
```bash
flutter run
```

#### iOS
```bash
flutter run -d ios
```

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── src/
│   ├── app.dart             # Configuração principal do app
│   ├── models/              # Modelos de dados
│   │   ├── user_model.dart
│   │   ├── analysis_model.dart
│   │   └── api_model.dart
│   ├── services/            # Serviços de API
│   │   ├── api_service.dart
│   │   └── analysis_service.dart
│   ├── viewmodels/          # ViewModels (MVVM)
│   │   ├── auth_viewmodel.dart
│   │   └── analysis_viewmodel.dart
│   ├── ui/                  # Interface do usuário
│   │   ├── app_widget.dart
│   │   └── pages/           # Telas da aplicação
│   │       ├── login_page.dart
│   │       ├── register_page.dart
│   │       ├── dashboard_page.dart
│   │       ├── capture_page.dart
│   │       ├── analysis_detail_page.dart
│   │       ├── history_page.dart
│   │       └── profile_page.dart
│   └── theme/               # Tema e cores
│       └── app_theme.dart
```

## 🎨 Design System

O aplicativo segue uma identidade visual com cores terrosas:

- **Verde Primário**: `#2D5016`
- **Verde Secundário**: `#4A7C59`
- **Verde Accent**: `#6B8E23`
- **Marrom Escuro**: `#8B4513`
- **Marrom Médio**: `#D2B48C`
- **Marrom Claro**: `#D4C5A9`
- **Off White**: `#F8F6F0`

## 🔧 Configuração do Backend

Certifique-se de que o backend AgroView esteja rodando em `http://localhost:3000` antes de executar o aplicativo.

Para desenvolvimento local, o aplicativo está configurado para aceitar conexões HTTP não seguras (cleartext traffic).

## 📱 Permissões

### Android
- `INTERNET`: Para comunicação com a API
- `CAMERA`: Para captura de imagens
- `READ_EXTERNAL_STORAGE`: Para acesso à galeria
- `WRITE_EXTERNAL_STORAGE`: Para salvamento de arquivos

### iOS
- `NSCameraUsageDescription`: Para acesso à câmera
- `NSPhotoLibraryUsageDescription`: Para acesso à galeria

## 🧪 Testes

Para executar os testes:
```bash
flutter test
```

## 📦 Build para Produção

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 📞 Suporte

Para suporte, entre em contato através dos issues do GitHub ou email: [seu-email@exemplo.com]