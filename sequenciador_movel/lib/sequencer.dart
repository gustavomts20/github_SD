import 'dart:async';
import 'dart:math';
import 'process.dart';

// A classe define a lógica de um sequenciador de mensagens.
class SequencerLogic {
  // Atributo que guarda o índice do sequenciador atual.
  int currentSequencer = 0;

  // Contador de iterações realizadas.
  int iteration = 1;

  // Lista de sequenciadores inicializados.
  List<Sequencer> sequencers = Sequencer.initializeSequencers();

  // Lista de clientes inicializados.
  List<Client> clients = Client.initializeClients();

  // Lista de destinatários inicializados.
  List<Recipient> recipients = Recipient.initializeRecipients();

  // Função para atualizar a exibição de mensagens na interface.
  Function(String, String) updateMessageDisplay;

  // Função para atualizar a interface do usuário.
  Function() updateUI;

  // Flag que indica se o primeiro destinatário terminou de processar.
  bool isFirstFinished = false;

  // Construtor da classe que requer funções de atualização.
  SequencerLogic({required this.updateMessageDisplay, required this.updateUI});

  // Método para que os clientes ativos enviem mensagens.
  void sendMessage(Map<String, String> clientMessages) {
    // Filtra e mapeia as mensagens dos clientes ativos.
    List<String> messages =
    clients.where((client) => client.isActive).map((client) {
      return clientMessages[client.id] ?? "-";
    }).toList();

    // Reordena as mensagens que são diferentes de "-".
    List<String> reorderedMessages =
    messages.where((msg) => msg != "-").toList().reversed.toList();
    // Processa as mensagens reordenadas.
    processMessage(reorderedMessages, sequencers[currentSequencer].label);
  }

  // Método para processar as mensagens.
  void processMessage(List<String> messages, String sequencerId) {
    // Atualiza a exibição das mensagens.
    updateMessageDisplay(sequencerId, "Reordenado: $messages");
    // Processamento pelos destinatários.
    simulateRecipientsProcessing(messages);
  }

  // Processamento das mensagens pelos destinatários.
  void simulateRecipientsProcessing(List<String> messages) {
    // Define o atraso máximo.
    int maxDelay = 7000;
    isFirstFinished = false;

    // Itera sobre cada destinatário para processar o recebimento de mensagens.
    for (var i = 0; i < recipients.length; i++) {
      updateMessageDisplay(recipients[i].id,
          "${recipients[i].name} recebi as mensagens $messages");
      // Inicia um temporizador para simular o processamento.
      Timer(Duration(milliseconds: Random().nextInt(4000) + 3000), () {
        if (!isFirstFinished) {
          isFirstFinished = true;
          updateMessageDisplay(recipients[i].id,
              "${recipients[i].name} terminou de processar e enviou um OK");
        } else {
          updateMessageDisplay(
              recipients[i].id, "Outro destinatário terminou primeiro");
        }
      });
    }

    // Inicia um temporizador para atualizar o sequenciador e a interface.
    Timer(Duration(milliseconds: maxDelay + 5000), () {
      currentSequencer = (currentSequencer + 1) % sequencers.length;
      iteration++;
      updateUI();
    });
  }
}
