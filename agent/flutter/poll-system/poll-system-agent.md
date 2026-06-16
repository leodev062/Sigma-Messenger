# 📊 POLL SYSTEM AGENT (PSA)

## 📌 OBJETIVO

Este agente define toda a lógica de enquetes (polls) dentro do sistema de mensagens em tempo real.

Ele garante:

- 📊 Criação e gerenciamento de enquetes
- ⚡ Votação em tempo real
- 🔄 Atualização instantânea via sync engine
- 🧠 Consistência entre múltiplos dispositivos
- 📱 UI altamente performática
- 💾 Estado baseado em banco local (source of truth)

---

## 🧠 ARQUITETURA BASE

UI (Flutter)
↓
ViewModel (MVVM)
↓
Poll UseCase (Vote Manager)
↓
Repository
↓
Local Database (SOURCE OF TRUTH)
↓
Sync Engine (WebSocket Events)
↓
Server (relay only)

---

## 🧾 MODELO DE DADOS (PROTOBUF)

```proto id="poll002"
message Poll {
  string id = 1;
  string messageId = 2;
  string question = 3;
  bool multipleChoice = 4;
  int64 createdAt = 5;
  int64 updatedAt = 6;
}
🧾 OPÇÕES DA ENQUETE
message PollOption {
  string id = 1;
  string pollId = 2;
  string text = 3;
  int32 voteCount = 4;
}
🧠 VOTO DO USUÁRIO
message PollVote {
  string id = 1;
  string pollId = 2;
  string optionId = 3;
  string userId = 4;
  int64 createdAt = 5;
}
⚙️ REGRAS FUNDAMENTAIS
1. Fonte de verdade
Banco local sempre manda no estado final
Server apenas propaga eventos
2. Voto é evento incremental
Cada voto é um evento independente
Não substitui poll inteira
3. Atualização em tempo real obrigatória
Toda votação atualiza UI instantaneamente
📊 FLUXO DE ENQUETE
📌 Criar enquete
User → UI → ViewModel → DB → Sync Engine → Server
📌 Votar
User taps option
↓
Optimistic update (UI instant)
↓
DB local update
↓
Send vote event to server
📡 Evento server:
{
  "type": "poll_vote",
  "pollId": "123",
  "optionId": "A",
  "userId": "u1"
}
📌 Atualização cliente:
incrementa contador
atualiza gráfico
notifica UI via stream
📱 FLUTTER IMPLEMENTATION RULES
✔ Stream de poll
Stream<Poll> watchPoll(String pollId);
Stream<List<PollOption>> watchPollOptions(String pollId);
✔ Votação otimista
void vote(String pollId, String optionId) {
  updateLocalDB();
  sendVoteToServer();
}

UI atualiza imediatamente sem esperar server.

📊 SISTEMA DE CONTAGEM
✔ regra principal

Contagem NÃO vem do server como fonte única

✔ server envia eventos
✔ client recalcula localmente

algoritmo:
for each vote event:
  increment option.voteCount locally
🔄 MULTI-VOTO (CASO PERMITIDO)

Se multipleChoice = true:

usuário pode votar em várias opções
cada voto é independente

Se false:

voto anterior é removido automaticamente
⚡ REAL-TIME SYNC RULES
Evento recebido:
atualizar DB local
atualizar contadores
recalcular UI
emitir stream update
📱 UI BEHAVIOR
✔ estados visuais:
não votado → opções clicáveis
votado → destaque da opção
resultado → barras animadas
📊 ANIMAÇÃO DE RESULTADO
barras crescem suavemente
porcentagem atualiza em tempo real
transição de estado suave
🧱 ESTRUTURA LOCAL (DB)
Poll table
field	type
id	string
messageId	string
question	string
PollOption table
field	type
id	string
pollId	string
text	string
voteCount	int
PollVote table
field	type
id	string
pollId	string
optionId	string
userId	string
⚡ PERFORMANCE RULES
Nunca rebuild global do chat
Atualizar apenas poll afetado
Streams separadas por pollId
Cache de contagem em memória
Batch updates de votos
🔒 CONSISTÊNCIA

Regra de merge:

if (remote.updatedAt > local.updatedAt)
    update local
else
    ignore
🚨 ANTI-BUG RULES
Nunca duplicar voto
Operações idempotentes obrigatórias
UI nunca depende direto do server
Sempre persistir no DB local primeiro
Evitar inconsistência de contagem