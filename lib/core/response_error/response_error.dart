import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_error.freezed.dart';

/// A representation of all possible errors while connecting with the backend.
///
/// We return those errors to get localized messages to display to the user.
@freezed
sealed class ResponseError with _$ResponseError implements Exception {
  const ResponseError._();

  const factory ResponseError.noInternetConnection({
    String? message,
    int? statusCode,
  }) = _NoInternetConnection;

  const factory ResponseError.sendTimeout({
    String? message,
    int? statusCode,
  }) = _SendTimeout;

  const factory ResponseError.connectTimeout({
    String? message,
    int? statusCode,
  }) = _ConnectTimeout;

  const factory ResponseError.receiveTimeout({
    String? message,
    int? statusCode,
  }) = _ReceiveTimeout;

  const factory ResponseError.badRequest({
    String? message,
    int? statusCode,
  }) = _BadRequest;

  const factory ResponseError.notFound({
    String? message,
    int? statusCode,
  }) = _NotFound;

  const factory ResponseError.tooManyRequests({
    String? message,
    int? statusCode,
  }) = _TooManyRequests;

  const factory ResponseError.unprocessableEntity({
    String? message,
    int? statusCode,
  }) = _UnprocessableEntity;

  const factory ResponseError.internalServerError({
    String? message,
    int? statusCode,
  }) = _InternalServerError;

  const factory ResponseError.unexpectedError({
    String? message,
    int? statusCode,
  }) = _UnexpectedError;

  const factory ResponseError.requestCancelled({
    String? message,
    int? statusCode,
  }) = _RequestCancelled;

  const factory ResponseError.badCertificate({
    String? message,
    int? statusCode,
  }) = _BadCertificate;

  const factory ResponseError.connectionError({
    String? message,
    int? statusCode,
  }) = _ConnectionError;

  const factory ResponseError.conflict({
    String? message,
    int? statusCode,
  }) = _Conflict;

  const factory ResponseError.unauthorized({
    String? message,
    int? statusCode,
  }) = _Unauthorized;

  const factory ResponseError.invalidPassword({
    String? message,
    int? statusCode,
  }) = _InvalidPasswordError;

  const factory ResponseError.invalidConfirmPassword({
    String? message,
    int? statusCode,
  }) = _InvalidConfirmPasswordError;

  const factory ResponseError.invalidEmail({
    String? message,
    int? statusCode,
  }) = _InvalidEmailError;

  const factory ResponseError.invalidLoginCredentials({
    String? message,
    int? statusCode,
  }) = _InvalidLoginCredentials;

  const factory ResponseError.invalidSearchTerm({
    String? message,
    int? statusCode,
  }) = _InvalidSearchTermError;

  /// Tries to extract error message from server response
  static String? _extractServerErrorMessage(DioException error) {
    try {
      final responseData = error.response?.data;
      if (responseData is Map<String, dynamic>) {
        // Try common error message fields
        return responseData['message'] as String? ??
            responseData['error'] as String? ??
            responseData['detail'] as String? ??
            responseData['description'] as String?;
      } else if (responseData is String) {
        return responseData;
      }
    } catch (e) {
      // If extraction fails, fall back to default behavior
    }
    return null;
  }

