class BaseResponse<T> {
  final bool? success;
  final String? message;
  final T? data;

  BaseResponse({
    this.success,
    this.message,
    this.data,
  });

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic) fromJsonT,
      ) {
    // 👇 Supports both wrapped and direct responses
    final dataJson = json['data'] ?? json;
    final data = fromJsonT(dataJson);

    return BaseResponse(
      success: json['success'] ?? true, // assumes true if missing
      message: json['message'] ?? 'Success',
      data: data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }
}
