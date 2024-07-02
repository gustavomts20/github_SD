class Client {
  String id;
  String message;
  bool isActive;
  String? statusMessage;

  Client({required this.id, this.message = "", this.isActive = false, this.statusMessage});

  static List<Client> initializeClients() {
    return [
      Client(id: 'client1'),
      Client(id: 'client2'),
      Client(id: 'client3'),
    ];
  }
}

class Sequencer {
  String id;
  String label;
  String? statusMessage;

  Sequencer({required this.id, required this.label, this.statusMessage});

  static List<Sequencer> initializeSequencers() {
    return [
      Sequencer(id: "circle1", label: "P1"),
      Sequencer(id: "circle2", label: "P2"),
      Sequencer(id: "circle3", label: "P3"),
      Sequencer(id: "circle4", label: "P4"),
      Sequencer(id: "circle5", label: "P5"),
      Sequencer(id: "circle6", label: "P6"),
    ];
  }
}

class Recipient {
  String id;
  String name;
  String? statusMessage;

  Recipient({required this.id, required this.name, this.statusMessage});

  static List<Recipient> initializeRecipients() {
    return [
      Recipient(id: 'recipient1', name: 'R1'),
      Recipient(id: 'recipient2', name: 'R2'),
      Recipient(id: 'recipient3', name: 'R3'),
    ];
  }
}
