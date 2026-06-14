# 🔥 REACTION REALTIME OVERLAY SYSTEM (RR-O)

## 📌 OBJETIVO

Este sistema implementa:

- 💥 Reações em tempo real estilo WhatsApp / Instagram
- 🎭 Overlay animado sobre mensagens
- 🌊 Emojis flutuantes (floating reactions)
- 🧠 Agrupamento inteligente de reações
- ⚡ Atualização instantânea via stream + WebSocket
- 📱 UI ultra leve sem rebuild global

---

## 🧠 ARQUITETURA

UI (Flutter Overlay Layer)
↓
Reaction Overlay Controller
↓
ViewModel (MVVM)
↓
Reaction UseCase
↓
Local DB (source of truth)
↓
Sync Engine (WebSocket events)
↓
Server (relay only)

---

## 💬 CONCEITO DO OVERLAY

O overlay é uma camada visual independente da UI principal:

- Não faz rebuild da lista de mensagens
- Flutua acima da conversa
- Auto remove após animação
- Reage a eventos em tempo real

---

## 🌊 FLUXO DE REAÇÃO EM TEMPO REAL

### ➕ Usuário reage

```text id="rro002"
tap emoji → addReaction()
⚡ Sistema executa:
salva no DB local
envia para server
dispara evento local instantâneo
📡 Server broadcast:
{
  "type": "reaction_added",
  "messageId": "123",
  "emoji": "🔥",
  "userId": "u1"
}
📱 Client recebe:
Atualiza DB
Atualiza contagem
Dispara overlay animation
🎭 OVERLAY ENGINE
✔ Responsabilidade

Gerenciar:

Emojis flutuantes
Animações por mensagem
Agrupamento visual
Timeout de remoção
📦 Estrutura do Overlay Event
class ReactionOverlayEvent {
  final String messageId;
  final String emoji;
  final String userId;
  final int timestamp;
}
🌊 ANIMAÇÃO DE REAÇÃO FLUTUANTE
💡 comportamento
Emoji sobe verticalmente
Leve oscilação lateral
Fade out progressivo
Remove após 1.5–2.5s
🎬 pipeline de animação
spawn emoji
↓
translate Y (-80px to -150px)
↓
opacity 1 → 0
↓
scale 0.8 → 1.2 → 0.5
↓
destroy widget
📱 FLUTTER IMPLEMENTATION (CORE)
🎯 Overlay Controller
class ReactionOverlayController {
  final StreamController<ReactionOverlayEvent> _stream =
      StreamController.broadcast();

  void emit(ReactionOverlayEvent event) {
    _stream.add(event);
  }

  Stream<ReactionOverlayEvent> get stream => _stream.stream;
}
🎭 Overlay Widget Layer
Stack(
  children: [
    ChatScreen(),

    StreamBuilder(
      stream: overlayController.stream,
      builder: (context, snapshot) {
        return FloatingReactionsLayer(event: snapshot.data);
      },
    ),
  ],
)
🌈 FLOATING REACTIONS SYSTEM
✔ comportamento:
múltiplos emojis podem aparecer simultaneamente
cada emoji tem posição aleatória leve
evita sobreposição perfeita (natural feel)
🎯 spawn logic
spawnReaction() {
  offsetX = random(-10px, +10px);
  duration = random(1200ms, 2500ms);
}
🧠 AGRUPAMENTO INTELIGENTE DE REAÇÕES
📌 regra principal

Reações são agrupadas por:

messageId + emoji
📊 exemplo:
🔥 x 12
❤️ x 5
😂 x 20
⚙️ algoritmo de merge
if (reaction exists for messageId + emoji)
    increment count
else
    create new group
⚡ REAL-TIME UPDATE RULES
✔ ao receber evento:
Atualiza DB local
Atualiza contador agrupado
Dispara overlay se for novo evento
Atualiza apenas a mensagem afetada
🔥 PERFORMANCE RULES
Nunca rebuild da lista de chat
Overlay é independente da UI
Usar Stream por messageId
Cache de agrupamento em memória
Batch updates em alta frequência
🧱 DATA MODEL FINAL
Reaction Group
class ReactionGroup {
  final String messageId;
  final String emoji;
  final int count;
}
💙 UX FINAL (COMPORTAMENTO)

Quando usuário reage:

✔ Emoji aparece instantaneamente
✔ Overlay flutua na tela
✔ Contador aumenta em tempo real
✔ Outros dispositivos sincronizam
✔ Animação suave estilo Instagram

🚨 ANTI-BUG RULES
Nunca duplicar reação
Nunca disparar overlay sem persistir DB
Nunca rebuild global do chat
Eventos devem ser idempotentes
Merge sempre baseado em messageId + emoji