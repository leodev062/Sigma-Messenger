md
# 🧭 CONVERSATION ROUTING AGENT (CRA)

## 📌 OBJETIVO

Este agente define como o aplicativo identifica o tipo de conversa e decide
como enviar mensagens, renderizar a interface e sincronizar os dados.

Ele garante:

- 👤 Conversas privadas
- 👥 Grupos
- 📢 Canais
- 🤖 Bots
- ⚡ Fluxo único e consistente
- 💾 Banco local como fonte de verdade

---

# 🧠 PRINCÍPIO FUNDAMENTAL

Toda conversa possui um tipo.

O aplicativo NUNCA deve tentar descobrir o tipo baseado no ID.

Sempre utilizar:

- conversationId
- conversationType

---

# 📦 MODELO DA CONVERSA

class Conversation {

    String id;

    ConversationType type;

    String title;

    String avatar;

    String lastMessageId;

    int updatedAt;

}

---

# 📋 ConversationType

enum ConversationType {

    USER,

    GROUP,

    CHANNEL,

    BOT

}

---

# 📌 REGRA PRINCIPAL

Toda mensagem pertence a uma conversa.

A mensagem NÃO decide o tipo.

Quem decide é a Conversation.

---

# 💬 EXEMPLO

Conversation

id = "grp_100"

type = GROUP

↓

Todas as mensagens dessa conversa são tratadas como GROUP.

---

# 📨 ENVIO DE MENSAGEM

Quando o usuário envia:

UI

↓

Conversation

↓

UseCase

↓

Repository

↓

Sync

↓

Server

---

# 📦 PAYLOAD

{

    "conversationId": "grp_100",

    "conversationType": "GROUP",

    "message": { ... }

}

---

# 👤 USER CHAT

conversationType == USER

Destino:

recipientId

Renderização:

- balão esquerda/direita
- read receipts
- typing

---

# 👥 GROUP

conversationType == GROUP

Renderização:

- avatar do remetente
- nome acima da mensagem
- replies
- reactions

Envio:

destination = groupId

---

# 📢 CHANNEL

conversationType == CHANNEL

Renderização:

- estilo broadcast
- mensagens do administrador
- seguidores apenas leem
- respostas opcionais

Envio:

destination = channelId

---

# 🤖 BOT

conversationType == BOT

Renderização:

- indicador de bot
- avatar especial
- respostas automáticas

Envio:

destination = botId

---

# 🧠 ROUTER LOCAL

switch(conversation.type)

USER:

sendPrivateMessage()

GROUP:

sendGroupMessage()

CHANNEL:

sendChannelMessage()

BOT:

sendBotMessage()

---

# 📱 UI FACTORY

switch(conversation.type)

USER

→ PrivateChatScreen

GROUP

→ GroupChatScreen

CHANNEL

→ ChannelScreen

BOT

→ BotChatScreen

---

# 🔄 LISTA DE CONVERSAS

Conversation List

↓

Conversation.type

↓

Escolhe:

- ícone
- badge
- avatar
- ações disponíveis

---

# 🎨 IDENTIDADE VISUAL

USER

👤

GROUP

👥

CHANNEL

📢

BOT

🤖

---

# ⚡ CACHE

Toda Conversation fica salva localmente.

Nunca buscar o tipo no servidor para renderizar.

Sempre usar o banco local.

---

# 🔄 CRIAÇÃO DE NOVA CONVERSA

Ao criar:

1. gerar conversationId

2. definir conversationType

3. salvar localmente

4. sincronizar

5. abrir tela

---

# 🚨 ANTI-BUG RULES

Nunca inferir tipo pelo ID.

Nunca usar senderId para descobrir se é grupo.

Nunca assumir que existe apenas um destinatário.

Nunca renderizar sem conhecer conversationType.

Nunca salvar mensagens sem conversationId.

---

# 📊 RESULTADO

Com este agente ativo:

✔ Cada conversa possui identidade própria

✔ O app sabe exatamente como renderizar

✔ O envio é roteado corretamente

✔ A UI muda automaticamente conforme o tipo

✔ O código fica escalável para novos tipos de conversa

✔ Evita bugs de mensagens indo para o destino errado
🏗️ Recomendação de arquitetura

O ideal é que a tabela Conversation seja a responsável por definir o comportamento do chat. Um exemplo de estrutura seria:

Conversation
├── id
├── type (USER | GROUP | CHANNEL | BOT)
├── title
├── avatar
├── participants
├── permissions
├── settings
└── lastMessageId

Message
├── id
├── conversationId
├── senderId
├── content
├── status
└── timestamp