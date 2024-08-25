// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Code `
  String get code {
    return Intl.message(
      'Code ',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `sent To The Email`
  String get sentToTheEmail {
    return Intl.message(
      'sent To The Email',
      name: 'sentToTheEmail',
      desc: '',
      args: [],
    );
  }

  /// `Don't Receive Any Code?`
  String get dontReciveAnyCode {
    return Intl.message(
      'Don\'t Receive Any Code?',
      name: 'dontReciveAnyCode',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the email address you'd like your password reset information sent to`
  String get textOfForgetPassword {
    return Intl.message(
      'Please enter the email address you\'d like your password reset information sent to',
      name: 'textOfForgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Request link`
  String get requestLink {
    return Intl.message(
      'Request link',
      name: 'requestLink',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcomeBack {
    return Intl.message(
      'Welcome back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Let's get your logged in so you can start explore`
  String get letsGetYourLoggedIn {
    return Intl.message(
      'Let\'s get your logged in so you can start explore',
      name: 'letsGetYourLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get emailAddress {
    return Intl.message(
      'Email address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `user name`
  String get username {
    return Intl.message(
      'user name',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Sign up now to receive special offers and updates from our app `
  String get signUpNowToReceive {
    return Intl.message(
      'Sign up now to receive special offers and updates from our app ',
      name: 'signUpNowToReceive',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `choose Your Card`
  String get chooseYourCard {
    return Intl.message(
      'choose Your Card',
      name: 'chooseYourCard',
      desc: '',
      args: [],
    );
  }

  /// `phone`
  String get phone {
    return Intl.message(
      'phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `pet type`
  String get petType {
    return Intl.message(
      'pet type',
      name: 'petType',
      desc: '',
      args: [],
    );
  }

  /// `description`
  String get description {
    return Intl.message(
      'description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `date of meet`
  String get dateOfMeet {
    return Intl.message(
      'date of meet',
      name: 'dateOfMeet',
      desc: '',
      args: [],
    );
  }

  /// `time of meet`
  String get timeOfMeet {
    return Intl.message(
      'time of meet',
      name: 'timeOfMeet',
      desc: '',
      args: [],
    );
  }

  /// `notes`
  String get notes {
    return Intl.message(
      'notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `date of reservation`
  String get dateOfReservation {
    return Intl.message(
      'date of reservation',
      name: 'dateOfReservation',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get confirm {
    return Intl.message(
      'confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
