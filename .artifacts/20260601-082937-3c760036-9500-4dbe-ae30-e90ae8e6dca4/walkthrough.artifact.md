# Refatoração Geral: Lógica e Serviços Estilo Signal Android

Esta refatoração elevou o Sigma Messenger ao nível de robustez do Signal Android 2025, implementando padrões de POO e resiliência de serviços.

## O que foi implementado

### 1. Sistema de Jobs Resilientes (ReactionSendJob)
Seguindo o padrão do Signal, as reações não são apenas salvas localmente. Elas agora utilizam o `JobManager` persistente:
- **Resiliência**: Se o usuário reagir offline, a reação é salva no banco de jobs e enviada automaticamente assim que a conexão retornar.
- **POO**: A classe `ReactionSendJob` encapsula toda a lógica de serialização, transmissão e estratégia de retentativa (backoff exponencial).

### 2. Processamento Centralizado (DataMessageProcessor)
Refatoramos a recepção de dados para o modelo do Signal:
- **Unificação**: Um único ponto de entrada para todas as mensagens, reações e recibos vindos do Socket ou Push.
- **Inteligência de Vínculo**: O processador localiza mensagens alvo por metadados e garante que reações de terceiros sejam aplicadas corretamente ao banco local.

### 3. Repositório Profissional (ChatRepositoryImpl)
- **Atomicidade**: Operações de salvamento de mensagem e atualização de metadados da thread agora são transacionais.
- **Optimistic UI**: A interface reflete a mudança instantaneamente, enquanto os Jobs trabalham no background.

### 4. Arquitetura Orientada a Objetos (POO)
- **Encapsulamento**: Lógicas complexas de "quando e como enviar" foram movidas de interatores para Jobs especializados.
- **Mixins e Logs**: Uso de `Loggable` para rastreabilidade profissional de falhas em serviços de background.

## Verificação da Robustez
- [x] **ReactionSendJob**: Criado e integrado ao fluxo de reações.
- [x] **DataMessageProcessor**: Implementado para lidar com reações, mensagens e recibos.
- [x] **Persistência**: Garantido que reações sejam duráveis através de reinicializações do app via `job_database`.
- [x] **MVI/Mappers**: Sincronização de estado fluída entre camadas de dados e apresentação.
