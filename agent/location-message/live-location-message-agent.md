
# 📍 LIVE LOCATION MESSAGE AGENT (LLMA)

## 📌 OBJETIVO

Este agente define o sistema de envio de localização em tempo real dentro de mensagens de chat.

Ele permite:

- 📍 Enviar localização fixa (share location)
- 🔴 Enviar localização em tempo real (live location)
- 🗺️ Mostrar mapa dentro da mensagem
- 🔄 Atualização automática da posição no chat
- ⚡ Sync em tempo real entre dispositivos
- 💾 Persistência local como fonte de verdade

---

## 🧠 ARQUITETURA BASE

UI (Flutter Map Message Widget)
↓
Location ViewModel (MVVM)
↓
Location UseCase (Live Tracking Engine)
↓
Repository
↓
Local Database (SOURCE OF TRUTH)
↓
Sync Engine (WebSocket / GPS stream)
↓
Relay Server (only forwards data)

---

## 💬 MESSAGE TYPE

Adicionar ao Message:

```proto id="geo002"
enum MessageType {
  TEXT = 0;
  IMAGE = 1;
  VIDEO = 2;
  AUDIO = 3;
  POLL = 4;
  REPLY = 5;
  REACTION = 6;
  LOCATION = 7;
}
📍 MODELO DE LOCALIZAÇÃO
message LocationContent {
  double latitude = 1;
  double longitude = 2;
  double accuracy = 3;
  int64 timestamp = 4;

  bool live = 5;         // true = atualiza em tempo real
  int32 duration = 6;    // tempo em minutos (ex: 15min, 1h, 8h)
}
🔴 TIPOS DE LOCALIZAÇÃO
📌 1. Localização fixa
enviada uma vez
não muda
mapa estático na mensagem
🔴 2. Live Location (tempo real)
atualiza automaticamente
envia nova posição periodicamente
visível no mapa dentro do chat
🔄 FLUXO DE ENVIO
📍 Envio inicial
User selects "share location"
↓
GPS fetch
↓
Create message (LOCATION)
↓
status = PENDING
↓
send to server
↓
status = SENT
🔴 FLUXO LIVE LOCATION
Quando live = true:
GPS stream ON
↓
a cada X segundos:
  update location
  send delta to server
  update local DB
📡 EVENTO SERVER
{
  "type": "location_update",
  "messageId": "123",
  "latitude": -10.1,
  "longitude": -48.2,
  "timestamp": 123456789
}
📱 UI (MAPA DENTRO DA MENSAGEM)

Cada mensagem LOCATION renderiza:

🗺️ Map Preview Widget
mini mapa embutido
marker do usuário
preview estático ou animado
botão "abrir mapa completo"
🎯 FLUTTER IMPLEMENTATION
✔ Stream de localização
Stream<LocationContent> watchLocation(String messageId);
✔ Widget de mapa na mensagem
class LocationMessageWidget {
  build() {
    return Stack(
      children: [
        MiniMap(
          latitude: data.latitude,
          longitude: data.longitude,
        ),
        LiveIndicator(if live == true)
      ],
    );
  }
}
🔴 LIVE TRACKING ENGINE
✔ regra principal

Se live = true:

start GPS listener
→ emitir posição a cada X segundos
→ atualizar DB local
→ sync via WebSocket
✔ intervalos recomendados
modo	intervalo
high accuracy	2–5s
normal	10s
battery save	20–60s
📊 ATUALIZAÇÃO EM TEMPO REAL

Quando nova posição chega:

atualizar DB local
atualizar marker no mapa
atualizar preview da mensagem
emitir stream UI update
🧠 MERGE DE LOCALIZAÇÃO
if (remote.timestamp > local.timestamp)
    update location
else
    ignore
📍 MAPA INTERATIVO

Ao clicar na mensagem:

abre mapa fullscreen
segue usuário em tempo real (se live)
mostra histórico de movimento (opcional)
⚡ PERFORMANCE RULES
Nunca rebuild da lista de chat
Atualizar apenas widget da mensagem
Map render isolado por messageId
Debounce updates de GPS
Cache de posição atual
🔒 CONSISTÊNCIA
Local DB é fonte de verdade
Server apenas propaga posições
Cliente resolve estado final
Eventos idempotentes obrigatórios
🚨 ANTI-BUG RULES
Não duplicar streams GPS
Não enviar localização sem mudança relevante
Não rebuild global do chat
Não depender da rede para UI
Sempre persistir antes de sync