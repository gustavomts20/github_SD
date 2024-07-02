import 'package:flutter/material.dart';
import 'sequencer.dart';
import 'process.dart';
import 'theme.dart';

class SequencerPage extends StatefulWidget {
  const SequencerPage({super.key});

  @override
  SequencerPageState createState() => SequencerPageState();
}

class SequencerPageState extends State<SequencerPage> {
  late final SequencerLogic sequencerLogic;
  final List<Sequencer> sequencers = Sequencer.initializeSequencers();
  final List<Recipient> recipients = Recipient.initializeRecipients();
  final Map<String, TextEditingController> messageControllers = {
    'client1': TextEditingController(),
    'client2': TextEditingController(),
    'client3': TextEditingController(),
  };
  final List<String> messages = [];
  int? previousSequencer;

  SequencerPageState() {
    sequencerLogic = SequencerLogic(
      updateMessageDisplay: (id, msg) {
        setState(() {
          if (sequencerLogic.currentSequencer != previousSequencer) {
            messages
                .add("Sequencer Change: ${sequencerLogic.currentSequencer}");
            previousSequencer = sequencerLogic.currentSequencer;
          }
          messages.add("$id, $msg");
        });
      },
      updateUI: () => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sequenciador Movel',
          style: AppTheme.baseTextStyle.copyWith(
            fontSize: 28,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildClientForm(),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColorBlack,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                label: Text(
                  "Enviar mensagem",
                  style: AppTheme.baseTextStyle
                      .copyWith(color: AppTheme.primaryColorWhite),
                ),
                icon: Icon(
                  Icons.start,
                  color: AppTheme.primaryColorWhite,
                  size: 20,
                ),
                onPressed: () => sequencerLogic.sendMessage(
                  messageControllers.map(
                    (key, value) => MapEntry(
                      key,
                      value.text,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              buildCircleContainer(),
              buildRecipientContainer(),
              buildMessageList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildClientForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        3,
        (index) {
          String clientId = 'client${index + 1}';
          return CheckboxListTile(
            title: TextFormField(
              controller: messageControllers[clientId],
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Mensagem de $clientId',
                labelStyle: AppTheme.baseTextStyle,
              ),
            ),
            value: sequencerLogic.clients[index].isActive,
            onChanged: (bool? value) {
              setState(() {
                sequencerLogic.clients[index].isActive = value ?? false;
              });
            },
          );
        },
      ),
    );
  }

  Widget buildCircleContainer() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: List.generate(sequencers.length, (index) {
        return Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: sequencerLogic.currentSequencer == index
                ? AppTheme.especialColorGreen
                : AppTheme.primaryColorWhite,
          ),
          child: Text(sequencers[index].label, style: AppTheme.baseTextStyle),
        );
      }),
    );
  }

  Widget buildRecipientContainer() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: List.generate(recipients.length, (index) {
        return Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.primaryColorWhite,
          ),
          child: Text(recipients[index].name, style: AppTheme.baseTextStyle),
        );
      }),
    );
  }

  Widget buildMessageList() {
    List<Map<String, String>> dataMaps = [];
    Map<String, String> currentDataMap = {
      'Client1': '',
      'Client2': '',
      'Client3': '',
      'Sequencer1': '',
      'Sequencer2': '',
      'Sequencer3': '',
      'Sequencer4': '',
      'Sequencer5': '',
      'Sequencer6': '',
      'Recipient1': '',
      'Recipient2': '',
      'Recipient3': '',
    };

    for (var message in messages) {
      print("Processing message: $message");

      if (message.startsWith("Sequencer Change:")) {
        if (currentDataMap.values.any((element) => element.isNotEmpty)) {
          dataMaps.add(Map.from(currentDataMap));
          currentDataMap = {
            'Client1': '',
            'Client2': '',
            'Client3': '',
            'Sequencer1': '',
            'Sequencer2': '',
            'Sequencer3': '',
            'Sequencer4': '',
            'Sequencer5': '',
            'Sequencer6': '',
            'Recipient1': '',
            'Recipient2': '',
            'Recipient3': '',
          };
        }
      } else if (message.contains('Reordenado')) {
        var match = RegExp(r'P(\d+), Reordenado: \[(\d+), (\d+), (\d+)\]')
            .firstMatch(message);
        if (match != null) {
          var sequencerId = match.group(1);
          var first = match.group(2) ?? '';
          var second = match.group(3) ?? '';
          var third = match.group(4) ?? '';

          currentDataMap['Client1'] = third;
          currentDataMap['Client2'] = second;
          currentDataMap['Client3'] = first;

          if (sequencerId == '1') {
            currentDataMap['Sequencer1'] = "$first, $second, $third";
          } else if (sequencerId == '2') {
            currentDataMap['Sequencer2'] = "$first, $second, $third";
          } else if (sequencerId == '3') {
            currentDataMap['Sequencer3'] = "$first, $second, $third";
          } else if (sequencerId == '4') {
            currentDataMap['Sequencer4'] = "$first, $second, $third";
          } else if (sequencerId == '5') {
            currentDataMap['Sequencer5'] = "$first, $second, $third";
          } else if (sequencerId == '6') {
            currentDataMap['Sequencer6'] = "$first, $second, $third";
          }
        }
      } else if (message.contains('OK')) {
        var parts = message.split(',');
        var recipientPart = parts[0].trim();
        var recipientNumber = recipientPart.replaceAll(RegExp(r'[^\d]'), '');
        currentDataMap['Recipient$recipientNumber'] = 'OK';
      }
    }

    if (currentDataMap.values.any((element) => element.isNotEmpty)) {
      dataMaps.add(currentDataMap);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Client1')),
          DataColumn(label: Text('Client2')),
          DataColumn(label: Text('Client3')),
          DataColumn(label: Text('Sequencer1')),
          DataColumn(label: Text('Sequencer2')),
          DataColumn(label: Text('Sequencer3')),
          DataColumn(label: Text('Sequencer4')),
          DataColumn(label: Text('Sequencer5')),
          DataColumn(label: Text('Sequencer6')),
          DataColumn(label: Text('Recipient1')),
          DataColumn(label: Text('Recipient2')),
          DataColumn(label: Text('Recipient3')),
        ],
        rows: dataMaps.map((dataMap) {
          return DataRow(cells: [
            DataCell(Text(dataMap['Client1'] ?? '')),
            DataCell(Text(dataMap['Client2'] ?? '')),
            DataCell(Text(dataMap['Client3'] ?? '')),
            DataCell(Text(dataMap['Sequencer1'] ?? '')),
            DataCell(Text(dataMap['Sequencer2'] ?? '')),
            DataCell(Text(dataMap['Sequencer3'] ?? '')),
            DataCell(Text(dataMap['Sequencer4'] ?? '')),
            DataCell(Text(dataMap['Sequencer5'] ?? '')),
            DataCell(Text(dataMap['Sequencer6'] ?? '')),
            DataCell(Text(dataMap['Recipient1'] ?? '')),
            DataCell(Text(dataMap['Recipient2'] ?? '')),
            DataCell(Text(dataMap['Recipient3'] ?? '')),
          ]);
        }).toList(),
      ),
    );
  }
}
