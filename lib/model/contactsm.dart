class TContact {
  int? _id;
  String? _number;
  String? _name;

  TContact(this._number,this._name);
  TContact.withId(this._id,this._number,this._name);

  int get id => _id!;
  String get number => _number!;
  String get name => _name!;

  String toString(){
    return 'Contact: {id: $_id, name: $_name, number: $_number}';
  }

  set number(String newNumber) => this._number = newNumber;
  set name(String newName) => this._name = newName;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

        map['name'] = this._name;
        map['number'] = this._number;
        map['id'] = this._id;

        return map;
      }
//Extract the contact bject from map object
      TContact.fromMapObject(Map<String, dynamic> map){
        this._id = map['id'];
        this._name = map['name'];
        this._number = map['number'];
      }
}