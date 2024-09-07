class GenesisFirebaseException implements Exception {
  final String code;

  GenesisFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'aborted':
        return 'The operation was aborted. Please try again later.';
      case 'already-exists':
        return 'The resource you are trying to create already exists.';
      case 'cancelled':
        return 'The operation was cancelled. Please try again.';
      case 'data-loss':
        return 'Data loss occurred. Please contact support for assistance.';
      case 'deadline-exceeded':
        return 'The operation took too long to complete. Please try again later.';
      case 'failed-precondition':
        return 'The operation was rejected due to an invalid system state. Ensure all conditions are met and try again.';
      case 'internal':
        return 'An internal error occurred. Please try again later.';
      case 'invalid-argument':
        return 'An invalid argument was provided. Please check your input and try again.';
      case 'not-found':
        return 'The requested resource was not found. Please check the request and try again.';
      case 'out-of-range':
        return 'The operation was attempted outside the valid range. Please check the request and try again.';
      case 'permission-denied':
        return 'You do not have permission to perform this operation. Please contact support if this is unexpected.';
      case 'resource-exhausted':
        return 'Resource limits have been exhausted. Please try again later or contact support.';
      case 'unauthenticated':
        return 'You must be authenticated to perform this operation. Please log in and try again.';
      case 'unavailable':
        return 'The service is currently unavailable. Please try again later.';
      case 'unimplemented':
        return 'The requested operation is not implemented or supported. Please contact support.';
      case 'unknown':
        return 'An unknown error occurred. Please try again or contact support.';
      case 'unreachable':
        return 'The service is currently unreachable. Please check your connection and try again.';
      case 'invalid-field-path':
        return 'The provided document field path is invalid. Please check the path and try again.';
      case 'invalid-document':
        return 'The document is invalid. Please ensure it is formatted correctly.';
      case 'permission-denied-firestore':
        return 'You do not have permission to access the Firestore resource. Please check your security rules.';
      case 'not-found-firestore':
        return 'The requested Firestore document was not found. Please verify the path and try again.';
      case 'cancelled-firestore':
        return 'The Firestore operation was cancelled. Please try again.';
      case 'invalid-collection':
        return 'The Firestore collection path is invalid. Please check the collection name.';
      case 'deadline-exceeded-firestore':
        return 'The Firestore operation timed out. Please try again later.';
      case 'quota-exceeded-firestore':
        return 'Firestore resource quota has been exceeded. Please try again later or contact support.';
      case 'conflict':
        return 'A conflict occurred. Please resolve the conflict and try again.';
      case 'already-initialized':
        return 'Firebase has already been initialized. Multiple initializations are not allowed.';
      case 'database-error':
        return 'An error occurred while accessing the Firebase Realtime Database. Please try again.';
      case 'network-error':
        return 'A network error occurred. Please check your connection and try again.';
      case 'database-permission-denied':
        return 'You do not have permission to access this Firebase Realtime Database resource.';
      case 'invalid-index':
        return 'The specified index is invalid. Please check the index and try again.';
      case 'too-large':
        return 'The requested document is too large. Please reduce its size and try again.';
      case 'storage-object-not-found':
        return 'The requested object was not found in Firebase Storage.';
      case 'storage-quota-exceeded':
        return 'Firebase Storage quota has been exceeded. Please try again later.';
      case 'storage-unauthorized':
        return 'You do not have permission to access this Firebase Storage resource.';
      case 'storage-canceled':
        return 'The Firebase Storage operation was cancelled.';
      case 'storage-invalid-checksum':
        return 'The file uploaded to Firebase Storage has an invalid checksum. Please try uploading again.';
      case 'storage-retry-limit-exceeded':
        return 'The operation in Firebase Storage exceeded its retry limit. Please try again later.';
      case 'storage-invalid-event-name':
        return 'An invalid event name was provided for Firebase Storage.';
      case 'storage-unauthenticated':
        return 'You must be authenticated to access Firebase Storage. Please log in and try again.';
      case 'storage-invalid-url':
        return 'The provided Firebase Storage URL is invalid.';
      case 'analytics-rejected':
        return 'The Firebase Analytics request was rejected. Please check your setup and try again.';
      case 'analytics-missing-dependency':
        return 'A required Firebase Analytics dependency is missing. Please install the necessary components.';
      case 'performance-monitoring-failure':
        return 'Firebase Performance Monitoring encountered a failure. Please try again later.';
      case 'invalid-api-call':
        return 'The API call is invalid. Please check the request and try again.';
      case 'auth-unauthorized':
        return 'The Firebase Authentication request is unauthorized. Please check your credentials and try again.';
      case 'functions-invalid-url':
        return 'The provided Firebase Cloud Functions URL is invalid.';
      case 'functions-deploy-failed':
        return 'Firebase Cloud Functions deployment failed. Please check the logs and try again.';
      case 'config-parsing-error':
        return 'An error occurred while parsing the Firebase configuration file. Please check the configuration and try again.';
      default:
        return 'An unknown Firebase error occurred. Please try again or contact support.';
    }
  }
}