  /// Factory method to map raw errors into strongly typed ResponseError
  static ResponseError from(Object error) {
    if (error is ResponseError) {
      return error;
    } else if (error is SocketException) {
      return const ResponseError.noInternetConnection();
    } else if (error is DioException) {
      final serverMessage = _extractServerErrorMessage(error);
      final statusCode = error.response?.statusCode;

      switch (error.type) {
        case DioExceptionType.sendTimeout:
          return ResponseError.sendTimeout(
            message: serverMessage,
            statusCode: statusCode,
          );
        case DioExceptionType.connectionTimeout:
          return ResponseError.connectTimeout(
            message: serverMessage,
            statusCode: statusCode,
          );
        case DioExceptionType.receiveTimeout:
          return ResponseError.receiveTimeout(
            message: serverMessage,
            statusCode: statusCode,
          );
        case DioExceptionType.cancel:
          return ResponseError.requestCancelled(
            message: serverMessage,
            statusCode: statusCode,
          );
        case DioExceptionType.badCertificate:
          return ResponseError.badCertificate(
            message: serverMessage,
            statusCode: statusCode,
          );
        case DioExceptionType.connectionError:
          return ResponseError.connectionError(
            message: serverMessage,
            statusCode: statusCode,
          );
        case DioExceptionType.unknown:
          // Handle SocketException inside unknown
          if (error.error is SocketException) {
            return ResponseError.noInternetConnection(
              message: serverMessage,
              statusCode: statusCode,
            );
          }
          return ResponseError.unexpectedError(
            message: serverMessage,
            statusCode: statusCode,
          );
        case DioExceptionType.badResponse:
          // Map to appropriate error type based on status code
          switch (statusCode) {
            case 400:
              return ResponseError.badRequest(
                message: serverMessage,
                statusCode: statusCode,
              );
            case 401:
              return ResponseError.unauthorized(
                message: serverMessage,
                statusCode: statusCode,
              );
            case 404:
              return ResponseError.notFound(
                message: serverMessage,
                statusCode: statusCode,
              );
            case 409:
              return ResponseError.conflict(
                message: serverMessage,
                statusCode: statusCode,
              );
            case 422:
              return ResponseError.unprocessableEntity(
                message: serverMessage,
                statusCode: statusCode,
              );
            case 429:
              return ResponseError.tooManyRequests(
                message: serverMessage,
                statusCode: statusCode,
              );
            case 500:
            case 502:
              return ResponseError.internalServerError(
                message: serverMessage,
                statusCode: statusCode,
              );
            default:
              return ResponseError.unexpectedError(
                message: serverMessage,
                statusCode: statusCode,
              );
          }
      }
    }
    return const ResponseError.unexpectedError();
  }
}

extension ResponseErrorExtensions on ResponseError {
  String getErrorMessage() {
    // Use custom message if available, otherwise fall back to default messages
    return switch (this) {
      _NoInternetConnection(:final message) =>
        message ?? "No internet connection. Please check your connection and try again.",
      _SendTimeout(:final message) => message ?? "Request timed out. Please try again later.",
      _ConnectTimeout(:final message) =>
        message ?? "Connection timed out. Please check your connection and try again.",
      _ReceiveTimeout(:final message) =>
        message ?? "Failed to receive response from server. Please try again later.",
      _BadRequest(:final message) => message ?? "Invalid request. Please check your input and try again.",
      _NotFound(:final message) => message ?? "Resource not found. Please try again.",
      _TooManyRequests(:final message) => message ?? "You've made too many requests in a short period. Please try again later.",
      _UnprocessableEntity(:final message) => message ?? "Server encountered an error while processing your request. Please try again later.",
      _InternalServerError(:final message) =>
        message ?? "Internal server error occurred. Please try again later.",
      _UnexpectedError(:final message) => message ?? "An unexpected error occurred. Please try again later or contact support.",
      _RequestCancelled(:final message) => message ??"You cancelled the request.",
      _Conflict(:final message) => message ?? "There was a conflict with your request. Please check your input and try again.",
      _Unauthorized(:final message) => message ?? "You are not authorized to perform this action. Please login or contact support.",
      _InvalidPasswordError(:final message) =>
        message ?? "The password you entered is invalid. Please check your password and try again.",
      _InvalidConfirmPasswordError(:final message) =>
        message ?? "Password confirmation is invalid. Please check your confirmation password and try again.",
      _InvalidEmailError(:final message) => message ?? "The email address you entered is invalid. Please check your email address and try again.",
      _InvalidSearchTermError(:final message) =>
        message ?? "The search term you entered is invalid. Please try a different search term.",
      _InvalidLoginCredentials(:final message) =>
        message ?? "The login credentials you entered are invalid. Please check your username and password and try again.",
      _BadCertificate(:final message) => message ?? "There is a security issue with the website's certificate. Please contact support.",
      _ConnectionError(:final message) =>
        message ?? "There was a network connection error. Please check your internet connection and try again.",
    };
  }
}
