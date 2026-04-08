void main() {
  final data = {
    "data": [],
    "message": "Validation Error",
    "errors": {
      "current_password": [
        "The current password is incorrect"
      ],
      "new_password": [
        "The new password field is required."
      ]
    },
    "status": 422
  };
  
  List<String> errorMessages = [];
  
  if (data.containsKey('errors') && data['errors'] is Map) {
    final errors = data['errors'] as Map;
    for (var messages in errors.values) {
      if (messages is List) {
        for (var msg in messages) {
          errorMessages.add(msg.toString());
        }
      }
    }
  }
  
  print('Parsed Errors: \${errorMessages.join('\\n')}');
}
