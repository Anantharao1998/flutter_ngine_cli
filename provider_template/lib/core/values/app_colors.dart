import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  //Grey
  static const white = Color(0xffffffff);
  static const grey = Colors.grey;
  static const grey50 = Color(0xFFF3F4F5);
  static const grey100 = Color(0xFFE6E8EC);
  static const grey200 = Color(0xFFD4D6DB);
  static const grey300 = Color(0xFFB0B4BB);
  static const grey400 = Color(0xFF8D919A);
  static const grey500 = Color(0xFF696F7A);
  static const grey550 = Color(0xFF575D68);
  static const grey600 = Color(0xFF464C59);
  static const grey700 = Color(0xFF323742);
  static const grey800 = Color(0xFF1D222B);
  static const grey900 = Color(0xFF0D1017);

  //Teal
  static const teal50 = Color(0xFFE9F7F8);
  static const teal100 = Color(0xFFDCF0F3);
  static const teal200 = Color(0xFF99DADE);
  static const teal300 = Color(0xFF5EC4C7);
  static const teal400 = Color(0xFF27B6BA);
  static const teal500 = Color(0xFF31A7AA);
  static const teal600 = Color(0xFF259295);
  static const teal700 = Color(0xFF137679);
  static const teal800 = Color(0xFF096669);
  static const teal900 = Color(0xFF004F51);

  //Blue
  static const blue = Color(0xff4285F4);
  static const blue50 = Color(0xFFF1F7FB);
  static const blue100 = Color(0xFFBBDAEF);
  static const blue200 = Color(0xFF96C0DD);
  static const blue300 = Color(0xFF72ADD6);
  static const blue400 = Color(0xFF4882AB);
  static const blue500 = Color(0xFF2C6A95);
  static const blue600 = Color(0xFF1F5C87);
  static const blue700 = Color(0xFF184C71);
  static const blue800 = Color(0xFF154566);
  static const blue900 = Color(0xFF0D344F);

  //Green
  static const green50 = Color(0xFFD6F5DD);
  static const green100 = Color(0xFFABECB9);
  static const green200 = Color(0xFF89DD9B);
  static const green300 = Color(0xFF72D186);
  static const green400 = Color(0xFF62C276);
  static const green500 = Color(0xFF52B166);
  static const green600 = Color(0xFF45A359);
  static const green700 = Color(0xFF409752);
  static const green800 = Color(0xFF348846);
  static const green900 = Color(0xFF1E7731);

  //Red
  static const red50 = Color(0xFFFBE3E0);
  static const red100 = Color(0xFFF8BCB6);
  static const red200 = Color(0xFFF2938A);
  static const red300 = Color(0xFFF2938A);
  static const red400 = Color(0xFFE95E51);
  static const red500 = Color(0xFFD5493B);
  static const red600 = Color(0xFFC0392C);
  static const red700 = Color(0xFFB12C1F);
  static const red800 = Color(0xFF9F1F13);
  static const red900 = Color(0xFF76150C);

  //Purple
  static const purple50 = Color(0xFFF2EFFC);
  static const purple100 = Color(0xFFD8D1F7);
  static const purple200 = Color(0xFFB2A4EF);
  static const purple300 = Color(0xFF9B8AED);
  static const purple400 = Color(0xFF7E68E5);
  static const purple500 = Color(0xFF715AD4);
  static const purple600 = Color(0xFF5F4DB0);
  static const purple700 = Color(0xFF5544A1);
  static const purple800 = Color(0xFF463888);
  static const purple900 = Color(0xFF332670);

  //Amber
  static const amber50 = Color(0xFFFFF7E9);
  static const amber50_2 = Color(0xFFFFF4E8);
  static const amber100 = Color(0xFFFFF1D8);
  static const amber100_2 = Color(0xFFFFDFBB);
  static const amber150 = Color(0xFFFFDFBB);
  static const amber200 = Color(0xFFFFE0A8);
  static const amber300 = Color(0xFFFFC866);
  static const amber400 = Color(0xFFFFB024);
  static const amber500 = Color(0xFFF9A50F);
  static const amber600 = Color(0xFFFF941D);
  static const amber700 = Color(0xFFF6892D);
  static const amber800 = Color(0xFFDA8B00);
  static const amber900 = Color(0xFFCB8200);

  //Others
  static const Color pageBackground = Color(0xFFFAFBFD);
  static const Color statusBarColor = Color(0xFF38686A);
  static const Color appBarColor = Color(0xFF38686A);
  static const Color appBarIconColor = Color(0xFFFFFFFF);
  static const Color appBarTextColor = Color(0xFFFFFFFF);

  static const Color centerTextColor = Colors.grey;
  static const MaterialColor colorPrimarySwatch = Colors.cyan;
  static const Color colorPrimary = Color(0xFF38686A);
  static const Color colorAccent = Color(0xFF38686A);
  static const Color colorLightGreen = Color(0xFF00EFA7);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color lightGreyColor = Color(0xFFC4C4C4);
  static const Color errorColor = Color(0xFFAB0B0B);
  static const Color colorDark = Color(0xFF323232);

  static const Color buttonBgColor = colorPrimary;
  static const Color disabledButtonBgColor = Color(0xFFBFBFC0);
  static const Color defaultRippleColor = Color(0x0338686A);

  static const Color textColorPrimary = Color(0xFF323232);
  static const Color textColorSecondary = Color(0xFF9FA4B0);
  static const Color textColorTag = colorPrimary;
  static const Color textColorGreyLight = Color(0xFFABABAB);
  static const Color textColorGreyDark = Color(0xFF979797);
  static const Color textColorBlueGreyDark = Color(0xFF939699);
  static const Color textColorCyan = Color(0xFF38686A);
  static const Color textColorWhite = Color(0xFFFFFFFF);
  static Color searchFieldTextColor = const Color(0xFF323232).withOpacity(0.5);

  static const Color iconColorDefault = Colors.grey;

  static Color barrierColor = const Color(0xFF000000).withOpacity(0.5);

  static Color timelineDividerColor = const Color(0x5438686A);

  static const Color gradientStartColor = Colors.black87;
  static const Color gradientEndColor = Colors.transparent;
  static const Color silverAppBarOverlayColor = Color(0x80323232);

  static const Color switchActiveColor = colorPrimary;
  static const Color switchInactiveColor = Color(0xFFABABAB);
  static Color elevatedContainerColorOpacity = Colors.grey.withOpacity(0.5);
  static const Color suffixImageColor = Colors.grey;

  //Modal Background
  static Color modalBackground = const Color(0xFF0D1017).withOpacity(0.75);
}
