import 'package:flutter/material.dart';

class Sample extends StatefulWidget {
  const Sample({super.key});

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  List<TextEditingController> listControllers = [TextEditingController()];

  @override
  void dispose() {
    // Dispose all controllers when the widget is disposed.
    for (var controller in listControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listControllers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(child: Text('Requirement ${index + 1}:')),
                      Expanded(
                        child: TextFormField(
                          controller: listControllers[index],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_rounded),
                        onPressed: () {
                          setState(() {
                            // Clear and dispose the controller before removing it from the list
                            listControllers[index].dispose();
                            listControllers.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                listControllers.add(TextEditingController());
              });
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
