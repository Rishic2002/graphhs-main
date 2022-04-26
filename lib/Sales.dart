class Sales {
  final int saleVal;
  final int saleYear;
  final String colorVal;
  Sales(this.saleVal, this.saleYear, this.colorVal);

  Sales.fromMap(Map<String, dynamic> map)
      : saleVal = map['saleVal'],
        colorVal = map['colorVal'],
        saleYear = map['saleYear'];

  @override
  String toString() => "Record<$saleVal:$saleYear:$colorVal>";
}
