import 'package:dartz/dartz.dart';
import 'package:new_quakka/features/payment/data/models/payment_intent_input_model.dart';
import 'package:new_quakka/features/payment/errors.dart';

abstract class CheckoutRepo {

  Future<Either<Failure,void>> makePayment(
  {required PaymentIntentInputModel paymentIntentInputModel});

}

