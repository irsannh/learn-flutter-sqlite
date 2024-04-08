import 'package:flutter/material.dart';
import 'package:learn_sqlite/models/absensi.dart';

class FormAbsensi extends StatefulWidget {
  final Absensi? absensi;

  FormAbsensi({super.key, this.absensi});

  @override
  State<FormAbsensi> createState() => _FormAbsensiState(this.absensi);
}

class _FormAbsensiState extends State<FormAbsensi> {
  Absensi? absensi;

  _FormAbsensiState(this.absensi);

  TextEditingController nameController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (absensi != null) {
      nameController.text = absensi!.nama;
      statusController.text = absensi!.status_hadir;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Entry Form Absensi"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nama Karyawan"
                ),
                onChanged: (value) {

                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                controller: statusController,
                  decoration: InputDecoration(
                      labelText: "Status Kehadiran Karyawan"
                  ),
                onChanged: (value) {

                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton(
                        child: Text("Save"),
                        onPressed: () {
                          if(absensi == null) {
                            absensi = Absensi(nameController.text, statusController.text);
                          } else {
                            absensi!.nama = nameController.text;
                            absensi!.status_hadir = statusController.text;
                          }
                          Navigator.pop(context, absensi);
                        },
                      )
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                      child: ElevatedButton(
                        child: Text("Back"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
