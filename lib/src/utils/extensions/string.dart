extension StringExt on String {
  bool isURL() {
    RegExp urlRegExp = RegExp(
      r"^(https?|ftp):\/\/(?:[\w-]+\.){1,}[a-zA-Z]{2,}(?:\/[^\s]*)?$",
      caseSensitive: false,
      multiLine: false,
    );

    return urlRegExp.hasMatch(this);
  }
}
