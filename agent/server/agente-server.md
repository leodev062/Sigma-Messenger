MESSAGE SYSTEM — SERVER + PROTOCOL MEMORY (UPDATED)
📌 VISÃO GERAL DO SISTEMA

O sistema é composto por:

📱 Client (App)
Offline-first
Banco local como fonte de verdade
Sync em background
🌐 Server (Relay Messaging Engine)
Atua APENAS como mensageiro intermediário seguro
NÃO processa regras de negócio complexas
NÃO mantém estado de UI
Apenas roteia e armazena envelopes
⚡ 1. SERVIDOR — ARQUITETURA (RELAY ONLY)
🎯 Função do servidor

O servidor funciona como:

📨 Entregador de mensagens
📦 Armazenador temporário (envelope store)
🔁 Sistema de retry de entrega
🟢 Detector de online/offline
🚫 O QUE O SERVIDOR NÃO FAZ
Não controla UI
Não decide regras de negócio
Não processa lógica de mensagens
Não reescreve conteúdo
🔄 FLUXO PRINCIPAL
CLIENT → SERVER → (CHECK ONLINE)
├── ONLINE → DELIVER IMMEDIATELY
└── OFFLINE → STORE ENVELOPE → DELIVER LATER
📦 SISTEMA DE ENVELOPE (CORE)
{
"envelopeId": "uuid",
"from": "userId",
"to": "userId",
"payload": "protobuf_bytes",
"status": "pending | delivered | failed",
"createdAt": "timestamp",
"deliverAt": "timestamp"
}
🧠 REGRAS DO RELAY SERVER
Mensagem nunca é perdida
Entrega garantida (at-least-once delivery)
Deduplicação por messageId
Persistência obrigatória até confirmação de entrega
Retry automático quando destinatário voltar online
🔁 SISTEMA DE ENTREGA
if recipient.isOnline():
deliver(message)
markDelivered()
else:
storeEnvelope()
waitForOnlineEvent()
deliverLater()
📡 2. SISTEMA DE PROTOCOLO — PROTOBUF (SYNC APP + SERVER)
🎯 Objetivo

Criar um protocolo único para:

App ↔ Server
Sync de mensagens
Compatibilidade entre versões
Alta performance binária
📦 3. PROTOBUF — MESSAGE CORE
syntax = "proto3";

package messaging;

message Message {
string id = 1;
string conversationId = 2;
string senderId = 3;
string receiverId = 4;

MessageType type = 5;

int64 timestamp = 6;
int64 updatedAt = 7;

MessageStatus status = 8;

oneof content {
TextContent text = 9;
ImageContent image = 10;
VideoContent video = 11;
AudioContent audio = 12;
PollContent poll = 13;
ReplyContent reply = 14;
ReactionContent reaction = 15;
}
}
🧾 4. TIPOS DE MENSAGEM
enum MessageType {
TEXT = 0;
IMAGE = 1;
VIDEO = 2;
AUDIO = 3;
POLL = 4;
REPLY = 5;
REACTION = 6;
}
🧠 STATUS
enum MessageStatus {
PENDING = 0;
SENT = 1;
DELIVERED = 2;
READ = 3;
FAILED = 4;
}
📝 5. CONTEÚDOS SUPORTADOS
🟢 TEXTO
message TextContent {
string text = 1;
}
🖼️ IMAGEM
message ImageContent {
string url = 1;
string thumbnail = 2;
int32 width = 3;
int32 height = 4;
}
🎥 VÍDEO
message VideoContent {
string url = 1;
string thumbnail = 2;
int64 duration = 3;
}
🎧 ÁUDIO
message AudioContent {
string url = 1;
int64 duration = 2;
}
📊 ENQUETE (POLL)
message PollContent {
string question = 1;
repeated PollOption options = 2;
bool multipleChoice = 3;
}

message PollOption {
string id = 1;
string text = 2;
int32 votes = 3;
}
💬 RESPOSTA (REPLY)
message ReplyContent {
string messageId = 1;
string previewText = 2;
}
❤️ REAÇÃO
message ReactionContent {
string messageId = 1;
string emoji = 2;
}
🔄 6. SYNC ENGINE (APP ↔ SERVER)
📱 FLUXO
APP DB → SERIALIZE PROTOBUF → SEND SERVER
SERVER → STORE/ROUTE → DELIVER
SERVER → CONFIRMATION → APP UPDATE LOCAL DB
🧠 REGRA DE SINCRONIZAÇÃO
App sempre envia protobuf binário
Server nunca altera payload
Apenas roteia e armazena envelope
Confirmações atualizam status local
⚡ 7. SISTEMA DE ENQUETES (REALTIME UPDATE)
Votes são atualizados incrementalmente
Server apenas propaga eventos
App recalcula estado local
User Vote → Server → Broadcast → Clients → Local Update
📦 8. GARANTIA DE ENTREGA
At-least-once delivery
Deduplicação por messageId
Envelope persistente até ACK
Retry automático
🔒 9. SEGURANÇA (RELAY MODE)
Payload criptografado (opcional E2E future)
Server não interpreta conteúdo
Apenas roteia bytes protobuf
Autenticação obrigatória por token
🧠 10. RESULTADO DO SISTEMA

Com essa arquitetura você tem:

⚡ Mensageiro ultra rápido
📦 Sistema offline + online híbrido
🔁 Sync confiável tipo WhatsApp/Telegram
🧱 Protocolo binário eficiente (Protobuf)
📊 Suporte nativo a mídia + polls + replies
🔒 Servidor simples, escalável e seguro