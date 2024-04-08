import 'package:flutter/material.dart';
import 'package:learn_sqlite/helpers/dbhelper.dart';
import 'package:learn_sqlite/models/absensi.dart';
import 'package:learn_sqlite/ui/formAbsensi.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Absensi>? absensiList;
  @override
  Widget build(BuildContext context) {
    if(absensiList == null) {
      absensiList = <Absensi>[];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Absensi Karyawan"),
      ),
      body: createListAbsensi(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var absensi = await _navigateToFormAbsensi(context, null);
          if(absensi != null) _createAbsensi(absensi);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<Absensi> _navigateToFormAbsensi(BuildContext context, Absensi? absensi) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(
          builder: (BuildContext context){
            return FormAbsensi(absensi: absensi);
          }
      )
    );
    return result;
  }

  ListView createListAbsensi() {
    return ListView.builder(
      itemCount: count,
        itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 3.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.people),
            ),
            title: Text(this.absensiList![index].nama),
            subtitle: Text(this.absensiList![index].status_hadir),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                _deleteAbsensi(absensiList![index]);
              },
            ),
            onTap: () async {
              var absensi = await _navigateToFormAbsensi(context, this.absensiList![index]);
              if (absensi != null) _editAbsensi(absensi);
            },
          ),
        );
        }
    );
  }

  void _createAbsensi(Absensi object) async {
    int result = await dbHelper.create(object);

    if(result > 0) {
      _updateListView();
    }
  }

  void _editAbsensi(Absensi object) async {
    int result = await dbHelper.update(object);

    if(result > 0) {
      _updateListView();
    }
  }

  void _deleteAbsensi(Absensi object) async {
    int result = await dbHelper.delete(object.id);

    if(result > 0) {
      _updateListView();
    }
  }

  void _updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Absensi>> absensiListFuture = dbHelper.getAbsensiList();
      absensiListFuture.then((absensiList) {
        setState(() {
          this.absensiList = absensiList;
          this.count = absensiList.length;
        });
      });
    });
  }
}
