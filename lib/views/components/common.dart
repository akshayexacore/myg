import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../style/colors.dart';

//===========================================================Text Styles

Text thb(text, color) => Text(
      text,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: color),
    );

Text thbAppbar(text, color) => Text(
      text,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: color),
    );

Text ts(text, color, {weight, align}) => Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontFamily: 'Roboto', fontSize: 14, fontWeight: weight, color: color),
    );

Text tssb(text, color, bold, {height}) => Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Roboto',
          height: height,
          fontSize: 16,
          color: color,
          fontWeight: bold),
    );

Text tchcus(text, color, size, {height}) => Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontFamily: 'Roboto',
          height: height,
          fontSize: size,
          color: color,
          fontWeight: FontWeight.w500),
    );

Text tss(text, color, size) => Text(
      text,
      style: TextStyle(fontFamily: 'Roboto', fontSize: size, color: color),
    );

Text tcustom(text, color, size, fontwight, {align, txtdir}) => Text(
      text,
      textDirection: txtdir,
      textAlign: align,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: size,
          fontWeight: fontwight,
          color: color),
    );

Text tcustomhight(text, color, size, fontwight, {align, txtdir, height}) =>
    Text(
      text,
      textDirection: txtdir,
      textAlign: align,
      style: TextStyle(
          fontFamily: 'Lato',
          height: height,
          fontSize: size,
          fontWeight: fontwight,
          color: color),
    );

Text tchead(text, color, size, fontwight, {align, txtdir}) => Text(
      text,
      textDirection: txtdir,
      textAlign: align,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: size,
          fontWeight: fontwight,
          color: color),
    );

Text tcCustomhead(text, color, fontwight, {align, size, txtdir}) => Text(
      text,
      textDirection: txtdir,
      textAlign: align,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: size ?? 23,
          fontWeight: fontwight,
          color: color),
    );

Text tcn(text, color, double size, [height]) => Text(text,
    style: GoogleFonts.poppins(fontSize: size, color: color, height: height));
// Text tcnMELP(text,color,double size,[height]) => Text(text,maxLines: 1,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize: size,color: color,height: height));
// Text tcnL(text,color,double size) => Text(text,style: GoogleFonts.poppins(fontSize: size,color: color),maxLines: 100,);
Text tc(text, color, double size) => Text(text,
    style: GoogleFonts.beVietnamPro(
        fontSize: size, color: color, fontWeight: FontWeight.bold));
// Text tc1(text,color,double size) => Text(text,style: GoogleFonts.aclonica(fontSize: size,color: color,fontWeight: FontWeight.bold));
// Text thL(text,color,double size) => Text(text,style: GoogleFonts.poppins(fontSize: size,color: color,fontWeight: FontWeight.bold),maxLines: 100,);
//
// Text tcHeadBold(text,color) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: 18,color: color,fontWeight: FontWeight.bold));
// Text tcHeadBold1(text,color) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: 16,color: color,fontWeight: FontWeight.bold));
// Text tcHead(text,color) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: 22,color: color,));
// Text tcnBody(text,color) => Text(text,style: GoogleFonts.poppins(fontSize: 12,color: color));
// Text tcnBodyA(text,color,[height]) => Text(text,style: GoogleFonts.poppins(fontSize: 12,color: color,height: height),textAlign: TextAlign.center);
// Text tcnBodyBold(text,color) => Text(text,style: GoogleFonts.poppins(fontSize: 12,color: color,fontWeight: FontWeight.bold));
//
//
// Text tcBody(text,color,[height]) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: 14,color: color,height: height));
// Text tcBodyAlign(text,color,[height,align]) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: 14,color: color,height: height),textAlign: TextAlign.center,);
// Text tcBodyBold(text,color,[height]) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: 14,color: color,fontWeight: FontWeight.bold,height: height));
// Text tcBodyBoldS(text,color,[height]) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: 13.0,color: color,fontWeight: FontWeight.bold,height: height));
// //Strike Line
// Text tcns(text,color,double size) => Text(text,style: GoogleFonts.poppins(fontSize: size,color: color,decoration: TextDecoration.lineThrough));
// Text tcs(text,color,double size) => Text(text,style: GoogleFonts.beVietnamPro(fontSize: size,color: color,fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough));
// Text tcu(text, style) => Text(text,style: style);

//===========================================================Box Decorations
TextStyle hintTextStyle() => TextStyle(
    fontFamily: 'Roboto',
    fontSize: 13.6,
    fontWeight: FontWeight.normal,
    color: Colors.black.withOpacity(0.4));

