class GenesisPlatformException implements Exception {
  final String code;

  GenesisPlatformException(this.code);

  String get message {
    switch (code) {
      case 'notImplemented':
        return 'The requested platform operation is not implemented on this device.';
      case 'activityNotFound':
        return 'The specified activity could not be found on this device.';
      case 'badRequest':
        return 'The platform received a bad request. Please verify your inputs.';
      case 'internal':
        return 'An internal platform error occurred. Please try again later.';
      case 'cancelled':
        return 'The platform operation was cancelled. Please try again.';
      case 'timeout':
        return 'The operation timed out. Please try again later.';
      case 'invalid':
        return 'The provided data is invalid. Please check your input and try again.';
      case 'disconnected':
        return 'The device or service was disconnected during the operation. Please reconnect and try again.';
      case 'notFound':
        return 'The requested resource or service could not be found.';
      case 'unauthorized':
        return 'The platform denied authorization for the requested operation. Please check your permissions.';
      case 'denied':
        return 'The request was denied by the platform. Please ensure you have the necessary permissions.';
      case 'permissionDenied':
        return 'You do not have the required permission to perform this operation.';
      case 'operationNotAllowed':
        return 'This operation is not allowed on the platform. Please check the platform capabilities.';
      case 'quotaExceeded':
        return 'The platform resource quota has been exceeded. Please try again later.';
      case 'malformedUrl':
        return 'The URL provided is malformed. Please check the URL and try again.';
      case 'unavailable':
        return 'The requested platform service is unavailable at this time. Please try again later.';
      case 'serviceUnavailable':
        return 'The platform service is temporarily unavailable. Please try again later.';
      case 'connectionTimedOut':
        return 'The connection to the platform timed out. Please check your network and try again.';
      case 'unknown':
        return 'An unknown platform error occurred. Please try again later.';
      case 'inProgress':
        return 'Another operation is already in progress. Please wait for it to complete before trying again.';
      case 'abort':
        return 'The platform operation was aborted. Please retry the operation.';
      case 'pluginNotFound':
        return 'The specified plugin could not be found. Please check your setup and try again.';
      case 'unhandled':
        return 'An unhandled platform exception occurred. Please contact support.';
      case 'insufficientStorage':
        return 'There is insufficient storage available on the device. Please free up space and try again.';
      case 'fileNotFound':
        return 'The requested file could not be found on the platform.';
      case 'fileReadError':
        return 'There was an error reading the file. Please check if the file is accessible and try again.';
      case 'fileWriteError':
        return 'There was an error writing the file. Please ensure you have write permissions and try again.';
      case 'invalidArguments':
        return 'Invalid arguments were provided for the platform call. Please check your inputs.';
      case 'cameraPermissionDenied':
        return 'Camera permission was denied. Please enable camera access in settings.';
      case 'microphonePermissionDenied':
        return 'Microphone permission was denied. Please enable microphone access in settings.';
      case 'locationPermissionDenied':
        return 'Location permission was denied. Please enable location services in settings.';
      case 'bluetoothPermissionDenied':
        return 'Bluetooth permission was denied. Please enable Bluetooth access in settings.';
      case 'batteryOptimizationEnabled':
        return 'Battery optimization is enabled and may be affecting the operation. Please disable optimization and try again.';
      case 'insufficientBattery':
        return 'The device battery is insufficient to complete the operation.';
      case 'backgroundTaskDenied':
        return 'The platform denied the execution of background tasks.';
      case 'appBackgrounded':
        return 'The app is in the background. Some platform services may not be available.';
      case 'appTerminated':
        return 'The app was terminated unexpectedly during the operation. Please restart and try again.';
      case 'networkError':
        return 'A network error occurred. Please check your connection and try again.';
      case 'networkUnavailable':
        return 'The network is currently unavailable. Please connect to the internet and try again.';
      case 'noActivity':
        return 'No activity is currently available to handle this request. Please check your app configuration.';
      case 'methodNotAllowed':
        return 'The requested method is not allowed on this platform.';
      case 'codecNotSupported':
        return 'The requested codec is not supported on this platform.';
      case 'deprecated':
        return 'This feature is deprecated and may no longer work as expected.';
      case 'hardwareNotAvailable':
        return 'The required hardware is not available on this device.';
      case 'featureNotSupported':
        return 'This feature is not supported on this platform.';
      case 'invalidState':
        return 'The platform is in an invalid state to perform this operation. Please try again.';
      case 'insufficientPermissions':
        return 'The app does not have sufficient permissions to complete the operation.';
      case 'hardwareDisabled':
        return 'The required hardware feature is disabled. Please enable it and try again.';
      case 'unsupportedPlatform':
        return 'This operation is not supported on the current platform. Please check your app settings.';
      default:
        return 'An unknown platform error occurred. Please try again or contact support.';
    }
  }
}