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
  String bolusMode = "no";

  bool flex = true;
  bool modeInfusion = true;
  String? _selectedTime;
  bool no = true;
  bool single = false;
  bool prime = false;
  bool bridge = false;

  List<String> drugList = [
    'Water',
    'Lioresal',
  ];

  String? _selectedDrug;

  DateTime? duration;
  DateTime? bolusDuration;

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
              if (modeInfusion)
                Column(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        _selectedTime != null
                                            ? _selectedTime!
                                            : 'No time selected!',
                                        style: const TextStyle(fontSize: 18),
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
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(
                                        duration != null
                                            ? "${duration!.hour} : ${duration!.minute} "
                                            : 'No Duration selected!',
                                        style: const TextStyle(fontSize: 18),
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
              else
                Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: ListTile(
                            leading: Radio<String>(
                              value: 'no',
                              groupValue: bolusMode,
                              onChanged: (value) {
                                setState(() {
                                  bolusMode = value!;
                                  no = true;
                                  single = false;
                                  prime = false;
                                  bridge = false;
                                });
                              },
                            ),
                            title: const Text(
                              'No Bolus',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListTile(
                            leading: Radio<String>(
                              value: 'single',
                              groupValue: bolusMode,
                              onChanged: (value) {
                                setState(() {
                                  bolusMode = value!;
                                  no = false;
                                  single = true;
                                  prime = false;
                                  bridge = false;
                                });
                              },
                            ),
                            title: const Text(
                              'Sigle Bolus',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: ListTile(
                            leading: Radio<String>(
                              value: 'prime',
                              groupValue: bolusMode,
                              onChanged: (value) {
                                setState(() {
                                  bolusMode = value!;
                                  no = false;
                                  single = false;
                                  prime = true;
                                  bridge = false;
                                });
                              },
                            ),
                            title: const Text(
                              'Prime Bolus',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListTile(
                            leading: Radio<String>(
                              value: 'bridge',
                              groupValue: bolusMode,
                              onChanged: (value) {
                                setState(() {
                                  bolusMode = value!;
                                  no = false;
                                  single = false;
                                  prime = false;
                                  bridge = true;
                                });
                              },
                            ),
                            title: const Text(
                              'Bridge Bolus',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    single
                        ? Column(
                            children: [
                              Table(
                                defaultVerticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                border: TableBorder.all(
                                    color: Colors.black, width: 2),
                                children: const [
                                  TableRow(
                                      // decoration: ,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child:
                                              TableCell(child: Text("Index")),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: TableCell(child: Text("Name")),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: TableCell(
                                              child: Text("Concentration")),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                          child: TableCell(
                                              child: Text("Unit / ML")),
                                        )
                                      ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: TableCell(child: Text("1")),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child:
                                          TableCell(child: Text("Liorosole")),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: TableCell(child: Text("2000")),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: TableCell(child: Text("mcg")),
                                    )
                                  ]),
                                ],
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
                                      bolusDuration =
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
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                        top: 20,
                                      ),
                                      child: Text(
                                        bolusDuration != null
                                            ? "${bolusDuration!.hour} : ${bolusDuration!.minute} "
                                            : 'No Duration selected!',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Container(),
                    prime
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Location of Drug",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tubing Volume",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "0.1999 ml",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Catheter Volume",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "0.1999 ml",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Prime Volume",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "0.1999 ml",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                ),
                                child: Text(
                                  "Drug",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: InputDecorator(
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
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Bolus Dose",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: Text(
                                      "μL",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ],
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
                                      bolusDuration =
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
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                        top: 20,
                                      ),
                                      child: Text(
                                        bolusDuration != null
                                            ? "${bolusDuration!.hour} : ${bolusDuration!.minute} "
                                            : 'No Duration selected!',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Container(),
                    bridge
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Daily dose of new Drug",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10.0,
                                        ),
                                        child: Text(
                                          "Drug",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: InputDecorator(
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
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Text(
                                              "mcg/day",
                                              style: TextStyle(
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Pump tubing and Catheter volume",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: "total drug volume",
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Text(
                                              "ml",
                                              style: TextStyle(
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Concentration of old drug",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10.0,
                                        ),
                                        child: Text(
                                          "Drug",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: InputDecorator(
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
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Text(
                                              "mcg/ml",
                                              style: TextStyle(
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Bolus Dose",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: Text(
                                      "mcg",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "desired dose for old drug",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: Text(
                                      "mcg/day",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Bolus Duration",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      bolusDuration =
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
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                        top: 20,
                                      ),
                                      child: Text(
                                        bolusDuration != null
                                            ? "${bolusDuration!.hour} : ${bolusDuration!.minute} "
                                            : 'No Duration selected!',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
            ],
          ),
        ),
      ),
    ));
  }
}
