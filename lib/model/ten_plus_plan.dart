import 'package:shadow/db/table/table.dart';

class TenPlusOnePlanModel {
  final int id;
  final String payableEmiAmount;
  final String firstEmiOff;
  final String ninethEmi;
  final String eleventhEmi;
  final String totalPurchaseAmount;
  final String totalSaving;
  final String planStartAndMaturityDate;

  TenPlusOnePlanModel({
      this.id = 0,
      this.payableEmiAmount,
      this.firstEmiOff,
      this.ninethEmi,
      this.eleventhEmi,
      this.totalPurchaseAmount,
      this.totalSaving,
      this.planStartAndMaturityDate
  });

  Map<String, dynamic> toMap() {
    // used when inserting data to the database
    return <String, dynamic>{
      // TenPlusOnePlan.id: id,
      TenPlusOnePlan.tppColumnPayableEmiAmount: payableEmiAmount,
      TenPlusOnePlan.tppColumnFirstEmiAmount: firstEmiOff,
      TenPlusOnePlan.tppColumnNinethEmiAmount: ninethEmi,
      TenPlusOnePlan.tppColumnEleventhEmiAmount: eleventhEmi,
      TenPlusOnePlan.tppColumnTotalPurchaseAmount: totalPurchaseAmount,
      TenPlusOnePlan.tppColumnTotalSavings: totalSaving,
      TenPlusOnePlan.tppPlanStartAndMaturityDate: planStartAndMaturityDate
    };
  }

  @override
  String toString() {
    return 'TenPlusOnePlanModel'
        '{'
        'id: $id, '
        'payableEmiAmount: $payableEmiAmount, '
        'firstEmiOff: $firstEmiOff, '
        'ninethEmi: $ninethEmi, '
        'eleventhEmi: $eleventhEmi, '
        'totalPurchaseAmount: $totalPurchaseAmount, '
        'totalSaving: $totalSaving, '
        'planStartAndMaturityDate: $planStartAndMaturityDate '
        '}';
  }
}
