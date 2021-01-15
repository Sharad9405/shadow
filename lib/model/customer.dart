import 'dart:convert';

class Customer{
  int id;
  String name;
  String email;
  int age;

  Customer({this.id=0,this.name,this.email,this.age});

  /*Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'age': age
    };
  }
*/

  factory Customer.fromJson(Map<String, dynamic> map){
    return Customer(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      age: map['age']
    );
  }

  Map<String, dynamic> toJson(){
    return {'id': id,'name':name, 'email': email,'age': age};
  }

  @override
  String toString() {
    return 'Customers{id: $id, name: $name, email: $email, age: $age}';
  }

}

List<Customer> employeeFromJson(String jsonData){
  final data = json.decode(jsonData);
  return List<Customer>.from(data.map((item) => Customer.fromJson(item)));
}

String employeeToJson(Customer data){
  final jsonData = data.toJson();
  return json.encode(jsonData);
}