# 💬 CHAT SYSTEM FULL ARCHITECTURE AGENT (CSFA)

## 📌 OBJETIVO

Este agente define toda a arquitetura do sistema de chat:

- 👤 usuários com multi-dispositivo
- 💬 conversas (USER / GROUP / CHANNEL / BOT)
- 📩 mensagens em tempo real
- ❤️ reações
- 📊 enquetes
- 📍 localização live
- 🔁 sync offline-first
- 🌐 servidor como relay (sem salvar chat)

---

# 🧠 ARQUITETURA GERAL

```text id="arch001"
APP (source of truth)
↓
Local DB (messages/users/conversations)
↓
Sync Engine (WebSocket)
↓
SERVER (relay only / envelopes)
↓
OUTRO APP
```

---

# 👤 USERS

```sql id="u001"
CREATE TABLE users (
  id TEXT PRIMARY KEY,
  phone TEXT UNIQUE,
  name TEXT,
  username TEXT UNIQUE,
  email TEXT UNIQUE,
  bio TEXT,
  avatarUrl TEXT,
  isBot BOOLEAN DEFAULT 0,
  createdAt INTEGER,
  updatedAt INTEGER
);
```

---

# 🔐 ACCOUNTS

```sql id="u002"
CREATE TABLE accounts (
  id TEXT PRIMARY KEY,
  userId TEXT,
  email TEXT,
  passwordHash TEXT,
  isVerified BOOLEAN DEFAULT 0,
  createdAt INTEGER
);
```

---

# 📱 DEVICES (MULTI DEVICE SUPPORT)

```sql id="u003"
CREATE TABLE devices (
  id TEXT PRIMARY KEY,
  userId TEXT,
  deviceName TEXT,
  deviceType TEXT,
  os TEXT,
  pushToken TEXT,
  lastSeen INTEGER,
  isActive BOOLEAN DEFAULT 1,
  createdAt INTEGER
);
```

---

# 💬 CONVERSATIONS

```sql id="u004"
CREATE TABLE conversations (
  id TEXT PRIMARY KEY,
  type TEXT, 
  -- USER | GROUP | CHANNEL | BOT

  title TEXT,
  avatar TEXT,

  lastMessageId TEXT,
  updatedAt INTEGER,

  isMuted BOOLEAN DEFAULT 0,
  isPinned BOOLEAN DEFAULT 0,
  isArchived BOOLEAN DEFAULT 0
);
```

---

# 👥 MEMBERS

```sql id="u005"
CREATE TABLE conversation_members (
  id TEXT PRIMARY KEY,
  conversationId TEXT,
  userId TEXT,
  role TEXT,
  joinedAt INTEGER
);
```

---

# 📩 MESSAGES

```sql id="u006"
CREATE TABLE messages (
  id TEXT PRIMARY KEY,
  conversationId TEXT,
  senderId TEXT,

  type TEXT,
  -- TEXT | IMAGE | VIDEO | AUDIO | POLL | REPLY | REACTION | LOCATION

  content TEXT,

  status TEXT,
  -- PENDING | SENT | DELIVERED | READ | FAILED

  replyToMessageId TEXT,
  createdAt INTEGER,
  updatedAt INTEGER
);
```

---

# ❤️ REACTIONS

```sql id="u007"
CREATE TABLE reactions (
  id TEXT PRIMARY KEY,
  messageId TEXT,
  userId TEXT,
  emoji TEXT,
  createdAt INTEGER
);
```

---

# 📊 POLLS

```sql id="u008"
CREATE TABLE polls (
  id TEXT PRIMARY KEY,
  messageId TEXT,
  question TEXT,
  multipleChoice BOOLEAN,
  createdAt INTEGER
);
```

---

# 📊 POLL OPTIONS

```sql id="u009"
CREATE TABLE poll_options (
  id TEXT PRIMARY KEY,
  pollId TEXT,
  text TEXT,
  voteCount INTEGER DEFAULT 0
);
```

---

# 🗳️ POLL VOTES

```sql id="u010"
CREATE TABLE poll_votes (
  id TEXT PRIMARY KEY,
  pollId TEXT,
  optionId TEXT,
  userId TEXT,
  createdAt INTEGER
);
```

---

# 📍 LOCATION

```sql id="u011"
CREATE TABLE message_locations (
  messageId TEXT PRIMARY KEY,
  latitude REAL,
  longitude REAL,
  accuracy REAL,
  isLive BOOLEAN,
  updatedAt INTEGER
);
```

---

# 🔁 OUTBOX (OFFLINE SYNC)

```sql id="u012"
CREATE TABLE outbox_queue (
  id TEXT PRIMARY KEY,
  messageId TEXT,
  payload TEXT,
  status TEXT,
  createdAt INTEGER
);
```

---

# 🌐 SERVER (RELAY ONLY)

```sql id="u013"
CREATE TABLE envelopes (
  envelopeId TEXT PRIMARY KEY,
  messageId TEXT,
  fromUserId TEXT,
  destinationType TEXT,
  destinationId TEXT,
  payload BLOB,
  status TEXT,
  createdAt INTEGER,
  deliverAt INTEGER
);
```

---

# 📊 DELIVERY LOG

```sql id="u014"
CREATE TABLE delivery_log (
  id TEXT PRIMARY KEY,
  messageId TEXT,
  userId TEXT,
  status TEXT,
  timestamp INTEGER
);
```

---

# 🧠 REGRAS PRINCIPAIS

## ✔ SERVER
- não salva chat
- só roteia envelopes

## ✔ APP
- banco principal
- source of truth
- offline-first

---

# ⚡ PRINCÍPIOS DO SISTEMA

- tudo baseado em ID
- nada baseado em UI
- mensagens independentes
- sync eventual consistente
- multi-device suportado

---

# 🚨 ANTI-BUG RULES

- nunca salvar isMe
- nunca inferir tipo de conversa
- nunca duplicar messageId
- nunca depender de rede para UI
- nunca usar nome como identidade

---

# 📊 RESULTADO FINAL

✔ chat escalável tipo WhatsApp/Telegram  
✔ suporte multi-device real  
✔ server leve (relay only)  
✔ offline-first robusto  
✔ pronto para grupos, canais e bots  
✔ arquitetura profissional completa  