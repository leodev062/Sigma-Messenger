# Arquitetura do Módulo Home

Este documento descreve a organização e os algoritmos da tela principal (`HomeScreen`) seguindo princípios de POO e Clean Architecture.

## Componentes

### 1. HomeTab (Modelo/Configuração)
Localizado em `lib/presentation/models/home_tab.dart`.
Um `enum` que centraliza todas as informações das abas:
- Ícones (normal e selecionado)
- Rótulos traduzidos
- Widget da View correspondente

**Benefício**: Facilita a expansão. Para adicionar uma nova aba, basta adicionar um item ao `enum` e o compilador solicitará a implementação das propriedades necessárias.

### 2. HomeViewModel (Gerenciamento de Estado)
Localizado em `lib/presentation/viewmodels/home_viewmodel.dart`.
Gerencia o estado da navegação e o status da conexão socket.
- Utiliza o padrão `State` imutável (`HomeState`).
- Notifica os ouvintes apenas quando necessário.
- Encapsula a lógica de restauração da última aba aberta.

### 3. SigmaBottomNavigationBar (Widget customizado)
Localizado em `lib/presentation/widgets/sigma_bottom_navigation_bar.dart`.
Implementa o design visual solicitado (Opção 2 da imagem de referência).
- Estilo clássico com rótulos sempre visíveis.
- Cores dinâmicas baseadas no `ColorScheme` do tema.
- Separação total da lógica de construção da barra do resto da tela.

### 4. HomeScreen (Orquestrador)
Localizado em `lib/presentation/pages/home_screen.dart`.
Agora atua apenas como um "casca" (`Scaffold`), delegando responsabilidades para componentes menores:
- `_HomeAppBar`: Especializado na barra superior.
- `IndexedStack`: Exibe a View da aba ativa através do `HomeTab`.
- `_HomeFloatingActionButton`: Especializado no botão de ação rápida.

## Fluxo de Navegação

1. O usuário toca em um item na `SigmaBottomNavigationBar`.
2. A barra chama o callback `onTabSelected`.
3. O `HomeScreen` repassa a nova aba para o `HomeViewModel.setTab()`.
4. O `HomeViewModel` atualiza o estado e persiste a preferência no `SigmaStore`.
5. O `HomeScreen` reconstrói, atualizando o `IndexedStack` e o título do `AppBar`.

## Como Expandir

- **Adicionar Nova Aba**: Edite `lib/presentation/models/home_tab.dart`.
- **Mudar Design do Menu**: Edite `lib/presentation/widgets/sigma_bottom_navigation_bar.dart`.
- **Alterar Lógica de Login/Status**: Edite `lib/presentation/viewmodels/home_viewmodel.dart`.
