class DecodedResponse<T> {
  final int status;
  final T body;

  DecodedResponse(this.status, this.body);
}
