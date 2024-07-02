# Iplementação do algoritmo Bully em flutter

Este repositório contém uma implementação do algoritmo Bully para a eleição de um coordenador em sistemas distribuídos. O algoritmo é simulado em Dart e lida com a eleição de um novo coordenador quando um processo falha ou se recupera de uma falha. Um usuário pode definir 
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
