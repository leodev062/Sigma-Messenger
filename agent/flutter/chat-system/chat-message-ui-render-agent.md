
# 💬 CHAT MESSAGE UI RENDER AGENT (CMURA)

## 📌 OBJETIVO

Este agente define como mensagens são exibidas na tela de chat, incluindo:

- 💬 Formato dos balões de mensagens
- 👥 Diferenciação entre usuários, grupos, canais e bots
- 🎨 Estilos visuais dinâmicos
- ⚡ Renderização altamente performática
- 🧠 UI baseada em estado local (DB como source of truth)

---

## 🧠 ARQUITETURA BASE

Local DB (source of truth)
↓
Stream (reactive updates)
↓
ViewModel (MVVM)
↓
UI Renderer (Flutter Widgets)
↓
Message Bubble Factory
↓
Chat Screen

---

## 💬 TIPOS DE CONVERSA

```proto id="ui002"
enum ConversationType {
  DIRECT = 0;   // 1:1 chat
  GROUP = 1;    // grupo
  CHANNEL = 2;  // broadcast
  BOT = 3;      // automação / IA
}
🎨 TIPOS DE MENSAGEM (UI VARIANTE)

Cada mensagem muda aparência dependendo do contexto:

Tipo	Estilo
DIRECT	balão simples
GROUP	com avatar + nome
CHANNEL	estilo broadcast
BOT	estilo sistema / destacado
💬 MESSAGE BUBBLE RULES
📌 Base structure
[avatar] [name]
[message bubble]
[time + status]
🎨 FORMATO DOS BALÕES
👤 1. DIRECT (1:1 chat)
╭───────────────╮
│ mensagem      │  ← alinhado direita/esquerda
╰───────────────╯

✔ sem nome
✔ sem avatar obrigatório
✔ foco total na mensagem

👥 2. GROUP CHAT
👤 João
╭───────────────╮
│ mensagem      │
╰───────────────╯

✔ avatar obrigatório
✔ nome acima da mensagem
✔ alinhamento por usuário

📢 3. CHANNEL (broadcast)
📢 Canal Oficial
╭───────────────╮
│ mensagem      │
╰───────────────╯

✔ mensagens centralizadas
✔ estilo anúncio
✔ sem resposta direta

🤖 4. BOT MESSAGE
🤖 AI Assistant
╭───────────────╮
│ resposta bot  │
╰───────────────╯

✔ destaque visual
✔ fundo diferente (gradient leve)
✔ indicador de automação

🎨 VARIAÇÃO DE ESTILO DO BALÃO
📌 regras visuais
Tipo	Estilo
sender	azul / verde
receiver	cinza
bot	roxo / gradient
system	transparente / centered
⚡ ALINHAMENTO DAS MENSAGENS
eu → direita
outro → esquerda
bot → centro (opcional)
system → centro
🧠 MESSAGE GROUPING (IMPORTANTE)

Mensagens consecutivas do mesmo usuário:

✔ agrupadas visualmente
✔ sem repetir avatar
✔ espaçamento reduzido

Exemplo:
João:
  msg 1
  msg 2
  msg 3
📱 FLUTTER RENDER ENGINE
✔ Factory de balões
Widget buildMessageBubble(Message msg) {
  switch (msg.conversationType) {
    case DIRECT:
      return DirectBubble(msg);

    case GROUP:
      return GroupBubble(msg);

    case CHANNEL:
      return ChannelBubble(msg);

    case BOT:
      return BotBubble(msg);
  }
}
🎨 COMPONENTES PRINCIPAIS
📦 MessageBubble
container base
padding dinâmico
animação leve
👤 AvatarWidget
cacheado
lazy loaded
fallback inicial do nome
⏱ StatusIndicator
PENDING ⏳
SENT ✔
DELIVERED ✔✔ cinza
READ ✔✔ azul
⚡ PERFORMANCE RULES
Nunca rebuild da lista inteira
Usar ListView.builder
Keys obrigatórias (message.id)
Update apenas item modificado
Streams por conversa
🧠 RENDER LOGIC
if message.senderId == currentUser:
    align right
else:
    align left
💬 SYSTEM MESSAGES

Ex:

“João entrou no grupo”
“Mensagem apagada”

✔ centralizado
✔ sem balão
✔ estilo discreto

🔒 CONSISTÊNCIA
UI depende do DB local
Nunca direto da rede
Sync apenas atualiza estado
Merge baseado em updatedAt
🚨 ANTI-BUG RULES
Nunca duplicar mensagens na UI
Nunca rebuild global
Nunca depender de estado de rede
Sempre usar messageId como chave
Sempre respeitar conversationType