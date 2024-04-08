class Absensi {
  int? _id;
  String? _nama;
  String? _status_hadir;

  Absensi(this._nama, this._status_hadir);

  Absensi.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nama = map['nama'];
    this._status_hadir = map['status_hadir'];
  }

  int get id => _id!;
  String get nama => _nama!;
  String get status_hadir => _status_hadir!;

  set nama(String value){
    _nama = value;
  }

  set status_hadir(String value){
    _status_hadir = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['nama'] = this._nama;
    map['status_hadir'] = this._status_hadir;
    return map;
  }
}