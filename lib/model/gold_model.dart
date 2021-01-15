import 'package:shadow/db/table/table.dart';

class GoldModel {
  final int id;
  final String title;
  final String description;
  final String weight;
  final String price;
  final String imgUrl;
  final String goldType;

  GoldModel(
      {this.id = 0,
      this.title,
      this.description,
      this.weight,
      this.price,
      this.imgUrl,
      this.goldType});

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      // TenPlusOnePlan.id: id,
      GoldTable.goldTitle: title,
      GoldTable.goldDescription: description,
      GoldTable.goldWeight: weight,
      GoldTable.goldPrice: price,
      GoldTable.goldImageUrl: imgUrl,
      GoldTable.goldType: goldType
    };
  }


  factory GoldModel.fromMap(Map<String, dynamic> map){
    return GoldModel(
        id: map[GoldTable.goldColumnId],
        title: map[GoldTable.goldTitle],
        description: map[GoldTable.goldDescription],
        weight: map[GoldTable.goldWeight],
        price: map[GoldTable.goldPrice],
        imgUrl: map[GoldTable.goldImageUrl],
        goldType: map[GoldTable.goldType],
    );
  }


  @override
  String toString() {
    return 'Gold'
        '{'
        'id: $id, '
        'title: $title, '
        'description: $description, '
        'weight: $weight, '
        'price: $price, '
        'imgUrl: $imgUrl, '
        'goldType: $goldType '
        '}';
  }
}