BoxDecoration boxDecoration(color, double radius) => BoxDecoration(
      color: color,
      boxShadow: [
        BoxShadow(
          color: Colors.blueAccent.withOpacity(0.1),
          blurRadius: 8,
          spreadRadius: 1,
          offset: Offset(4, 4),
        ),
      ],
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );

BoxDecoration boxDecorationS(color, double radius) => BoxDecoration(
      color: color,
      boxShadow: [
        BoxShadow(
          color: Colors.blueAccent.withOpacity(0.09),
          blurRadius: 8,
          spreadRadius: 1,
          offset: Offset(4, 4),
        ),
      ],
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );

BoxDecoration boxDecorationC(
  color,
  double tl,
  double tr,
  double bl,
  double br,
) =>
    BoxDecoration(
      color: color,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.16),
          blurRadius: 2,
          spreadRadius: 1,
          offset: Offset(3, 3),
        ),
      ],
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(tl),
          topRight: Radius.circular(tr),
          bottomLeft: Radius.circular(bl),
          bottomRight: Radius.circular(br)),
    );

BoxDecoration boxBaseDecorationC(
  color,
  double tl,
  double tr,
  double bl,
  double br,
) =>
    BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(tl),
          topRight: Radius.circular(tr),
          bottomLeft: Radius.circular(bl),
          bottomRight: Radius.circular(br)),
    );

BoxDecoration boxBaseDecoration(color, double radius) => BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );

BoxDecoration boxOutlineDecoration(color, double radius) => BoxDecoration(
      color: color,
      border: Border.all(
        color: Colors.black87,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );

BoxDecoration boxOutlineCustom(color, double radius, borderColor) =>
    BoxDecoration(
      color: color,
      border: Border.all(
        color: borderColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );

BoxDecoration boxOutlineShadowCustom(color, double radius, borderColor) =>
    BoxDecoration(
      color: color,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.16),
          blurRadius: 1,
          spreadRadius: 1,
          offset: Offset(2, 2),
        ),
      ],
      border: Border.all(
        color: borderColor,
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );

BoxDecoration boxOutlineCustom2(
        color, double radius, borderColor, borderWidth) =>
    BoxDecoration(
      color: color,
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );

BoxDecoration boxOutlineCustom1(color, double radius, borderColor, width) =>
    BoxDecoration(
      color: color,
      border: Border.all(
        color: borderColor,
        width: width,
      ),
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );

BoxDecoration boxOutlineInput(enablests, focusSts) => BoxDecoration(
      color: enablests ? Colors.white : greyLight.withOpacity(0.5),
      border: Border.all(
        color: enablests
            ? (focusSts ? bgColor : Colors.black.withOpacity(0.5))
            : Colors.grey.withOpacity(0.5),
        width: 0.9,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
    );

BoxDecoration boxImageDecoration(img, double radius) => BoxDecoration(
    image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
    borderRadius: BorderRadius.all(Radius.circular(radius)));

BoxDecoration boxImageDecorationC(
  img,
  double tl,
  double tr,
  double bl,
  double br,
) =>
    BoxDecoration(
      image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(tl),
          topRight: Radius.circular(tr),
          bottomLeft: Radius.circular(bl),
          bottomRight: Radius.circular(br)),
    );

//===========================================================AppBar

