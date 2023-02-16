enum MessageType {
  incoming(0),
  sent(1);

  const MessageType(this.value);
  final int value;
}
