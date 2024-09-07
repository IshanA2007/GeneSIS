class GenesisFormatException implements Exception {

  final String message;

  const GenesisFormatException([this.message = 'An unexpected format error occurred. Please check your input.']);

  String get formattedMessage => message;
}