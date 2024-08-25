class MyValidators {
  static String? displayNameValidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'Display name cannot be empty';
    }
    if (displayName.length < 3 || displayName.length > 33) {
      return 'Display name must be between 3 and 33 characters';
    }

    return null; // Return null if display name is valid
  }
  static String? displayFieldValidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'This Field cannot be empty';
    }
    if (displayName.length < 3 || displayName.length > 33) {
      return 'Please write something usefully';
    }

    return null; // Return null if display name is valid
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    const String phonePattern = r'^(?:[+0][1-9])?[0-9]{11}$';
    final regExp = RegExp(phonePattern);
    if (value == null || value.isEmpty) {
      return "Enter your phone number";
    } else if (!regExp.hasMatch(value)) {
      return "Enter a correct number";
    }
    return null;
  }

  static String? petTypeValidator(String? peType) {
    if (peType == null || peType.isEmpty) {
      return 'peType cannot be empty';
    }
    if ( peType.length > 20) {
      return 'peType must be lowe than 20 characters';
    }

    return null; // Return null if display name is valid
  }

  static String? descriptionValidator(String? description) {
    if (description == null || description.isEmpty) {
      return 'description cannot be empty';
    }

    return null; // Return null if display name is valid
  }

  static String? dateOfMeetValidator(String? dateOfMeet) {
    if (dateOfMeet == null || dateOfMeet.isEmpty) {
      return 'date Of Meet cannot be empty';
    }

    return null; // Return null if display name is valid
  }

  static String? notesValidator(String? notes) {
    if (notes == null || notes.isEmpty) {
      return 'notes cannot be empty';
    }

    return null; // Return null if display name is valid
  }

  static String? dateOfReservationValidator(String? dateOfReservation) {
    if (dateOfReservation == null || dateOfReservation.isEmpty) {
      return 'date Of Reservation cannot be empty';
    }

    return null; // Return null if display name is valid
  }



}
