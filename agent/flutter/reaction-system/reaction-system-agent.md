# ❤️ REACTION LOGIC AGENT (RLA)

## 📌 OBJETIVO

Este agente define toda a lógica de reações em mensagens dentro de um sistema de chat em tempo real.

Ele garante:

- Reações consistentes (emoji system)
- Atualização instantânea em tempo real
- Sincronização entre dispositivos
- Alta performance (sem re-render global)
- Estado baseado em banco local (source of truth)

---

## 🧠 ARQUITETURA BASE

UI (Flutter)
↓
ViewModel (MVVM)
↓
Use Case (Reaction Manager)
↓
Repository
↓
Local Database (SOURCE OF TRUTH)
↓
Sync Engine (WebSocket Events)
↓
Server (Relay only)

---

## 💬 MODELO DE REAÇÃO (PROTOBUF / DATA MODEL)

```proto id="rxn002"
message Reaction {
  string id = 1;
  string messageId = 2;
  string userId = 3;
  string emoji = 4;
  int64 createdAt = 5;
  int64 updatedAt = 6;
}
⚙️ REGRAS FUNDAMENTAIS
1. Reação é sempre por messageId
Cada reação pertence a uma mensagem
Uma mensagem pode ter múltiplas reações
2. Uma reação por usuário por emoji (regra padrão)
Evita spam duplicado
Toggle behavior permitido

Exemplo:

👍 + usuário já deu 👍 → remove reação
👍 não existe → adiciona
3. Banco local é fonte de verdade
UI nunca usa estado da rede diretamente
Tudo passa pelo DB local
🔄 FLUXO DE REAÇÃO
➕ Adicionar reação
Usuário clica emoji
UI → ViewModel → UseCase → DB (insert)
Atualiza UI instantaneamente
Sync Engine envia para server
➖ Remover reação
DELETE FROM reactions
WHERE messageId = X AND userId = Y AND emoji = Z
📡 EVENTOS DE SINCRONIZAÇÃO
reaction_added
{
  "messageId": "123",
  "userId": "u1",
  "emoji": "❤️",
  "createdAt": 123456789
}
reaction_removed
{
  "messageId": "123",
  "userId": "u1",
  "emoji": "❤️"
}
⚡ REGRAS DE REAL-TIME

Quando evento chega do server:

1. Aplicar no DB local
2. Emitir stream update
3. Atualizar UI apenas do item afetado
📱 FLUTTER IMPLEMENTATION RULES
✔ Stream por mensagem
Stream<List<Reaction>> watchReactions(messageId);
✔ Inserção otimista (instant UI)
addReaction(messageId, emoji);

UI atualiza imediatamente antes do server confirmar.

✔ Toggle logic
if (existsReaction(userId, emoji)) {
  removeReaction();
} else {
  addReaction();
}
💾 BANCO LOCAL (RECOMMENDED STRUCTURE)

Tabela: reactions

field	type
id	string
messageId	string
userId	string
emoji	string
createdAt	int64

Indexes obrigatórios:

messageId
userId + messageId
⚡ PERFORMANCE RULES
Nunca rebuild global de chat
Atualizar apenas mensagem afetada
Usar diff por messageId
Cache de reações por mensagem
Streams independentes por message
🔒 CONSISTÊNCIA

Regra de merge:

if (remote.updatedAt > local.updatedAt)
    update local
else
    ignore
🚨 ANTI-BUG RULES
Nunca duplicar reação
Nunca confiar apenas no server
Nunca atualizar UI sem persistir no DB
Operações devem ser idempotentes