d
# 🖼️ AVATAR LOADING & FALLBACK AGENT (ALFA)

## 📌 OBJETIVO

Este agente define como o sistema deve carregar e exibir imagens de avatar de usuários.

Ele garante:

- 🖼️ Carregamento de avatar via URL
- ⚡ Renderização imediata sem quebrar UI
- 🔁 Fallback automático em caso de erro
- 🔤 Inicial do nome como substituto
- 🎨 Cor de fundo consistente por usuário
- 📱 UI estável em todos os estados (loading, error, empty)

---

## 🧠 REGRA PRINCIPAL

```text id="avt003"
Avatar NUNCA pode ficar vazio ou quebrar UI
🔄 FLUXO DE CARREGAMENTO
📍 1. Tenta carregar imagem
if (avatarUrl != null)
    load image from network
❌ 2. Se falhar ou não existir
fallback → generateInitialAvatar(name)
🔤 FALLBACK POR INICIAL

Se não existir imagem:

João → "J"
Maria → "M"
Unknown → "?"
🎨 COR DE FUNDO (CONSISTENTE)
📌 regra:

A cor deve ser sempre a mesma para o mesmo usuário.

color = hash(userId) % paletteColors.length
🎨 exemplo de palette:
azul
verde
roxo
laranja
vermelho
rosa
ciano
⚡ ALGORITMO COMPLETO
if (avatarUrl valid AND image loads):
    show image

else:
    show initial avatar:
        letter = firstLetter(name)
        background = deterministicColor(userId)
📱 FLUTTER IMPLEMENTATION
✔ Widget principal
Widget buildAvatar(User user) {
  return CircleAvatar(
    backgroundImage: NetworkImage(user.avatarUrl),
    onBackgroundImageError: (_, __) {
      // fallback automático
    },
    child: user.avatarUrl == null
        ? Text(getInitial(user.name))
        : null,
    backgroundColor: getColor(user.id),
  );
}
🔤 FUNÇÃO DE INICIAL
String getInitial(String name) {
  if (name.isEmpty) return "?";
  return name.trim().characters.first.toUpperCase();
}
🎨 FUNÇÃO DE COR CONSISTENTE
Color getColor(String userId) {
  final colors = [
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.red,
    Colors.pink,
    Colors.cyan,
  ];

  final index = userId.hashCode % colors.length;
  return colors[index.abs()];
}
⚡ PERFORMANCE RULES
cache de imagem obrigatório
evitar reload desnecessário
usar memory cache (Flutter image cache)
fallback instantâneo sem delay
🚨 ANTI-BUG RULES
nunca deixar avatar vazio
nunca quebrar UI por erro de imagem
nunca usar nome completo como fallback visual
nunca recalcular cor aleatoriamente (deve ser determinística)