AppBar navigationAppBar(context, fnPageBack) => AppBar(
      backgroundColor: Colors.white12,
      elevation: 0,
      leading: Container(
        margin: EdgeInsets.only(left: 10),
        child: InkWell(
          onTap: () {
            fnPageBack();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      actions: [Container()],
    );

AppBar navigationTitleAppBar(context, title, fnPageBack) => AppBar(
      backgroundColor: Colors.white12,
      elevation: 0,
      leading: Container(
        margin: EdgeInsets.only(left: 10),
        child: InkWell(
          onTap: () {
            fnPageBack();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      title: tc(title, Colors.black, 25),
      actions: [Container()],
    );

//===========================================================margin

EdgeInsets pageMargin() =>
    const EdgeInsets.only(left: 25, right: 20, top: 0, bottom: 0);

EdgeInsets gapMargin() =>
    const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0);

//===========================================================padding

EdgeInsets pagePadding() => const EdgeInsets.all(10);

//===========================================================gap

SizedBox gapH() => const SizedBox(
      height: 20,
    );

SizedBox gapHC(double h) => SizedBox(
      height: h,
    );

SizedBox gapW() => const SizedBox(
      width: 20,
    );

SizedBox gapWC(double w) => SizedBox(
      width: w,
    );

//===========================================================Screen

Scaffold pageScreen(child, Size size, context, fnPageBack) => Scaffold(
      appBar: navigationAppBar(context, fnPageBack),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: pagePadding(),
          margin: pageMargin(),
          child: SingleChildScrollView(
            child: child,
          ),
        ),
      ),
    );

Scaffold pageMenuScreen(child, Size size, context, bottom, fnPageBack) =>
    Scaffold(
      appBar: navigationAppBar(context, fnPageBack),
      bottomNavigationBar: bottom,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: pagePadding(),
          margin: pageMargin(),
          child: SingleChildScrollView(
            child: child,
          ),
        ),
      ),
    );

//===========================================================Row

Row clockRow(text) => Row(
      children: [
        const Icon(
          Icons.access_time_rounded,
          size: 15,
        ),
        gapWC(5),
        tcn(text, Colors.black, 15)
      ],
    );

//===========================================================Greeting

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning 😊, ';
  }
  if (hour < 17) {
    return 'Good Afternoon 🌥️, ';
  }
  return 'Good Evening 🌅, ';
}

//===========================================================Line

Container line() => Container(
      height: 1,
      decoration: boxBaseDecoration(Colors.grey, 1),
    );

Container lineC(h, color) => Container(
      height: h,
      decoration: boxBaseDecoration(color, 1),
    );

Widget lineS() {
  return Column(
    children: [
      gapHC(10),
      lineC(1.0, greyLight),
      gapHC(10),
    ],
  );
}

Widget lineSC(height) {
  return Column(
    children: [
      gapHC(height),
      lineC(1.0, greyLight),
      gapHC(height),
    ],
  );
}

//===========================================================Animation

Widget formInput(controller, hint, width, height, errormsg, validate) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcn(hint, bgColor, 12),
      gapHC(2),
      Container(
        height: height ?? 45,
        width: width ?? 300,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: boxBaseDecoration(greyLight, 5),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            suffixIcon: GestureDetector(
              onTap: () {
                controller.text.clear();
              },
              child: Icon(
                Icons.cancel_outlined,
                size: 20,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ),
          validator: (value) {
            if (validate) {
              if (value == null || value.isEmpty) {
                return errormsg;
              }
            }
            return null;
          },
        ),
      ),
    ],
  );
}

//============================================================Buttons

Widget closeButton() {
  return Container(
    height: 35,
    width: 100,
    decoration: boxDecoration(bgColor, 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.close,
          color: Colors.white,
          size: 15,
        ),
        gapWC(5),
        tcn('CANCEL', Colors.white, 12)
      ],
    ),
  );
}

Widget saveButton() {
  return Container(
    height: 35,
    width: 150,
    decoration: boxDecoration(subColor, 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.save,
          color: Colors.white,
          size: 15,
        ),
        gapWC(5),
        tcn('SAVE', Colors.white, 12)
      ],
    ),
  );
}

Widget holdButton() {
  return Container(
    height: 35,
    width: 100,
    decoration: boxDecoration(bgColor, 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.pending_outlined,
          color: Colors.white,
          size: 15,
        ),
        gapWC(5),
        tcn('HOLD', Colors.white, 12)
      ],
    ),
  );
}

Widget customBButton(title, bgcolor, forcolor, icon) {
  return Container(
    height: 35,
    decoration: boxDecoration(bgcolor, 30),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: forcolor,
          size: 15,
        ),
        gapWC(5),
        tcn(title, forcolor, 12)
      ],
    ),
  );
}

Widget customBButtonFlat(title, bgcolor, forcolor, icon) {
  return Container(
    height: 35,
    decoration: boxBaseDecoration(bgcolor, 30),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: forcolor,
          size: 15,
        ),
        gapWC(5),
        tcn(title, forcolor, 12)
      ],
    ),
  );
}

//=============================================================IMAGE CARD

//================================================================RADIO

//======================================================================Date

