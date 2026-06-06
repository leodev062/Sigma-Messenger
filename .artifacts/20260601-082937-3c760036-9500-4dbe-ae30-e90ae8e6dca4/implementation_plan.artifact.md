# Refatoração Geral: Lógica e Serviços Estilo Signal Android

Esta refatoração visa replicar a robustez e o comportamento do Signal Android nas camadas de serviço, dados e sincronização, garantindo que o Sigma Messenger funcione de forma profissional e "idêntica" ao original.

## Propostas de Mudanças

### 1. Sincronização e Resiliência (Job System)

#### [NEW] [reaction_send_job.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/jobs/reaction_send_job.dart)
- Implementar o envio de reações como um trabalho persistente e durável.
- Garantir o envio de reações em background, com retentativas automáticas em caso de falha na rede.

#### [job_manager.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/jobs/job_manager.dart)
- Registrar a nova `ReactionSendJob`.
- Ajustar a lógica de dependências entre jobs para manter a ordem cronológica (ex: não enviar reação se a mensagem original ainda está enviando).

### 2. Processamento de Mensagens e Reações

#### [NEW] [data_message_processor.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/domain/services/data_message_processor.dart)
- Centralizar a lógica de recepção de dados (estilo Signal).
- `handleReaction`: Localizar a mensagem original por `targetAuthor` + `timestamp`, validar permissões e atualizar o banco.
- `handleMessage`: Decifrar e salvar mensagens, disparando notificações.

### 3. Camada de Dados (Repositories & Tables)

#### [message_table.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/database/message_table.dart)
- Refinar `upsertReaction` para garantir a regra: um usuário = uma reação por mensagem.
- Melhorar a atomicidade nas transações de salvamento de mensagens.

#### [chat_repository_impl.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/data/repositories/chat_repository_impl.dart)
- Integrar a `ReactionSendJob` no método `addReaction`.
- Refinar a lógica de carregamento de mensagens para incluir reações de forma eficiente (Batch loading).

### 4. Interação Profissional (UI Logic)

#### [chat_viewmodel.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma-Messenger/lib/features/chat/presentation/viewmodels/chat_viewmodel.dart)
- Ajustar para suportar o estado de "enviando" reações localmente (Optimistic UI).
- Sincronizar reações em tempo real via streams do Drift.

## Plano de Verificação

### Testes Manuais
- **Resiliência de Reações**: Adicionar uma reação em modo avião, desativar o modo avião e verificar se o `ReactionSendJob` é executado com sucesso.
- **Conflito de Reações**: Alterar uma reação rapidamente e verificar se o banco de dados e a interface refletem apenas a última escolha.
- **Recepção de Reações**: Simular a chegada de uma reação via Socket e verificar se o `DataMessageProcessor` a vincula corretamente à mensagem alvo.
