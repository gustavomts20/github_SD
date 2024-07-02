enum ProcessStatus { active, inactive }

class Process {
  final int id;
  ProcessStatus status;

  Process(this.id) : status = ProcessStatus.active;

  void fail() {
    status = ProcessStatus.inactive;
  }

  void recover() {
    status = ProcessStatus.active;
  }
}

enum MessageType { general, falha, recuperacao, eleicao, ok, coordenador }

class Message {
  final int senderId;
  final int destinationId;
  final MessageType type;

  Message({required this.senderId, required this.destinationId, required this.type});
}
