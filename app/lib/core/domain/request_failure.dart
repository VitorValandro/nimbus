import 'package:nimbus/core/domain/decoded_response.dart';

class RequestFailure {
  final int? status;
  final dynamic message;

  RequestFailure({this.status, this.message});

  RequestFailure.fromResponse(DecodedResponse<dynamic> response)
      : this(
          status: response.status,
          message: response.body['message'],
        );
}
