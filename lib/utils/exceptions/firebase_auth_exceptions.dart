class GenesisFirebaseAuthException implements Exception {
  final String code;

  GenesisFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check the token and try again.';
      case 'custom-token-mismatch':
        return 'The custom token corresponds to a different audience.';
      case 'invalid-credential':
        return 'The authentication credential is invalid. Please check the credential and try again.';
      case 'user-disabled':
        return 'The user account has been disabled by an administrator.';
      case 'user-token-expired':
        return 'The user\'s credential has expired. Please sign in again.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'wrong-password':
        return 'The password is invalid. Please try again.';
      case 'user-not-found':
        return 'There is no user record corresponding to this identifier. The user may have been deleted.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different sign-in credentials.';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'operation-not-allowed':
        return 'Sign-in method is disabled. Please enable it in the Firebase Console.';
      case 'weak-password':
        return 'The password is too weak. Choose a stronger password.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user account.';
      case 'invalid-verification-code':
        return 'The SMS verification code used to create the phone auth credential is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID used to create the phone auth credential is invalid.';
      case 'missing-verification-code':
        return 'The verification code is missing. Please enter the verification code sent to your device.';
      case 'missing-verification-id':
        return 'The verification ID is missing. Please try the verification process again.';
      case 'invalid-phone-number':
        return 'The provided phone number is not a valid phone number.';
      case 'missing-phone-number':
        return 'A phone number must be provided for phone sign-in.';
      case 'quota-exceeded':
        return 'The SMS quota for this project has been exceeded. Please try again later.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your connection and try again.';
      case 'invalid-api-key':
        return 'Your API key is invalid. Please contact support.';
      case 'app-not-authorized':
        return 'This app is not authorized to use Firebase Authentication. Please contact support.';
      case 'invalid-user-token':
        return 'The user\'s credential is no longer valid. The user must sign in again.';
      case 'user-mismatch':
        return 'The credential provided does not correspond to the user who is signed in.';
      case 'app-deleted':
        return 'This instance of FirebaseApp has been deleted.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new one.';
      case 'invalid-action-code':
        return 'The action code is invalid. This can happen if the code is malformed or has already been used.';
      case 'weak-password':
        return 'The provided password is too weak.';
      case 'internal-error':
        return 'An internal error has occurred. Please try again later.';
      case 'too-many-requests':
        return 'We have blocked all requests from this device due to unusual activity. Try again later.';
      case 'captcha-check-failed':
        return 'The reCAPTCHA token is invalid or has expired. Please try again.';
      case 'invalid-app-credential':
        return 'The phone verification request contains an invalid application verifier. Please re-authenticate.';
      case 'missing-app-credential':
        return 'The phone verification request is missing the app verifier assertion.';
      case 'invalid-persistence-type':
        return 'The specified persistence type is invalid. It must be "local", "session", or "none".';
      case 'unsupported-persistence-type':
        return 'The current environment does not support the specified persistence type.';
      case 'missing-continue-uri':
        return 'A continue URL must be provided in the request.';
      case 'missing-iframe-start':
        return 'An internal error occurred while attempting to perform a cross-site request.';
      case 'auth-domain-config-required':
        return 'An auth domain configuration is required to perform the operation.';
      case 'invalid-continue-uri':
        return 'The continue URL provided in the request is invalid.';
      case 'unauthorized-continue-uri':
        return 'The domain of the continue URL is not whitelisted. Please contact support.';
      case 'invalid-dynamic-link-domain':
        return 'The provided dynamic link domain is not configured or authorized.';
      case 'invalid-provider-id':
        return 'The provider ID provided for sign-in is invalid. Please check the provider ID and try again.';
      case 'user-cancelled':
        return 'The user cancelled the sign-in process.';
      case 'invalid-cert-hash':
        return 'The certificate hash provided is invalid.';
      case 'invalid-tenant-id':
        return 'The tenant ID provided is invalid. Please check the tenant configuration.';
      case 'tenant-id-mismatch':
        return 'The credential used does not correspond to the tenant ID of the user.';
      case 'admin-restricted-operation':
        return 'This operation is restricted to administrators only.';
      case 'unverified-email':
        return 'The user\'s email address is unverified. Please verify the email before proceeding.';
      case 'second-factor-required':
        return 'The operation requires the user to complete a second-factor challenge.';
      case 'multi-factor-info-not-found':
        return 'The specified second-factor information could not be found.';
      case 'multi-factor-auth-required':
        return 'The user needs to complete multi-factor authentication to sign in.';
      case 'missing-multi-factor-session':
        return 'A multi-factor session is missing. Please complete the authentication process again.';
      case 'missing-multi-factor-info':
        return 'Second-factor information is missing. Please provide the second-factor details.';
      case 'invalid-multi-factor-session':
        return 'The multi-factor session is invalid or has expired.';
      case 'multi-factor-auth-failed':
        return 'Multi-factor authentication failed. Please try again.';
      default:
        return 'An unknown error occurred. Please try again or contact support.';
    }
  }
}