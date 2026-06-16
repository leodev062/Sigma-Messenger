# 🧠 CURRENT USER IDENTITY RENDER AGENT (CUIRA)

## 📌 OBJETIVO

Este agente garante a identificação correta do usuário logado em todo o sistema de chat, evitando bugs de UI como:

- mensagens invertidas (eu vs outros)
- alinhamento errado
- status aplicado no usuário errado
- duplicação de identidade em grupos
- inconsistência em reload/offline

---

## 🧠 PRINCÍPIO FUNDAMENTAL

### ✔ REGRA DE OURO

```text id="usr002"
UI NUNCA decide quem é "eu"
UI só renderiza baseado no userId do estado global autenticado
🔐 FONTE DE VERDADE DO USUÁRIO

O usuário logado vem SEMPRE de:

Auth Service
Secure Storage (token decode)
Session Manager
📦 Modelo obrigatório
class CurrentUser {
  final String id;
  final String name;
  final String avatar;
}
⚙️ REGRAS CRÍTICAS
1. NUNCA comparar por nome

❌ errado:

if (message.senderName == "joao")

✔ correto:

if (message.senderId == currentUser.id)
2. IDENTIDADE GLOBAL ÚNICA
currentUser.id = referência absoluta do sistema

Nada mais pode ser usado como identidade.

3. TODA MESSAGE TEM DONO
message Message {
  string id = 1;
  string senderId = 2;
}
💬 REGRA DE RENDERIZAÇÃO (UI)
✔ determinação de lado do balão
bool isMe = message.senderId == currentUser.id;
📱 UI RESULTADO
condição	posição
isMe = true	direita
isMe = false	esquerda
👥 GRUPOS (CASO CRÍTICO)

Em grupos:

✔ cada mensagem compara individualmente
✔ nunca usa “last sender global”
✔ nunca cacheia “eu vs outro” por conversa

⚠️ ERRO COMUM (QUE VOCÊ ESTÁ EVITANDO)

❌ BUG clássico:

app assume "última mensagem enviada = eu"
→ quebra quando sincroniza

✔ solução:

cada mensagem é independente via senderId
🔄 RELOAD / OFFLINE SAFETY

Ao recarregar app:

pegar currentUser do auth
reconstruir UI SOMENTE via senderId
nunca persistir "isMe" no banco
💾 BANCO LOCAL (REGRA IMPORTANTE)

❌ NÃO armazenar:

isMe: true/false

✔ armazenar apenas:

senderId
⚡ PERFORMANCE RULE
comparação deve ser O(1)
sempre baseada em id
nunca lookup por string pesada
📱 FLUTTER IMPLEMENTATION
✔ helper global obrigatório
class Identity {
  static String currentUserId = "";
}
✔ uso na UI
bool isMe(Message msg) {
  return msg.senderId == Identity.currentUserId;
}
🎨 UI DECISION TREE
if senderId == currentUserId:
    align right
    color primary
    show ticks

else:
    align left
    show avatar
🚨 ANTI-BUG RULES
nunca usar nome/email pra identidade
nunca confiar em cache de UI pra "eu"
nunca salvar isMe no banco
nunca inferir usuário por posição na lista
sempre usar senderId