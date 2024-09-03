class Donation {
  final String donorName;
  final String donorAddress;
  final String donorStatus;
  final double donatedAmount;
  final String recipientName;
  final String recipientAddress;
  final String reason;
  final double neededAmount;

  Donation({
    required this.donorName,
    required this.donorAddress,
    required this.donorStatus,
    required this.donatedAmount,
    required this.recipientName,
    required this.recipientAddress,
    required this.reason,
    required this.neededAmount,
  });
}
