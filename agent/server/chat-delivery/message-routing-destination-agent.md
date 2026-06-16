md
# 🧭 MESSAGE ROUTING DESTINATION AGENT (MRDA)

## 📌 OBJETIVO

Este agente define como o servidor identifica e roteia mensagens para diferentes tipos de destinatários:

- 👤 Usuário individual
- 👥 Grupo
- 📢 Canal
- 🤖 Bot
- 🧠 Sistemas automáticos (IA / serviços)

---

## 🧠 PRINCÍPIO FUNDAMENTAL

```text id="rtg002"
Toda mensagem SEMPRE tem um destinationType + destinationId

O servidor NÃO adivinha destino.

📦 MODELO DE ENVELOPE (CORE DO SERVIDOR)
{
  "messageId": "uuid",
  "from": "user_1",

  "destinationType": "USER | GROUP | CHANNEL | BOT | SYSTEM",
  "destinationId": "string",

  "payload": "protobuf_bytes",
  "timestamp": 123456789
}
🎯 TIPOS DE DESTINO
enum DestinationType {
  USER = 0;     // mensagem privada
  GROUP = 1;    // grupo de usuários
  CHANNEL = 2;  // broadcast (1 → muitos)
  BOT = 3;      // agente automatizado
  SYSTEM = 4;   // eventos internos
}
👤 1. USER (1:1 CHAT)
📌 regra
destinationId = userId do receptor

✔ envio direto
✔ entrega única
✔ sem broadcast

👥 2. GROUP
📌 regra
destinationId = groupId
📡 servidor faz:
busca membros do grupo
replica mensagem para todos
mantém consistência de entrega
📢 3. CHANNEL (broadcast)
📌 regra
destinationId = channelId
comportamento:
1 → muitos (followers)
leitura passiva
sem resposta direta (opcional)
🤖 4. BOT
📌 regra
destinationId = botId
servidor faz:
encaminha para engine do bot
bot pode responder automaticamente
suporta IA / automações
🧠 5. SYSTEM
📌 uso interno
notificações
eventos
updates globais

Ex:

{
  "type": "user_joined_group",
  "groupId": "123"
}
🔄 FLUXO DE ROTEAMENTO
Client sends message
↓
Server reads destinationType
↓
Router engine selects handler
↓
Deliver message accordingly
⚙️ ROUTER ENGINE (CORE SERVER LOGIC)
switch(destinationType):

  USER:
    deliverToSingleUser()

  GROUP:
    deliverToAllMembers()

  CHANNEL:
    broadcastToSubscribers()

  BOT:
    sendToBotEngine()

  SYSTEM:
    processInternally()
📦 REGRAS IMPORTANTES
1. NÃO existe inferência

❌ errado:

server tenta adivinhar destino pelo contexto

✔ correto:

destinationType + destinationId sempre obrigatório
2. ID define tudo
userId → pessoa
groupId → grupo
channelId → broadcast
botId → automação
3. SERVER NÃO TEM LÓGICA DE UI
não decide como aparece
não formata mensagem
só roteia bytes
⚡ GARANTIA DE ENTREGA
at-least-once delivery
retry automático
deduplicação por messageId
🔒 SEGURANÇA
usuário só envia para destinos autorizados
server valida membership (groups/channels)
bots isolados do fluxo humano
📊 RESULTADO FINAL

Com este agente ativo:

✔ mensagens chegam no destino correto
✔ grupos funcionam em escala
✔ canais suportam broadcast
✔ bots funcionam como sistemas independentes
✔ servidor simples, escalável e previsível