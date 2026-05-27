# Sigma Messenger

A nova era da comunicação privada e segura. Simples, rápido e elegante.

## 🏗️ Arquitetura do Projeto

O Sigma foi desenvolvido utilizando princípios de **Clean Architecture** combinados com o padrão de apresentação **MVVM (Model-View-ViewModel)**, seguindo as melhores práticas recomendadas pela Google e pela comunidade Flutter.

### 🛡️ Single Source of Truth (SSOT)

A arquitetura do Sigma foi projetada para que o **Banco de Dados Local (Drift/SQLite)** seja a única autoridade (Fonte de Verdade) para os dados exibidos na interface.

*   **Reatividade Total**: A UI não espera respostas de rede para se atualizar. Ela observa Streams vindas diretamente do banco de dados.
*   **Offline-First**: Mensagens enviadas sem conexão são salvas instantaneamente como `pendentes` no banco. O sistema de **Background Jobs** encarrega-se da entrega assim que a rede for restabelecida.
*   **Integridade**: Dados recebidos via WebSocket são processados em background e persistidos no banco. A interface reage automaticamente a essas inserções, garantindo uma experiência fluida e consistente.

### 📐 Estrutura de Camadas

O projeto está dividido em camadas para garantir a separação de responsabilidades:

1.  **Core (`lib/core/`)**: Lógicas globais, rede segura (`SigmaNetworkAccess`), temas e sistema de logs.
2.  **Domain (`lib/domain/`)**: Camada pura com **Entities**, **Interfaces** e **Interactors**. Define *o que* o app faz.
3.  **Data (`lib/data/`)**: Implementações de repositórios e fontes de dados. Define *como* os dados são persistidos e recuperados.
4.  **Presentation (`lib/features/`)**: UI e ViewModels. Responsáveis pela interação com o utilizador.

## ⚡ Tecnologias Utilizadas

*   **Gerenciamento de Estado**: Provider
*   **Injeção de Dependências**: GetIt (Service Locator)
*   **Banco de Dados**: Drift (SQLite reativo com SQLCipher)
*   **Comunicação de Rede**: Dio (HTTP) + WebSocket (Protobuf)
*   **Conectividade**: Monitoramento inteligente de rede para economia de bateria.
*   **Segurança**: Inspirado no Signal (Criptografia End-to-End, E2EE).

## 🚀 Como Iniciar

1. Certifique-se de ter o Flutter instalado (`flutter doctor`).
2. Clone o repositório.
3. Execute `flutter pub get`.
4. Gere o código do banco: `dart run build_runner build`.
5. Para rodar: `flutter run`.

---
*Este projeto é focado em privacidade, segurança e alta performance.*
