import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

class UpdateMode extends StatefulWidget {
  const UpdateMode({super.key});

  @override
  State<UpdateMode> createState() => _UpdateModeState();
}

class _UpdateModeState extends State<UpdateMode> {
  String selectedMode = "infusion";
  String infusionMode = "flex";

  bool flex = true;
  bool modeInfusion = true;
  String? _selectedTime;

  List<String> drugList = [
    'Water',
    'Lioresal',
  ];

  String? _selectedDrug;

  DateTime? duration;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Update Mode")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Mode",
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  Flexible(
                    child: ListTile(
                      leading: Radio<String>(
                        value: 'infusion',
                        groupValue: selectedMode,
                        onChanged: (value) {
                          setState(() {
                            selectedMode = value!;
                            modeInfusion = true;
                          });
                        },
                      ),
                      title: const Text(
                        'Infusion',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      leading: Radio<String>(
                        value: 'bolus',
                        groupValue: selectedMode,
                        onChanged: (value) {
                          setState(() {
                            selectedMode = value!;
                            modeInfusion = false;
                          });
                        },
                      ),
                      title: const Text(
                        'Bolus',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              modeInfusion
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: ListTile(
                                leading: Radio<String>(
                                  value: 'flex',
                                  groupValue: infusionMode,
                                  onChanged: (value) {
                                    setState(() {
                                      infusionMode = value!;
                                      flex = true;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Flex',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            Flexible(
                              child: ListTile(
                                leading: Radio<String>(
                                  value: 'continuous',
                                  groupValue: infusionMode,
                                  onChanged: (value) {
                                    setState(() {
                                      infusionMode = value!;
                                      flex = false;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Continuous',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Drug",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InputDecorator(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: const Text('Select a Drug'),
                                  value: _selectedDrug,
                                  isExpanded: true,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedDrug = newValue!;
                                    });
                                  },
                                  items: drugList.map((value) {
                                    return DropdownMenuItem(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        flex
                            ? Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Start & Day",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SfDateRangePicker(
                                        onSelectionChanged:
                                            (DateRangePickerSelectionChangedArgs
                                                args) {
                                          print(args.value);
                                        },
                                        selectionMode:
                                            DateRangePickerSelectionMode.range,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Start Time",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final TimeOfDay? result =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now());
                                          if (result != null) {
                                            setState(() {
                                              _selectedTime =
                                                  result.format(context);
                                            });
                                          }
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                            _selectedTime != null
                                                ? _selectedTime!
                                                : 'No time selected!',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Start Duration",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          duration =
                                              await TimePicker.show<DateTime?>(
                                            context: context,
                                            sheet: TimePickerSheet(
                                              minuteInterval: 1,
                                              sheetTitle: 'Select Duration',
                                              hourTitle: 'Hour',
                                              minuteTitle: 'Minute',
                                              saveButtonText: 'Save',
                                              minuteTitleStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.black),
                                              hourTitleStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.black),
                                              sheetTitleStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Colors.black),
                                              saveButtonColor: Colors.black,
                                            ),
                                          ).whenComplete(() => setState(() {}));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                            duration != null
                                                ? "${duration!.hour} : ${duration!.minute} "
                                                : 'No Duration selected!',
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    ));
  }
}
