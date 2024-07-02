import 'dart:async';
import 'dart:math';
import 'process.dart';

class BullyAlgorithm {
  List<Process> processes = [];
  int n = 0;
  List<Message> messages = [];

  /** Adiciona uma mensagem à lista de mensagens. */
  void addMessage(int senderId, int destinationId,
      {MessageType type = MessageType.general}) {
    messages.add(
        Message(senderId: senderId, destinationId: destinationId, type: type));
  }

  /** Inicializa a lista de processos com o número especificado de processos. */
  void initializeProcesses(int numberOfProcesses) async {
    await Future.delayed(const Duration(seconds: 3));
    n = numberOfProcesses;
    processes = List.generate(n, (i) => Process(i));
    messages.clear();
  }

  /** Simula a falha de um processo e executa uma eleição. */
  Future<void> failProcess() async {
    await Future.delayed(const Duration(seconds: 1));
    int failedProcess = getMaxValue();
    processes[failedProcess].fail();
    addMessage(failedProcess, failedProcess, type: MessageType.falha);

    await performElection();
  }

  /** Simula a recuperação de um processo e executa uma eleição. */
  Future<void> recoverProcess() async {
    await Future.delayed(const Duration(seconds: 1));
    messages.clear();
    for (var process in processes) {
      if (process.status == ProcessStatus.inactive) {
        process.recover();
        addMessage(process.id, process.id, type: MessageType.recuperacao);
        break;
      }
    }

    await performElection();
  }

  /** Executa o algoritmo de eleição para encontrar o novo coordenador. */
  Future<void> performElection() async {
    await Future.delayed(const Duration(seconds: 1));

    bool foundCoordinator = false;
    int coordinator = 0;

    Random random = Random();
    int idOfInitiator = random.nextInt(n);
    List<int> checkedProcesses = [];

    //Enquanto a flag foundCoordinator não for verdadeira
    while (!foundCoordinator) {
      //Se o processo que iniciou a eleição está com status inativo passa para o proximo processo
      if (processes[idOfInitiator].status == ProcessStatus.inactive) {
        checkedProcesses.add(idOfInitiator);
        if (checkedProcesses.length == n) break;
        idOfInitiator = (idOfInitiator + 1) % n;
        continue;
      }

      bool higherProcesses = false;

      for (int i = idOfInitiator + 1; i < n; i++) {
        // Inicializador da eleição envia uma mensagem para todos os pocessos com ID maior que ele
        addMessage(idOfInitiator, i, type: MessageType.eleicao);
        if (processes[i].status == ProcessStatus.active) {
          // Os processos com id maior que o iniciador da eleição retornam um OK caso estejam ativos
          addMessage(i, idOfInitiator, type: MessageType.ok);
          //Se existe um processo maior ativo, a flag higherProcesses é verdadeira
          higherProcesses = true;
        }
      }

      //Se nenhum processo tinha id maior que o ultimo inicializador de eleição, ele se torna o coordenador
      if (!higherProcesses) {
        coordinator = idOfInitiator;
        foundCoordinator = true;
        addMessage(coordinator, coordinator, type: MessageType.coordenador);
      }

      idOfInitiator = (idOfInitiator + 1) % n;
      checkedProcesses.add(idOfInitiator);
    }

    //Envia uma mensagem de coordenador para todos os processos ativos
    if (foundCoordinator) {
      for (int i = coordinator - 1; i >= 0; i--) {
        if (processes[i].status == ProcessStatus.active) {
          addMessage(coordinator, i, type: MessageType.coordenador);
        }
      }
    }
  }

  /** Retorna o índice do processo com o maior valor de ID. */
  int getMaxValue() {
    int maxId = -1;
    int maxIdIndex = 0;
    for (int i = 0; i < processes.length; i++) {
      if (processes[i].id > maxId) {
        maxId = processes[i].id;
        maxIdIndex = i;
      }
    }
    return maxIdIndex;
  }
}
