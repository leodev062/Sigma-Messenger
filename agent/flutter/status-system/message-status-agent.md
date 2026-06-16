
# 🤖 MESSAGE STATUS SYNC AGENT (MSSA)

## 📌 OBJETIVO

Este agente garante a implementação correta e otimizada do sistema de status de mensagens em um app de chat em tempo real (estilo WhatsApp/Signal/Telegram).

Ele controla:

- Status de mensagens (PENDING, SENT, DELIVERED, READ, FAILED)
- Atualização instantânea de UI
- Sincronização entre client e server
- Read receipts (2 tiques azuis)
- Entrega confiável via relay server
- Consistência com banco local (source of truth)

---

## 🧠 ARQUITETURA BASE

O sistema segue arquitetura obrigatória:

UI (Flutter)
↓
ViewModel (MVVM)
↓
Use Cases
↓
Repository
↓
Local Database (SOURCE OF TRUTH)
↓
Sync Engine (WebSocket / Background Worker)
↓
Relay Server (stateless)

---

## ⚙️ REGRAS FUNDAMENTAIS

### 1. Banco local é a verdade absoluta
- UI nunca depende da rede
- Qualquer status vem do DB local

### 2. Server é apenas relay
- Não altera mensagens
- Não define status final
- Apenas roteia eventos

### 3. Atualização sempre via eventos
- delivered_event
- read_event
- sent_ack_event

---

## 💬 MESSAGE STATUS LIFECYCLE

### 📤 Envio de mensagem

1. Criar mensagem local:

status = PENDING


2. Enviar para server

3. Server confirma:

status = SENT


---

### 📦 Entrega ao destinatário

Quando chega no outro dispositivo:


status = DELIVERED


Server envia evento de confirmação ao remetente.

---

### 👀 Leitura da mensagem

Quando usuário abre conversa:


status = READ


Server faz broadcast do evento READ.

---

## 🔁 FLUXO COMPLETO

Sender App:
PENDING → SENT → DELIVERED → READ

Receiver App:
RECEIVE → DELIVERED → READ

---

## 📡 REAL-TIME EVENT SYSTEM

### Eventos obrigatórios:

#### message_sent_ack
```json
{
  "messageId": "uuid",
  "status": "SENT"
}
message_delivered
{
  "messageId": "uuid",
  "status": "DELIVERED"
}
message_read
{
  "messageId": "uuid",
  "status": "READ",
  "readerId": "userId"
}
📱 FLUTTER IMPLEMENTATION RULES
1. UI reativa obrigatória
Stream-based updates
Nunca rebuild global da lista
2. Atualização de status
updateMessageStatus(messageId, MessageStatus.READ);

Isso deve:

Atualizar DB local
Emitir stream automaticamente
Atualizar UI instantaneamente
3. Optimistic UI

Ao enviar mensagem:

insertMessage(status: PENDING);

UI já mostra imediatamente.

💙 READ RECEIPT (2 TIQUES AZUIS)
Regra:

Quando conversa é aberta:

sendReadReceipt(conversationId);

Fluxo:

App → Server → Sender → DB Update → UI Update

⚡ PERFORMANCE RULES
Nunca recriar lista inteira
Atualizar apenas item modificado (diff por messageId)
Usar keys estáveis
Paginação obrigatória
Streams reativos do DB
🔒 CONSISTÊNCIA
Regra de merge:
if (remote.updatedAt > local.updatedAt)
    update local
else
    ignore
🚨 ANTI-BUG RULES
Nunca duplicar mensagem
Nunca depender da rede para UI
Nunca alterar status sem persistir no DB
Todas operações devem ser idempotentes