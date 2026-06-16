# 🧠 MEMORY AGENT (SIGMA MESSENGER) 

senpre tudo que for adiciona ou fazer tem que sergui os arquivo [DEVELOPMENT STANDARDS (OBRIGATÓRIO).md] ,tudo isso tem que ta salvo em sua memoria

Este é o agente central de memória e controle do projeto Sigma Messenger. Ele consolida as regras de desenvolvimento, arquitetura do servidor e arquitetura do aplicativo.

---

## 🏛️ PADRÕES DE DESENVOLVIMENTO (OBRIGATÓRIO)

### 🧠 Clean Architecture & MVVM
Todo o código deve seguir rigorosamente as camadas:
`Presentation -> Domain -> Data -> Datasource`.
A View nunca implementa lógica de negócio; o ViewModel controla o estado e chama UseCases.

### 📦 Responsabilidade Única
Cada arquivo e função deve ter apenas uma responsabilidade. Evite arquivos gigantes (meta: < 300 linhas).

### 🧩 Desacoplamento
- Use Injeção de Dependência.
- Separe lógica de UI, banco, rede e criptografia.
- Widgets são burros; apenas exibem dados e notificam eventos.

---

## 🌐 ARQUITETURA DO SERVIDOR

O servidor atua como um **Relay Server** (apenas encaminha mensagens).

- **Stateless/Relay Only:** O servidor não salva o conteúdo das mensagens.
- **Roteamento por EntityType:** O roteamento é baseado em `destinationType` (USER, GROUP, CHANNEL, BOT).
- **Sem Lógica de UI:** O servidor apenas entrega envelopes de mensagens aos destinos corretos.

---

## 📱 ARQUITETURA DO APP (FLUTTER)

O aplicativo segue uma filosofia **Offline-First**.

- **Source of Truth:** O banco de dados local (SQLite) é a única fonte de verdade para a UI.
- **UI Reativa:** Baseada em Streams que observam o banco local.
- **Independência do Servidor:** A renderização de mensagens e conversas não depende de respostas imediatas do servidor.

---

## 🆔 IDENTIDADE E ROTEAMENTO (EIRA)

- **ID Global Único:** Toda entidade tem um ID imutável (usr_, grp_, chn_, bot_).
- **EntityType Explícito:** Nunca deduzir o tipo pelo formato do ID. Sempre use `destination_type`.
- **Independência de Metadados:** Username e telefone podem mudar; o ID permanece o mesmo.

---

## ⚠️ CONTROLE DE REFATORAÇÃO (PRCA)

1. **Nenhuma alteração sem confirmação:** Nunca aplicar mudanças sem aprovação explícita do usuário.
2. **Backward Compatibility:** Toda mudança no DB ou protocolo deve ser compatível com versões anteriores.
3. **Checklist:** Validar impacto no APP e no SERVER antes de qualquer modificação.

---

## 📂 ESTRUTURA DA PASTA AGENT

- `agent/memory_agent.md`: Este arquivo (Raiz).
- `agent/server/`: Regras e especificações do servidor e roteamento.
- `agent/flutter/`: Regras de UI, estados, e sistemas específicos do app (Chat, Polls, Reactions, etc).

---

## 🚨 REGRAS CRÍTICAS DE SEGURANÇA

- Nunca armazenar chaves privadas ou segredos fora do armazenamento seguro.
- semple atualiza o servidor e o app pra sempre ficar sicronizado os pro etc
- Em caso de dúvida sobre qualquer mudança: **NÃO ALTERAR** e consultar o usuário.
