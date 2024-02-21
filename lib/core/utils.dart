String? validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please Enter Email';
  } else {
    if (!value.contains('@')) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Please Enter Password';
  } else {
    if (value.length < 5) {
      return 'Enter at least 5 chars';
    } else {
      return null;
    }
  }
}