setDate(mode, DateTime date) {
  var dateRtn = "";
  var formatDate1 = DateFormat('yyyy-MM-dd hh:mm:ss');
  var formatDate2 = DateFormat('yyyy-MM-dd');
  var formatDate3 = DateFormat('yyyy-MM-dd hh:mm a');
  var formatDate4 = DateFormat('yyyy-MM-dd hh:mm:ss a');
  var formatDate5 = DateFormat('hh:mm:ss a');
  var formatDate6 = DateFormat('dd/MM/yyyy');
  var formatDate7 = DateFormat('dd-MM-yyyy hh:mm:ss a');
  var formatDate8 = DateFormat('dd-MM-yyyy hh:mm:ss');
  var formatDate9 = DateFormat('dd-MM-yyyy hh:mm');
  var formatDate10 = DateFormat('hh:mm:ss');
  var formatDate11 = DateFormat('hh:mm a');
  var formatDate12 = DateFormat('yyyy-MM-dd');
  var formatDate13 = DateFormat('dd MMM yyyy hh:mm a');
  var formatDate14 = DateFormat('MMMM');
  var formatDate15 = DateFormat('dd MMM yyyy');
  var formatDate16 = DateFormat('MM/dd/yyyy hh:mm:ss a');
  var formatDate17 = DateFormat('MM');
  var formatDate18 = DateFormat('HH:mm');

  try {
    switch (mode) {
      case 1:
        {
          dateRtn = formatDate1.format(date);
        }
        break;
      case 2:
        {
          dateRtn = formatDate2.format(date);
        }
        break;
      case 3:
        {
          dateRtn = formatDate3.format(date);
        }
        break;
      case 4:
        {
          dateRtn = formatDate4.format(date);
        }
        break;
      case 5:
        {
          dateRtn = formatDate5.format(date);
        }
        break;
      case 6:
        {
          dateRtn = formatDate6.format(date);
        }
        break;
      case 7:
        {
          dateRtn = formatDate7.format(date);
        }
        break;
      case 8:
        {
          dateRtn = formatDate8.format(date);
        }
        break;
      case 9:
        {
          dateRtn = formatDate9.format(date);
        }
        break;
      case 10:
        {
          dateRtn = formatDate10.format(date);
        }
        break;
      case 11:
        {
          dateRtn = formatDate11.format(date);
        }
        break;
      case 12:
        {
          dateRtn = formatDate12.format(date);
        }
        break;
      case 13:
        {
          dateRtn = formatDate13.format(date);
        }
        break;
      case 14:
        {
          dateRtn = formatDate14.format(date);
        }
        break;
      case 15:
        {
          dateRtn = formatDate15.format(date);
        }
        break;
      case 16:
        {
          dateRtn = formatDate16.format(date);
        }
        break;
      case 17:
        {
          dateRtn = formatDate17.format(date);
        }
        break;
      case 18:
        {
          dateRtn = formatDate18.format(date);
        }
        break;
      default:
        {
          //statements;
        }
        break;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  return dateRtn;
}

//================================================== TUTORIAL
mfnDbl(dbl) {
  var lstrDbl = 0.0;

  try {
    lstrDbl = double.parse((dbl ?? '0.0').toString());
  } catch (e) {
    lstrDbl = 0.00;
  }
  return lstrDbl;
}

mfnInt(dbl) {
  var lstrInt = 0;
  try {
    lstrInt = int.parse((dbl ?? '0.0').toString());
  } catch (e) {
    lstrInt = 0;
  }
  return lstrInt;
}
//================================================== SetState

extension StateExt on State {
  void safeState(VoidCallback call) {
    if (mounted) {
      // ignore: invalid_use_of_protected_member
      setState(call);
    }
  }
}

//================================================== OPEN URL
Future<void> _launchUrl(url) async {
  final Uri _url = Uri.parse(url);
  // if (!await launchUrl(_url)) {
  //   throw 'Could not launch $_url';
  // }
}

//================================================== OPEN URL
dprint(msg) {
  if (kDebugMode) {
    print(msg);
  }
}

//================================================== VALUE ASSIGN'

mfnAssign(value) {
  var v = [];
  try {
    v = value;
  } catch (e) {
    v = [];
  }
  return v;
}

List<TextInputFormatter> mfnInputFormatters() {
  List<TextInputFormatter> inputFormatters = [];
  inputFormatters.add(FilteringTextInputFormatter.digitsOnly);

  return inputFormatters;
}

List<TextInputFormatter> mfnInputDecFormatters() {
  List<TextInputFormatter> inputFormatters = [];
  inputFormatters
      .add(FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')));

  return inputFormatters;
}

enum SelectedDate { today, yesterday, month }

dynamic twodigit(number) {
  String formattedNumber = number.toString().padLeft(2, '0');
  return formattedNumber; // Outputs: 03
}

InputDecoration dropdownDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
  border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
      borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
      borderRadius: BorderRadius.circular(10)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
      borderRadius: BorderRadius.circular(10)),
);
