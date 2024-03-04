String? validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter email';
  } else {
    if (!value.contains('@')) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }
}

String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (value.length < 5) {
      return 'Enter at least 5 chars';
    } else {
      return null;
    }
  }
}

String? validateUsername(String value) {
  if (value.isEmpty) {
    return 'Please enter username';
  } else {
    if (value.length < 3) {
      return 'Enter at least 3 chars';
    } else {
      return null;
    }
  }
}

String? validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return 'Please enter phone number';
  } else {
    if (value.length != 10) {
      return 'Enter 10 digit mobile number';
    } else {
      return null;
    }
  }
}