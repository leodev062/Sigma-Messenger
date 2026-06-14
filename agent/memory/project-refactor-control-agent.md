# 🧠 PROJECT REFACTOR CONTROL AGENT (PRCA)

## 📌 OBJETIVO

Este agente define como o sistema deve ser modificado, refatorado e evoluído
seguindo as regras dos arquivos:

- agent-sigma-app.md (APP)
- agente-server.md (SERVER)
- chat-system-agent.md (core architecture)

---

# ⚠️ REGRA PRINCIPAL (ABSOLUTA)

```text id="ctl002"
NENHUMA alteração no projeto pode ser feita sem confirmação explícita do usuário
```

---

# 🧠 FLUXO OBRIGATÓRIO ANTES DE QUALQUER MUDANÇA

Sempre seguir este fluxo:

## 1. ANALISAR

- ler arquivos existentes da pasta [agent]
- entender regra atual
- identificar impacto

---

## 2. PROPOR

- descrever o que será alterado
- explicar por que
- mostrar impacto no app e server

---

## 3. PEDIR CONFIRMAÇÃO

```text id="ctl003"
ANTES DE ALTERAR QUALQUER COISA, SEMPRE PERGUNTAR:

"Posso aplicar essa mudança?"
```

---

## 4. EXECUTAR (SÓ APÓS OK)

- aplicar refactor
- atualizar arquivos
- manter consistência

---

# 📱 REGRAS PARA O APP (agent-sigma-app.md)

O app deve seguir:

- offline-first
- local DB como source of truth
- UI baseada em streams
- mensagens independentes
- sem dependência do servidor para render

---

# 🌐 REGRAS PARA O SERVER (agente-server.md)

O server deve seguir:

- relay only
- não salva chat
- só envia envelopes
- roteamento por destinationType
- sem lógica de UI
- sem estado de conversa

---

# 🧠 REGRAS DE CONSISTÊNCIA GLOBAL

## ✔ NUNCA quebrar:

- messageId único
- conversationId fixo
- senderId como identidade
- destinationType obrigatório

---

## ❌ NUNCA FAZER:

- alterar schema sem migração
- mudar fluxo sem atualizar app + server juntos
- remover campos sem versão
- aplicar mudanças sem aprovação

---

# 🔄 REGRAS DE REFATORAÇÃO

## Tipos de mudança permitidos:

### ✔ 1. UI refactor
- sem alterar banco
- sem alterar server

---

### ✔ 2. DB evolution
- precisa migração
- precisa compatibilidade

---

### ✔ 3. Server routing change
- precisa atualização do app
- precisa versionamento

---

# 🧱 COMPATIBILIDADE OBRIGATÓRIA

```text id="ctl004"
Toda mudança deve ser backward compatible
```

Se não for possível:

- criar versão nova
- não quebrar dados antigos

---

# ⚡ CHECKLIST ANTES DE ALTERAR

✔ isso afeta app?  
✔ isso afeta server?  
✔ isso quebra DB?  
✔ isso quebra mensagens antigas?  
✔ isso precisa de migração?

---

# 🚨 REGRA DE SEGURANÇA

```text id="ctl005"
Se houver qualquer dúvida → NÃO ALTERAR
```

---

# 🧠 COMPORTAMENTO DO AGENTE

Este agente deve:

- ler sempre agent-sigma-app.md
- ler sempre agente-server.md
- validar consistência
- sugerir mudanças seguras
- nunca aplicar direto

---

# 📊 RESULTADO FINAL

Com este agente ativo:

✔ sistema não quebra com updates  
✔ refatoração controlada  
✔ app e server sempre sincronizados  
✔ evolução segura do projeto  
✔ zero mudanças perigosas não aprovadas  