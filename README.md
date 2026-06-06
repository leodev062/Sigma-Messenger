# Sigma Messenger

A nova era da comunicação privada e segura. Simples, rápido e elegante.

## 🏗️ Arquitetura do Projeto

O Sigma foi desenvolvido utilizando princípios de **Clean Architecture**, **Side Effects** e **POO**, combinados com o padrão de apresentação **MVVM (Model-View-ViewModel)**. O projeto é modularizado em pacotes independentes para garantir alta escalabilidade e manutenibilidade.

### 📦 Estrutura de Módulos (Packages)

O projeto utiliza uma estrutura multi-repo interna localizada no diretório `packages/`:

*   **`sigma_core`**: O coração do app. Contém utilitários globais, infraestrutura de rede segura (`SigmaNetworkAccess`), sistema de logs e tratamento de erros.
*   **`sigma_auth`**: Módulo de autenticação e registro, refatorado para Clean Architecture. Gerencia sessões, verificação de SMS e onboarding.
*   **`sigma_database`**: Camada de persistência criptografada utilizando **Drift** e **SQLCipher** (AES-256).
*   **`sigma_ui`**: Biblioteca de componentes visuais, serviços de feedback (`FeedbackService`, `SigmaDialogService`) e indicadores de progresso customizados.
*   **`sigma_chat`, `sigma_profile`, `sigma_contacts`, `sigma_settings`**: Módulos de funcionalidades específicas desacoplados.

### 🛡️ Single Source of Truth (SSOT) & Reatividade

*   **Banco de Dados como Autoridade**: A UI observa Streams vindas diretamente do banco local. Não há espera por respostas de rede para atualizar a interface.
*   **Offline-First**: Mensagens e ações são salvas localmente e sincronizadas via **Background Jobs** (SigmaJobManager).
*   **EffectStream Pattern**: Introduzimos um sistema de fluxos para efeitos colaterais (SnackBars, Diálogos, Navegação) que evita loops de reconstrução de UI e garante estabilidade.

## 📱 Experiência de Usuário e UI

*   **Adaptive UI**: Telas de registro e chat totalmente responsivas que se ajustam para **Android, iOS, Web e Windows** (Modos One-Pane e Two-Pane).
*   **Premium Visuals**: Indicadores de progresso circular e linear com design exclusivo de ondas senoidais ("Wavy").
*   **Smart Onboarding**: Suporte a preenchimento automático (Auto-fill) de cartões SIM e formatação inteligente de números de telefone baseada no motor do Google.

## ⚡ Conectividade e Rede

*   **Fail-Fast Interceptor**: Bloqueio instantâneo de requisições quando o dispositivo está offline para economizar bateria e evitar timeouts.
*   **Connectivity Banner**: Notificação global não intrusiva de status de conexão integrada ao núcleo do app.

## 🛠️ Tecnologias Utilizadas

*   **Gerenciamento de Estado**: Provider + ViewModel Reativo.
*   **Injeção de Dependências**: GetIt (Service Locator).
*   **Persistência**: Drift + SQLCipher (Criptografia de nível militar).
*   **Comunicação**: Dio (HTTP/JSON) + WebSockets (Protobuf para E2EE).
*   **Validação**: Phone Numbers Parser (Google standard).

## 🚀 Como Iniciar

1. Certifique-se de ter o Flutter instalado (`flutter doctor`).
2. Clone o repositório.
3. No diretório raiz, execute `flutter pub get`.
4. Devido à modularização, execute `flutter pub get` dentro dos pacotes em `packages/` se necessário (ou use um script de bootstrap).
5. Gere o código necessário: `dart run build_runner build`.
6. Para rodar: `flutter run`.

---
*Focado em privacidade absoluta, segurança inabalável e performance excepcional.*
