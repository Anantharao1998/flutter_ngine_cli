import 'dart:io';

abstract class ApiConstants {
  // Default config
  static const connectTimeoutInMs = 20;
  static const receiveTimeoutInMs = 15;
  static const contentTypeJson = 'application/json';
  static const httpMaintenanceModeStatusCode = [
    HttpStatus.badGateway,
    HttpStatus.serviceUnavailable,
    523,
    522
  ];
  static const httpUnauthorizedIgnoreUrl = ['/auth/logout'];
  static const httpMaintenanceIgnoreUrl = ['/auth/version'];

  // API lists
  static const githubListUri = '/search/repositories';
  static const projectDetailsUri = '/repos/';
}
