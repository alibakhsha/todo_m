import 'package:flutter/material.dart';

import 'gen/assets.gen.dart';

class EditPageCompleteScreen extends StatefulWidget {
  const EditPageCompleteScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditPageCompleteScreen createState() => _EditPageCompleteScreen();
}

class _EditPageCompleteScreen extends State<EditPageCompleteScreen> {
  final _taskGroups = ['Work', 'gym', 'study', 'Other'];
  String? _selectedTaskGroup;
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void addTaskButtonHandler() {}

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 62, 30, 0),
          child: Column(
            children: [
              Center(
                  child: Text(
                "ADD TASK",
                style: textTheme.titleLarge,
              )),
              const SizedBox(
                height: 60,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 63,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 95, 51, 225)
                                  .withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(0, 7))
                        ]),
                    child: DropdownButtonFormField<String>(
                      iconSize: 0,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.work,
                          color: Colors.pink,
                        ),
                        suffixIcon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 48,
                        ),
                        labelText: 'Task Group',
                        labelStyle: textTheme.bodySmall,
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      value: _selectedTaskGroup,
                      items: _taskGroups.map((group) {
                        return DropdownMenuItem(
                          value: group,
                          child: Text(group),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedTaskGroup = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 63,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 95, 51, 225)
                                  .withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(0, 7))
                        ]),
                    child: TextField(
                      controller: _taskNameController,
                      decoration: InputDecoration(
                        labelText: 'Task Name',
                        labelStyle: textTheme.bodySmall,
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 142,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 95, 51, 225)
                                  .withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(0, 7))
                        ]),
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textTheme.bodySmall,
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 63,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 95, 51, 225)
                                  .withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(0, 7))
                        ]),
                    child: GestureDetector(
                      onTap: () => _pickDate(context, true),
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: 'Start Date',
                              labelStyle: textTheme.bodySmall,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              prefixIcon: const Icon(
                                Icons.calendar_month_rounded,
                                color: Color.fromARGB(255, 95, 51, 225),
                              ),
                              suffixIcon: const Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 48,
                              )),
                          controller: TextEditingController(
                            text: _startDate != null
                                ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                                : '',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 63,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(255, 95, 51, 225)
                                  .withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 15,
                              offset: const Offset(0, 7))
                        ]),
                    child: GestureDetector(
                      onTap: () => _pickDate(context, false),
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: 'End Date',
                              labelStyle: textTheme.bodySmall,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              prefixIcon: const Icon(
                                Icons.calendar_month_rounded,
                                color: Color.fromARGB(255, 95, 51, 225),
                              ),
                              suffixIcon: const Icon(
                                Icons.arrow_drop_down_rounded,
                                size: 48,
                              )),
                          controller: TextEditingController(
                            text: _endDate != null
                                ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                                : '',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Container(
                    width: size.width / 1.17,
                    height: 54,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 95, 51, 225),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        )),
                    child: InkWell(
                      onTap: addTaskButtonHandler,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Edited", style: textTheme.labelMedium),
                            const SizedBox(
                              width: 8,
                            ),
                            ImageIcon(
                              AssetImage(Assets.images.tablerEdit.path),
                              size: 24,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
