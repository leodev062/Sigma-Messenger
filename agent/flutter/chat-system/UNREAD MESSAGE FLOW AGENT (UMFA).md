# 📩 UNREAD MESSAGE FLOW AGENT (UMFA)

## 📌 OBJETIVO

Definir como o sistema deve controlar:

* mensagens não lidas
* contador de não lidas
* leitura de mensagens
* atualização em tempo real
* sincronização entre dispositivos
* comportamento offline
* grupos, canais, bots e conversas privadas

O objetivo é garantir consistência e evitar contadores incorretos.

---

# 🧠 PRINCÍPIO FUNDAMENTAL

```text
O unreadCount é um estado derivado das mensagens locais.

O servidor apenas sincroniza eventos.

O APP é responsável pelo cálculo final.
```

---

# 📊 CADA MENSAGEM POSSUI

```
messageId

conversationId

senderId

serverTimestamp

clientTimestamp

status

readAt

deliveredAt

deleted

edited
```

---

# 👤 CADA CONVERSA POSSUI

```
conversationId

lastMessageId

lastMessageTimestamp

lastReadMessageId

lastReadTimestamp

unreadCount

mentionCount

draft

isMuted

isPinned
```

---

# 🎯 DEFINIÇÃO DE MENSAGEM NÃO LIDA

Uma mensagem é considerada não lida quando:

```
senderId != currentUserId

AND

serverTimestamp > lastReadTimestamp
```

ou

```
messageId > lastReadMessageId
```

Nunca considerar mensagens enviadas pelo próprio usuário.

---

# 🚫 REGRA IMPORTANTE

Mensagens enviadas pelo usuário logado:

```
Nunca aumentam unreadCount.
```

Mesmo em múltiplos dispositivos.

---

# 📥 AO RECEBER UMA NOVA MENSAGEM

Fluxo:

```
Receber

↓

Salvar no banco

↓

Atualizar última mensagem

↓

Verificar sender

↓

Verificar tela aberta

↓

Atualizar unreadCount
```

---

# 📱 CHAT FECHADO

Se a conversa NÃO estiver aberta:

```
unreadCount++
```

---

# 📱 CHAT ABERTO

Se a conversa estiver aberta:

```
não incrementa unreadCount

↓

marca leitura automaticamente
```

---

# 👀 CHAT VISÍVEL

Só marcar como lida quando:

* tela aberta
* conversa ativa
* usuário realmente visualizando

Nunca apenas porque foi carregada.

---

# 🔵 MARCAR COMO LIDA

Ao abrir conversa:

```
lastReadMessageId

↓

última mensagem recebida

↓

lastReadTimestamp atualizado
```

Depois:

```
unreadCount = 0
```

---

# 📡 EVENTO READ RECEIPT

Após atualizar leitura:

Enviar:

```
READ_RECEIPT

conversationId

lastReadMessageId

timestamp
```

para sincronização.

---

# 🌐 SERVIDOR

Servidor apenas encaminha:

```
READ_RECEIPT
```

Nunca recalcula unread.

Nunca mantém contador oficial.

---

# 📱 OUTRO DEVICE

Outro dispositivo recebe:

```
READ_RECEIPT

↓

atualiza lastRead

↓

recalcula unread localmente
```

---

# 🔄 RECÁLCULO

Sempre que necessário:

```
unreadCount =

count(

sender != me

AND

serverTimestamp > lastReadTimestamp

)
```

Nunca confiar apenas em contador salvo.

---

# 🗑️ MENSAGEM APAGADA

Se mensagem apagada estava não lida:

```
recalcular unread
```

Nunca apenas decrementar.

---

# ✏️ MENSAGEM EDITADA

Editar texto:

não altera unread.

---

# ❤️ REAÇÕES

Adicionar reação:

não altera unread.

Opcionalmente pode gerar badge separada.

---

# 📍 LOCALIZAÇÃO AO VIVO

Atualizações de localização:

não contam como nova mensagem.

Não aumentam unread.

---

# 📊 ENQUETAS

Votar:

não incrementa unread.

Criar enquete:

sim, é mensagem.

---

# 👥 GRUPOS

Cada mensagem recebida:

```
sender != me

↓

incrementa unread
```

Até leitura.

---

# 📢 CANAIS

Cada publicação:

incrementa unread.

Mesmo que não haja resposta.

---

# 🤖 BOTS

Mensagens do bot:

tratadas igual usuário.

Se não lidas:

incrementam unread.

---

# 🔕

CONVERSA SILENCIADA

Mute:

não impede unread.

Apenas impede notificações.

---

# 📌 PINNED

Fixar conversa:

não altera unread.

---

# 🏷️ MENÇÕES

Além de unread:

```
mentionCount
```

deve existir separado.

Exemplo:

```
@kaio
```

incrementa mentionCount.

---

# 🔄 SINCRONIZAÇÃO

Cada alteração gera evento:

```
NEW_MESSAGE

READ_RECEIPT

DELETE

EDIT
```

Nunca sincronizar contador.

Sempre sincronizar eventos.

---

# 📱 OFFLINE

Sem internet:

usuário abre conversa

↓

lastRead atualizado localmente

↓

evento fica em fila

↓

envia depois

---

# 📦 OUTBOX

Eventos pendentes:

```
READ_RECEIPT

DELETE

EDIT

REACTION
```

ficam em:

```
outbox_queue
```

---

# 🔁 AO RECONECTAR

Enviar:

todos eventos pendentes

↓

remover da fila após ACK

---

# 🚨 REGRAS ABSOLUTAS

Nunca salvar unread como verdade absoluta.

Sempre permitir recálculo.

Nunca confiar no servidor.

Nunca incrementar unread para mensagens próprias.

Nunca marcar como lida sem visualização.

Nunca depender de push notification para leitura.

Nunca perder eventos offline.

---

# 📈 PERFORMANCE

Lista de conversas:

usar unread salvo.

Quando necessário:

recalcular em background.

Nunca contar milhares de mensagens a cada rebuild.

---

# 📊 BADGE GLOBAL

Badge do aplicativo:

```
Σ unreadCount

de todas conversas

não arquivadas
```

Pode ignorar conversas ocultas conforme configuração.

---

# 🧠 MULTI-DEVICE

Cada READ_RECEIPT:

sincroniza:

```
lastReadMessageId

lastReadTimestamp
```

Todos dispositivos recalculam localmente.

Nunca sincronizar apenas o contador.

---

# 💾 SOURCE OF TRUTH

Banco local.

Sempre.

Servidor apenas replica eventos.

---

# ✅ RESULTADO FINAL

✔ Contador consistente

✔ Sem mensagens fantasmas

✔ Sem contagem duplicada

✔ Offline-first

✔ Multi-device

✔ Compatível com grupos

✔ Compatível com canais

✔ Compatível com bots

✔ Compatível com reações

✔ Compatível com enquetes

✔ Compatível com localização

✔ Recalculo seguro

✔ Sem depender do servidor

✔ Escalável para milhões de mensagens
