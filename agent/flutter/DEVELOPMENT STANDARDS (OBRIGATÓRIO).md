# 🏛️ DEVELOPMENT STANDARDS (OBRIGATÓRIO)

## 📌 PRINCÍPIO

Todo código escrito para o projeto deve priorizar:

* legibilidade
* simplicidade
* escalabilidade
* reutilização
* desacoplamento
* testabilidade

Antes de funcionar, o código deve ser fácil de entender.

---

# 🧠 CLEAN ARCHITECTURE

Todo módulo deve seguir obrigatoriamente:

```
Presentation

↓

Domain

↓

Data

↓

Datasource
```

Nunca inverter essa ordem.

A camada superior nunca conhece detalhes internos da inferior.

---

# 🏗️ MVVM

Toda interface deve seguir MVVM.

```
View

↓

ViewModel

↓

UseCase

↓

Repository

↓

Datasource
```

A View nunca implementa regra de negócio.

O ViewModel nunca acessa banco diretamente.

---

# 📦 RESPONSABILIDADE ÚNICA

Cada arquivo deve possuir apenas uma responsabilidade.

Exemplo correto:

```
send_message_usecase.dart

mark_as_read_usecase.dart

delete_message_usecase.dart
```

Evitar arquivos enormes com dezenas de funções.

---

# 📂 ORGANIZAÇÃO DOS ARQUIVOS

Nunca criar arquivos com milhares de linhas.

Meta recomendada:

* até 300 linhas → ideal
* até 500 linhas → aceitável
* acima de 700 linhas → dividir

Se um arquivo crescer demais, extrair novas classes.

---

# 🧩 SEPARAÇÃO DE LÓGICA

Nunca misturar:

* UI
* banco
* websocket
* API
* criptografia
* validações

Cada responsabilidade deve ficar em seu próprio arquivo.

---

# 🎨 UI

Widgets não fazem lógica.

Widgets apenas:

* exibem dados
* recebem eventos
* chamam ViewModel

Nunca chamar Repository diretamente.

---

# 🧠 VIEWMODEL

Responsável apenas por:

* controlar estado
* expor Streams/State
* chamar UseCases

Nunca escrever SQL.

Nunca abrir sockets.

---

# ⚙️ USE CASES

Cada ação importante deve possuir um UseCase próprio.

Exemplo:

```
SendMessageUseCase

DeleteMessageUseCase

UpdateReactionUseCase

VotePollUseCase

CreateGroupUseCase
```

Nunca criar um "ChatService" gigante fazendo tudo.

---

# 🗃️ REPOSITORIES

Repositories são interfaces entre domínio e dados.

Nunca colocar regra de UI.

Nunca retornar Widgets.

---

# 💾 DATASOURCES

Separar:

```
LocalDatasource

RemoteDatasource
```

Nunca misturar SQLite e HTTP no mesmo arquivo.

---

# 🔌 WEBSOCKET

Existe apenas um serviço global.

```
RealtimeService
```

Nenhuma tela cria sockets próprios.

---

# 🔐 LIBSIGNAL

Toda criptografia fica isolada.

```
SignalService

↓

IdentityManager

↓

SessionManager

↓

PreKeyManager
```

Nenhuma tela acessa libsignal diretamente.

---

# 📱 STATE MANAGEMENT

Toda tela observa estado.

Nunca reconstruir interface manualmente.

O estado sempre vem do ViewModel.

---

# 🔄 ASYNC

Nunca bloquear UI.

Toda operação pesada deve ser assíncrona.

Operações de banco e rede devem rodar fora da thread principal.

---

# 📝 NOMENCLATURA

Usar nomes claros.

Bom:

```
SendMessageUseCase
```

Ruim:

```
Manager
Utils
Helper
Data
Temp
```

Evitar nomes genéricos.

---

# 🧹 FUNÇÕES

Uma função deve resolver apenas um problema.

Ideal:

20~30 linhas.

Se ficar grande:

extrair métodos privados.

---

# 🧱 CLASSES

Cada classe deve possuir uma responsabilidade.

Se começa a fazer muitas coisas:

dividir.

---

# 🔁 DUPLICAÇÃO

Nunca copiar código.

Se usado em mais de um lugar:

criar componente compartilhado.

---

# 📦 COMPONENTIZAÇÃO

Widgets reutilizáveis ficam em:

```
shared/widgets
```

Nunca duplicar botões, cards ou avatares.

---

# 🎨 TEMAS

Nunca usar cores fixas.

Sempre utilizar Theme.

Nunca usar valores mágicos.

---

# 📐 CONSTANTES

Todo valor repetido deve virar constante.

Exemplo:

```
AppSizes

AppSpacing

AppRadius

AppDurations
```

---

# 🗂️ ENUMS

Nunca usar strings soltas.

Errado:

```
"type": "group"
```

Correto:

```
ConversationType.group
```

---

# 🧪 TESTABILIDADE

Todo UseCase deve poder ser testado isoladamente.

Toda dependência deve ser injetável.

---

# 🔧 DEPENDENCY INJECTION

Nunca instanciar diretamente:

```
Repository()

ApiClient()

Database()
```

Tudo deve vir do container de DI.

---

# 📊 LOGGING

Nunca usar:

```
print()
```

Sempre utilizar:

```
LoggerService
```

com níveis:

* debug
* info
* warning
* error

---

# 🚨 TRATAMENTO DE ERROS

Nunca ignorar exceções.

Sempre:

* capturar
* registrar
* retornar erro tratado

---

# 📚 DOCUMENTAÇÃO

Toda classe pública deve possuir documentação.

Métodos complexos devem explicar:

* objetivo
* parâmetros
* retorno

---

# 🔒 SEGURANÇA

Nunca armazenar:

* tokens em texto puro
* chaves privadas fora do armazenamento seguro
* segredos no código

---

# 🚀 PERFORMANCE

Usar:

* paginação
* lazy loading
* cache inteligente
* streams granulares
* atualização incremental

Nunca recarregar listas inteiras por pequenas mudanças.

---

# 🔄 REFATORAÇÃO

Sempre preferir:

extrair módulos

ao invés de aumentar arquivos existentes.

Quando surgir nova funcionalidade:

criar UseCase próprio.

Criar Repository próprio.

Criar Service próprio.

Nunca adicionar dezenas de responsabilidades ao mesmo arquivo.

---

# ✅ RESULTADO ESPERADO

✔ Código limpo

✔ Fácil leitura

✔ Fácil manutenção

✔ Fácil teste

✔ Modular

✔ MVVM

✔ Clean Architecture

✔ Escalável

✔ Reutilizável

✔ Baixo acoplamento

✔ Alta coesão

✔ Fácil expansão para novas funcionalidades

✔ Padrão consistente em todo o APP e SERVIDOR
