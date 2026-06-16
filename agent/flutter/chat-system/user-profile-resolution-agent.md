
# 👤 USER PROFILE RESOLUTION AGENT (UPRA)

## 📌 OBJETIVO

Este agente define o sistema de carregamento e resolução de dados de usuários desconhecidos no chat.

Ele garante:

- 👤 Carregamento automático de perfis desconhecidos
- ⚡ UI instantânea sem bloqueio
- 🧠 Cache inteligente de usuários
- 🔄 Sync com servidor em background
- 💾 Persistência local como fonte de verdade
- 🚫 Zero request duplicado para o mesmo usuário

---

## 🧠 PROBLEMA QUE RESOLVE

Quando chega uma mensagem:

```text id="usrp002"
senderId = "user_123"

Mas esse usuário NÃO existe no cache local.

Sem esse sistema você teria:

nome vazio
avatar quebrado
loading infinito
UI bugada na lista de conversas
🧠 ARQUITETURA BASE

UI (Chat / Conversation List)
↓
User ViewModel
↓
User UseCase (Profile Resolver)
↓
User Repository
↓
Local User DB (CACHE FIRST)
↓
Remote API (fallback)
↓
Server

📦 MODELO DE USUÁRIO
class User {
  final String id;
  final String name;
  final String avatar;
  final String username;
  final bool isBot;
}
⚙️ REGRAS FUNDAMENTAIS
1. CACHE FIRST
Sempre tentar buscar usuário no DB local primeiro

Se existir → usar imediatamente
Se não existir → iniciar fetch remoto

2. FETCH ASSÍNCRONO

Nunca bloquear UI:

UI renderiza "placeholder user"
↓
background fetch
↓
update UI quando chegar
3. ANTI DUPLICAÇÃO DE REQUEST
Se request já está em andamento → não repetir

Cache de requests ativos obrigatório.

🔄 FLUXO COMPLETO
📩 Quando chega mensagem
Message received
↓
extract senderId
↓
check local DB
✔ CASO 1: usuário existe
render imediato
sem request
❌ CASO 2: usuário NÃO existe
show placeholder user
↓
enqueue fetchUser(senderId)
↓
call API
↓
store in local DB
↓
emit update stream
📱 UI BEHAVIOR
👤 Placeholder user

Enquanto carrega:

avatar default
nome "Carregando..."
sem bloquear chat
✔ Depois do load
substitui instantaneamente
sem rebuild global
apenas item afetado atualiza
⚡ CONVERSATION LIST RULE (CRÍTICO)

Lista de conversas deve funcionar assim:

Conversation
↓
lastMessage.senderId → resolve User
↓
render name + avatar
🧠 USER RESOLUTION PIPELINE
1. check local cache
2. if exists → return
3. if not exists → fetch remote
4. store locally
5. notify UI stream
💾 CACHE LOCAL (OBRIGATÓRIO)

Tabela users:

field	type
id	string
name	string
avatar	string
username	string
🔄 STREAM REACTIVE UPDATE

Quando user chega do server:

update DB
↓
emit userUpdated(userId)
↓
UI rebuild only affected widgets
⚡ PERFORMANCE RULES
nunca fetch duplicado
nunca bloquear chat UI
nunca reload global lista
cache obrigatório para users
batch requests quando possível
🚨 ANTI-BUG RULES
nunca mostrar senderId na UI
nunca depender de rede para render inicial
nunca deixar avatar null quebrar layout
nunca rebuild chat inteiro ao carregar user