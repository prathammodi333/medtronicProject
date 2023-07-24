import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medtronics/Screens/UpdateMode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Drug Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Screenshot(
              controller: screenshotController,
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(color: Colors.black, width: 2),
                children: const [
                  TableRow(
                      // decoration: ,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TableCell(child: Text("Index")),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TableCell(child: Text("Name")),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TableCell(child: Text("Concentration")),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: TableCell(child: Text("Unit / ML")),
                        )
                      ]),
                  TableRow(children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TableCell(child: Text("1")),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TableCell(child: Text("Lio")),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TableCell(child: Text("2000")),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TableCell(child: Text("mcg")),
                    )
                  ]),
                  TableRow(children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TableCell(child: Text("2")),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TableCell(child: Text("Water")),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TableCell(child: Text("500")),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: TableCell(child: Text("mcg")),
                    )
                  ]),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Row(
              children: [
                Text(
                  "Total Reservoir Volume : ",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "100 ml",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Current Pump Setting",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 20,
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Continuius Infusion Mode",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Bolus Mode : No / Single / Prime",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
                height: 45,
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UpdateMode()));
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(fontSize: 18),
                    ))),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 45,
                width: 300,
                child: ElevatedButton(
                    onPressed: () async {
                      final pdf = pw.Document();
                      final uint8List = await screenshotController.capture();
                      String tempPath = (await getTemporaryDirectory()).path;
                      String fileName = "myFile";
                      pdf.addPage(
                        pw.Page(
                          pageFormat: PdfPageFormat.a4,
                          build: (context) {
                            return pw.Expanded(
                              child: pw.Image(pw.MemoryImage(uint8List!),
                                  fit: pw.BoxFit.contain),
                            );
                          },
                        ),
                      );

                      File file =
                          await File('$tempPath/$fileName.png').create();
                      await file.writeAsBytes(await pdf.save());
                      await Printing.layoutPdf(
                          onLayout: (PdfPageFormat format) async =>
                              pdf.save());
                    },
                    child: const Text(
                      "Print",
                      style: TextStyle(fontSize: 18),
                    ))),
          ],
        ),
      ),
    ));
  }
}
