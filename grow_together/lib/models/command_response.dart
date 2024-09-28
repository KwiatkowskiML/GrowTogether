class CommandResponse {
  String result;

  CommandResponse({required this.result});

  // Convert CommandResponse object to JSON
  Map<String, dynamic> toJson() => {
    'result': result,
  };

  // Parse JSON to create a CommandResponse object
  factory CommandResponse.fromJson(Map<String, dynamic> json) {
    return CommandResponse(
      result: json['result'],
    );
  }
}
