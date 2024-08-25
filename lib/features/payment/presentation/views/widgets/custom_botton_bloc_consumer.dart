import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_quakka/core/widges/custom_button.dart';
import 'package:new_quakka/features/payment/data/models/amount_model.dart';
import '../../../../../core/shared_constabts.dart';
import '../../../api_keys.dart';
import '../../../data/models/item_list_model.dart';
import '../../manager/cuibt/payment_cuibt.dart';
import '../../manager/cuibt/payment_state.dart';
import '../thank_you_view.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit,PaymentState>(
      listener: (context,state) {
        if(state is PaymentSuccess){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ThankYouView()));
        }
        if(state is PaymentFailure){
          Navigator.pop(context);

          Constants.showToast(msg: state.errMessage,
          color: Colors.red,gravity: ToastGravity.BOTTOM );
        }
      },
      builder: (context,state) {
        return CustomButton(
          isLoading: state is PaymentLoading ? true : false,
          text: 'Continue',

          onTap: (){

            var transactionsData = getTransactionsData();
             //For Paypal Method

            exceutePaypalPayment(context,transactionsData);

            //For Sripe Method
            // //Trigger payment cuibt
            // //بتشوف بيانات الاوردر وبتستخدمها هنا
            // PaymentIntentInputModel paymentIntentInputModel =
            // PaymentIntentInputModel(
            //     amount: '100',
            //     currency: 'USD',
            //     customerId: 'cus_QaXWjZcVip7wwZ'
            // );   //خلي بالك ال amount هنا بيقسم علي 100
            // BlocProvider.of<PaymentCubit>(context).makePayment(paymentIntentInputModel: paymentIntentInputModel);
          },
        );
      },
    );

  }

  //paypal methods
  void exceutePaypalPayment (BuildContext context, ({AmountModel amount, ItemListModel itemList}) transactionsData ){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKeys.clientID,
        secretKey: ApiKeys.paypalSecretKey,
        transactions:  [
          {
            "amount": transactionsData.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": transactionsData.itemList.toJson(),
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.pop(context);
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }
  ({AmountModel amount, ItemListModel itemList}) getTransactionsData() {
    var amount = AmountModel(
      currency: 'USD',
      total: "100",
      details: AmountDetailsModel(
        shipping: '0',
        shippingDiscount: 0,
        subtotal: '100',
      ),
    );

    List<ItemModel> items = [
      ItemModel(
        name: "computer",
        quantity: 10,
        price: "4",
        currency: "USD",
      ),
      ItemModel(
        name: "apple",
        quantity: 12,
        price: "5",
        currency: "USD",
      ),
      // Optional
      //   "shipping_address": {
      //     "recipient_name": "Tharwat samy",
      //     "line1": "tharwat",
      //     "line2": "",
      //     "city": "tharwat",
      //     "country_code": "EG",
      //     "postal_code": "25025",
      //     "phone": "+00000000",
      //     "state": "ALex"
      //  },
    ];

    var itemList = ItemListModel(
      items: items,
    );

    return (amount: amount, itemList: itemList);
  }
}
