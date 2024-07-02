import 'package:bully/theme.dart';
import 'package:flutter/material.dart';
import 'bully.dart';

class BullyView extends StatefulWidget {
  const BullyView({super.key});

  @override
  _BullyViewState createState() => _BullyViewState();
}

class _BullyViewState extends State<BullyView> {
  final TextEditingController _controller = TextEditingController();
  final BullyAlgorithm bully = BullyAlgorithm();

  void _startElection() async {
    if (_controller.text.isNotEmpty) {
      int numberOfProcesses = int.parse(_controller.text);
      bully.initializeProcesses(numberOfProcesses);
      await bully.failProcess();
      setState(() {});
    }
  }

  void _restartProcess() async {
    await bully.recoverProcess();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bully',
          style: AppTheme.baseTextStyle,
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Número de processos',
                hintText: 'Defina o número total de processos',
                labelStyle: AppTheme.baseTextStyle,
                hintStyle: AppTheme.baseTextStyle,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _startElection,
                label: Text(
                  "Iniciar Eleição",
                  style: AppTheme.baseTextStyle
                      .copyWith(color: AppTheme.primaryColorWhite),
                ),
                icon: Icon(
                  Icons.start,
                  color: AppTheme.primaryColorWhite,
                  size: 20,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColorBlack,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton.icon(
                onPressed: _restartProcess,
                label: Text(
                  "Reiniciar Processo",
                  style: AppTheme.baseTextStyle
                      .copyWith(color: AppTheme.primaryColorWhite),
                ),
                icon: Icon(
                  Icons.restart_alt_sharp,
                  color: AppTheme.primaryColorWhite,
                  size: 20,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColorBlack,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: bully.processes.length,
                itemBuilder: (context, index) {
                  var process = bully.processes[index];
                  var processMessages = bully.messages
                      .where((m) =>
                          m.senderId == process.id ||
                          m.destinationId == process.id)
                      .toList();
                  ScrollController localScrollController = ScrollController();
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // Ensures vertical alignment
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${process.id}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          child: Scrollbar(
                            thumbVisibility: true,
                            controller: localScrollController,
                            child: ListView.builder(
                              controller: localScrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: processMessages.length,
                              itemBuilder:
                                  (BuildContext context, int messageIndex) {
                                var message = processMessages[messageIndex];
                                return Container(
                                  margin: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: message.senderId == process.id
                                        ? const Color(0xFF0D093F)
                                        : const Color(0xFF8FCF00),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    width: 230,
                                    child: Center(
                                      child: ListTile(
                                        title: Text(
                                          message.senderId == process.id
                                              ? "Enviando: ${message.type.toString().split('.').last}"
                                              : "Recebendo: ${message.type.toString().split('.').last}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        subtitle: Text(
                                          message.senderId == process.id
                                              ? "Para: Processo ${message.destinationId}"
                                              : "De: Processo ${message.senderId}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
