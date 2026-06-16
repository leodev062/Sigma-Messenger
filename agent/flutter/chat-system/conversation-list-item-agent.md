# 💬 CONVERSATION LIST ITEM AGENT (CLIA)

## 📌 OBJETIVO

Este agente define como cada item da lista de conversas deve ser exibido, incluindo:

- 👤 usuário, grupo, canal, bot
- 🔢 contador de mensagens não lidas
- 🧠 prevenção de bugs de duplicação
- 🎨 ícones por tipo de conversa
- ⚡ atualização em tempo real
- 💾 consistência offline-first

---

# 🧠 PRINCÍPIO FUNDAMENTAL

```text id="cli002"
A lista de conversas NUNCA depende da UI para calcular estado
```

Tudo vem do banco local.

---

# 📦 MODELO DO ITEM

```dart id="cli003"
class ConversationItem {
  final String id;
  final String title;
  final String avatar;
  final ConversationType type;

  final String lastMessage;
  final int lastMessageAt;

  final int unreadCount;

  final bool isMuted;
  final bool isPinned;
}
```

---

# 📊 TIPOS DE CONVERSA

```proto id="cli004"
enum ConversationType {
  USER,
  GROUP,
  CHANNEL,
  BOT
}
```

---

# 🎨 ÍCONES POR TIPO

## 📌 regra visual

| tipo | ícone            |
|------|------------------|
| USER | nao mostra icone |
| GROUP | 👥               |
| CHANNEL | 📢               |
| BOT | 🤖               |

---

## 📍 REGRA DE EXIBIÇÃO

O ícone aparece:

```text id="cli005"
à direita do nome da conversa
ou sobreposto no avatar (UI choice)
```

---

# 🔢 CONTADOR DE NÃO LIDAS (CRÍTICO)

## 📌 REGRA PRINCIPAL

```text id="cli006"
unreadCount NUNCA é calculado na UI
```

Ele vem pronto do banco local.

---

## 📦 REGRA DE ATUALIZAÇÃO

### Quando chega mensagem:

```text id="cli007"
message.insert()
↓
if (message.senderId != currentUser)
    increment unreadCount
```

---

### Quando abre conversa:

```text id="cli008"
onOpenConversation:
    unreadCount = 0
    markAllMessagesAsRead()
```

---

# ⚡ PREVENÇÃO DE BUGS

## ❌ PROIBIDO:

- recalcular unread na UI
- usar lastMessage para contar não lidas
- usar lista de mensagens em memória
- depender de stream de UI

---

## ✔ CORRETO:

- unreadCount vem da tabela conversations
- atualizado pelo message sync engine
- persistido no DB local

---

# 📱 REGRA DE UPDATE EM TEMPO REAL

Quando nova mensagem chega:

```text id="cli009"
1. insert message
2. update conversation.lastMessage
3. increment unreadCount
4. emit stream update only for that item
```

---

# 📌 MENTALIDADE CORRETA

```text id="cli010"
Conversation item = snapshot do estado do chat
```

---

# 🔄 CASO ESPECIAL: MENSAGEM DO PRÓPRIO USER

```text id="cli011"
if senderId == currentUserId:
    unreadCount NÃO muda
```

---

# 🔕 MUTED CHATS

Se conversation.isMuted == true:

- não mostrar badge vermelho forte
- pode mostrar badge cinza leve
- não disparar notificação sonora

---

# 📌 PINNED CHATS

Se isPinned == true:

- fixa no topo
- ignorar ordenação por última mensagem

---

# 🚨 ANTI-BUG RULES

- nunca recalcular unread na lista
- nunca usar UI state como fonte de verdade
- nunca duplicar increment de unread
- nunca resetar unread sem abrir conversa
- nunca confiar em cache de widget

---

# 📊 PERFORMANCE RULES

- update apenas item afetado
- usar key por conversationId
- stream granular por conversa
- evitar rebuild global da lista

---

# 🧠 RESULTADO FINAL

Com este agente:

✔ lista de conversas estável  
✔ contador de não lidas correto sempre  
✔ sem bugs de duplicação  
✔ ícones corretos por tipo  
✔ performance alta (tipo WhatsApp)  
✔ atualização em tempo real sem reload geral  