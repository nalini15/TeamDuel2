import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:winx/config/colors.dart';
import 'package:winx/functions/widgetFunc.dart';
import 'package:winx/models/wallet.dart';
import 'package:winx/navigatorAnimation/bouncinganagivation.dart';
import 'package:winx/providers/cricketStates.dart';
import 'package:winx/providers/user.dart';
import 'package:winx/screens/getCoins.dart';
import 'package:winx/screens/paymentWithdraw.dart';
import 'package:winx/screens/uploadDoc.dart';
import 'package:winx/services/admob_services.dart';
import 'package:winx/widgets/cricket/matchups/adBanner.dart';

class PayableWinning extends StatefulWidget {
  PayableWinning({Key key}) : super(key: key);

  @override
  _PayableWinningState createState() => _PayableWinningState();
}

class _PayableWinningState extends State<PayableWinning> {
  Future<void> checkKYC(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final res = await user.getKycStatus();
    if (res['status']) {
      showSnack(context, res['msg'], _scaffoldkey);
      Future.delayed(Duration(seconds: 1), () {
        Navigator.push(context, FadeNavigation(widget: UploadDoc()));
      });
    } else {
      showSnack(context, res['msg'], _scaffoldkey);
      final response = await user.getPaymentWithdrawQuation();

      print(response);
      if (!response['status']) {
        showSnack(context, res['msg'], _scaffoldkey);
        return;
      } else {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.push(
              context,
              FadeNavigation(
                  widget: PaymentWithdraw(
                chips: Chips.total,
                data: response,
              )));
        });
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final ams = AdmobService();

  @override
  Widget build(BuildContext context) {
    final states = Provider.of<CricketStates>(context);

    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text(
          "Wallet",
          style: GoogleFonts.roboto(color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          buildSizedBox(buildHeight(context), 0.02),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.mainColorLight, width: 1)),
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      states.changePlayableWinning(1);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: states.payableWining == 0
                            ? AppColors.buttonColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Payable Balance",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: states.payableWining == 0
                                ? Colors.black
                                : AppColors.buttonColor),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      states.changePlayableWinning(0);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      height: 50,
                      decoration: BoxDecoration(
                        color: states.payableWining == 1
                            ? AppColors.buttonColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Winning",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: states.payableWining == 1
                                ? Colors.black
                                : AppColors.buttonColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          buildSizedBox(buildHeight(context), 0.05),
          Consumer<User>(
            builder: (con, user, _) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/toppngBig.png",
                  width: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  states.payableWining == 0
                      ? "${Coins.total}"
                      : "${Chips.total}",
                  style: GoogleFonts.roboto(color: Colors.white),
                )
              ],
            ),
          ),
          buildSizedBox(buildHeight(context), 0.03),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (states.payableWining == 0) {
                  Navigator.of(context)
                      .push(FadeNavigation(widget: GetCoinsChips()));
                } else {
                  if (Chips.total != "0") {
                    checkKYC(context);
                  } else {
                    showSnack(context, "No Chips", _scaffoldkey);
                  }
                }
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 30)),
                  backgroundColor: MaterialStateProperty.all(
                      states.payableWining == 0
                          ? Colors.green
                          : Color.fromRGBO(252, 160, 49, 1))),
              child: Text(
                  states.payableWining == 0
                      ? "Get More Coins"
                      : "Withdraw Fund",
                  style: GoogleFonts.roboto(color: Colors.white)),
            ),
          ),
          buildSizedBox(buildHeight(context), 0.03),
          Consumer<User>(
            builder: (con, user, _) => Expanded(
                child: ListView.builder(
                    itemCount: states.payableWining == 0
                        ? user.getCoins.length
                        : user.getChips.length,
                    itemBuilder: (con, i) {
                      var data;
                      if (states.payableWining == 0) {
                        data = user.getCoins[i];
                      } else {
                        data = user.getChips[i];
                      }
                      Color colordynamic;
                      if (data.type == "Spent") {
                        colordynamic = Colors.red;
                      } else if (data.type == "Winnings") {
                        colordynamic = Colors.green;
                      } else {
                        colordynamic = Colors.white;
                      }
                      return Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColors.mainColorLight,
                            borderRadius: BorderRadius.circular(10)),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 80,
                              child: buildText(
                                  "${DateFormat('dd-M-yyyy').format(DateTime.parse(data.createdAt))}"),
                            ),
                            SizedBox(
                                width: 120,
                                child: buildText("${data.message}")),
                            SizedBox(
                                width: 80,
                                child: buildText("${data.type}", colordynamic)),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/toppngBig.png",
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                buildText("${data.amount}"),
                              ],
                            ),
                          ],
                        ),
                      );
                    })),
          ),
          Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 13),
            color: Colors.black,
            child: Center(
              child: AdBanner(
                stringKey: ams.getBannerAppId(),
                size: AdmobBannerSize.FULL_BANNER,
              ),
            ),
          ),
        ],
      )),
    );
  }

  Text buildText(String text, [Color color]) => Text(
        "$text",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: GoogleFonts.roboto(color: color ?? Colors.white),
      );
}
