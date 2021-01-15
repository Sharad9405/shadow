class GoldTable{
  ///Singleton factory
  static final GoldTable _instance = GoldTable._internal();

  factory GoldTable() {
    return _instance;
  }
  GoldTable._internal();

  // Players
  static final String goldTableName = 'gold_table_name';
  static final goldColumnId = 'gold_column_id';
  static final goldTitle = 'gold_title';
  static final goldDescription = 'gold_description';
  static final goldWeight = 'gold_weight';
  static final goldPrice = 'gold_price';
  static final goldImageUrl = 'gold_image_url';
  static final goldType = 'gold_type';
}