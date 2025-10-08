class RazorpayOrderId{
   final String orderId;
   final String entity;
   final String status;
   final int amount;
   final int amountDue;
   final int amountPaid;
   final Map<String,dynamic> otherDetails;
   final int createdAt;

  RazorpayOrderId({required this.orderId, required this.entity,required this.status, required this.amount, required this.amountDue, required this.amountPaid, required this.otherDetails, required this.createdAt});

}