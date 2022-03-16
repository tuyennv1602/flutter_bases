part of 'error_to_string_mapper.dart';

///
abstract class ErrorToStringMapperItem {
  ErrorToStringMapperItem(this.key);

  final String key;

  String getDisplay(BuildContext context, dynamic exception) {
    return key.translate(context);
  }

  bool isMatch(dynamic exception);
}

///
class NoNetworkMapperItem extends ErrorToStringMapperItem {
  NoNetworkMapperItem() : super('common.network_issue_pls_try_again');

  @override
  bool isMatch(dynamic exception) => exception is NetworkIssueException;
}

class GeneralErrorMapperItem extends ErrorToStringMapperItem {
  GeneralErrorMapperItem() : super('common.general_error');

  @override
  bool isMatch(dynamic exception) => true;
}

class HttpErrorMapperItem extends ErrorToStringMapperItem {
  HttpErrorMapperItem(String key) : super(key);

  @override
  bool isMatch(dynamic exception) => exception is HttpCallException;
}

class ApiErrorStringMapperItem extends ErrorToStringMapperItem {
  ApiErrorStringMapperItem() : super('');

  @override
  String getDisplay(BuildContext context, dynamic exception) {
    if (exception is ApiErrorException && exception.hasError) {
      return exception.error ?? '';
    }
    return "";
  }

  @override
  bool isMatch(dynamic exception) => exception is ApiErrorException && exception.hasError;
}
