# Iplementação do algoritmo Bully em flutter

O repositório bully contém uma implementação do algoritmo Bully para a eleição de um coordenador em sistemas distribuídos. O algoritmo é simulado em Dart e lida com a eleição de um novo coordenador quando um processo falha ou se recupera de uma falha. Um usuário pode definir 
o número de processos a serem executados, o botão "iniciar eleição" para o envio de mensagens do coordenador atual, quando um processo qualquer envia uma mensagem para esse coordenador e não recebe uma resposta ele inicia uma eleição para definir um novo coordernador. A eleição
garante que o processo ativo com maior ID se torne o novo coordenador e passe a receber as mensagens de outros processos. Existe também um botão que retorna o antigo coordenador ao estado ativo novamente, uma nova eleição é realizada.

## Estrutura do Projeto

- **BullyAlgorithm**: Classe principal que implementa o algoritmo de eleição.
- **Process**: Classe que representa cada processo no sistema distribuído.
- **Message**: Classe para mensagens trocadas entre processos.
- **MessageType**: Enumeração que define os tipos de mensagens (geral, falha, recuperação, eleição, ok, coordenador).

## Funcionalidades

- **Inicialização de Processos**: Cria uma lista de processos com o número especificado.
- **Falha de Processo**: Simula a falha de um processo e inicia uma eleição para escolher um novo coordenador.
- **Recuperação de Processo**: Simula a recuperação de um processo e inicia uma nova eleição.
- **Execução de Eleição**: Executa o algoritmo de eleição para determinar o novo coordenador após uma falha ou recuperação de processo.

# Sequenciador móvel em flutter

O repositório sequenciador_movel contém uma implementação em Flutter de um sistema de sequenciamento de mensagens para simulações de processamento assíncrono e ordenação de mensagens em sistemas distribuídos. A lógica implementada permite simular o envio e recebimento de mensagens entre clientes e destinatários através de um sequenciador. O usuário pode definir quais mensagens devem ser enviadas em 3 clientes diferentes, o sequenciador ativo reorganiza as mensagens, e as envia para os 3 receptores, o primeiro receptor a terminar o processamento informa outros receptores que terminou e retorna o resultado para o sequenciador. 

## Estrutura do Projeto

- **SequencerLogic**: Classe principal que gerencia a lógica de sequenciamento.
- **Sequencer**: Classe que representa um sequenciador no sistema.
- **Client**: Classe que representa os clientes que enviam mensagens.
- **Recipient**: Classe que representa os destinatários das mensagens.

## Funcionalidades

- **Envio de Mensagens**: Permite que clientes ativos enviem mensagens que são reordenadas pelo sequenciador.
- **Processamento de Mensagens**: Simula o processamento das mensagens pelos destinatários de forma assíncrona.
