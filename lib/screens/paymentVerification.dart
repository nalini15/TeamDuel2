import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/auth.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/homeScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentVerification extends StatefulWidget {
  final Map<String, dynamic> data;
  PaymentVerification({Key key, this.data}) : super(key: key);

  @override
  _PaymentVerificationState createState() => _PaymentVerificationState();
}

class _PaymentVerificationState extends State<PaymentVerification> {
  Map<String, String> userMail = {
    "user_id": '',
    "verification_code": '',
    "request_id": '',
  };
  final _formKey = GlobalKey<FormState>();
  bool hasError = false;
  int pinLength = 4;
  bool loading = false;
  TextEditingController controller = TextEditingController(text: "");
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool resendLoading = false;
  Future<void> _submit(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    userMail['request_id'] = widget.data['request_id'].toString();
    userMail['verification_code'] = controller.text;
    print(userMail);
    setState(() => loading = true);
    final res = await user.paymentVerify(userMail);
    setState(() => loading = false);
    if (!res['status']) {
      showSnack(context, res['msg'], _scaffoldkey);
      return;
    }
    showSnack(context, res['msg'], _scaffoldkey);
    await user.userData();
    await user.getWallet();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(context, FadeNavigation(widget: HomeScreen()));
    });
  }

  Future<void> resendOtp() async {
    final user = Provider.of<User>(context, listen: false);
    setState(() => resendLoading = true);
    final res =
        await user.resendPaymentOTP(widget.data['request_id'].toString());
    if (!res['status']) {
      showSnack(context, res['msg'], _scaffoldkey);
      return;
    }
    showSnack(context, res['msg'], _scaffoldkey);

    setState(() => resendLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: AppColors.mainColor,
      appBar: buildAppBarHome(context, 'Payment Verification'),
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSizedBox(buildHeight(context), 0.02),
              Text(
                '${widget.data['msg']}',
                style: GoogleFonts.roboto(color: Colors.white),
              ),
              buildSizedBox(buildHeight(context), 0.07),
              PinCodeTextField(
                autofocus: true,
                controller: controller,
                highlight: true,
                highlightColor: AppColors.mainColorLight,
                defaultBorderColor: AppColors.mainColorLight,
                hasTextBorderColor: AppColors.mainColorLight,
                isCupertino: true,
                pinBoxRadius: 4,
                maxLength: pinLength,
                hasError: hasError,
                onTextChanged: (text) {
                  setState(() {
                    hasError = false;
                  });
                },
                onDone: (text) {
                  print("DONE $text");
                  print("DONE CONTROLLER ${controller.text}");
                },
                wrapAlignment: WrapAlignment.spaceAround,
                pinBoxDecoration:
                    ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                pinTextStyle:
                    GoogleFonts.roboto(fontSize: 30.0, color: Colors.white),
                pinTextAnimatedSwitcherTransition:
                    ProvidedPinBoxTextAnimation.scalingTransition,
                pinBoxColor: AppColors.mainColorLight,
                pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                highlightAnimation: true,
                highlightAnimationBeginColor: AppColors.mainColorLight,
                highlightAnimationEndColor: AppColors.mainColorLight,
                keyboardType: TextInputType.number,
              ),
              buildSizedBox(buildHeight(context), 0.04),
              AnimatedContainer(
                duration: Duration(seconds: 1),
                height: controller.text.length == 4 ? null : 0,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: buildWidth(context) * 0.55,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          _submit(context);
                        },
                        color: AppColors.buttonColor,
                        elevation: 4,
                        animationDuration: Duration(milliseconds: 350),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: loading
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              )
                            : Text(
                                'Verify',
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: 18),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              buildSizedBox(buildHeight(context), 0.02),
              GestureDetector(
                onTap: () {
                  resendOtp();
                  // showSnack(context, 'OTP resent successfully');
                },
                child: Text(resendLoading ? 'Loading...' : 'Resend OTP',
                    style:
                        GoogleFonts.roboto(color: Colors.grey, fontSize: 18)),
              )
            ],
          ),
        ),
      )),
    );
  }
}
