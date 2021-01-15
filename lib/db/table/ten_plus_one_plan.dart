

class TenPlusOnePlan{
  ///Singleton factory
  static final TenPlusOnePlan _instance = TenPlusOnePlan._internal();

  factory TenPlusOnePlan() {
    return _instance;
  }
  TenPlusOnePlan._internal();

  // 10+1 Plan
  static final String tenPlusOnePlanTableName = 'ten_plus_one_plan_table_name';
  // static final tppColumnId = 'tpp_column_id';
  static final id = 'id';
  static final tppColumnPayableEmiAmount = 'column_payable_emi_amount';
  static final tppColumnFirstEmiAmount = 'column_first_emi_amount';
  static final tppColumnNinethEmiAmount = 'column_nineth_emi_amount';
  static final tppColumnEleventhEmiAmount= 'column_eleventh_emi_amount';
  static final tppColumnTotalPurchaseAmount = 'column_total_purchase_amount';
  static final tppColumnTotalSavings = 'column_total_savings';
  static final tppPlanStartAndMaturityDate = 'column_plan_start_and_maturity_date';
}