class PaymentData {
  final String date;       // 날짜
  final String name;         // 이름
  final String className;    // 수업명
  final String requestDate;// 요청일
  final String amount;       // 금액

  // 생성자
  PaymentData({
    required this.date,
    required this.name,
    required this.className,
    required this.requestDate,
    required this.amount,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      date: json['date'],
      name: json['name'],
      className: json['className'],
      requestDate: json['requestDate'],
      amount: json['amount'],
    );
  }

}
