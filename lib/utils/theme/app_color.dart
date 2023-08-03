part of '../import/app_import.dart';

class AppColors {
  // * Convert Color From Hex #FFFFFF to Flutter 0xFFFFFFFF
  static Color colorFromHex(String hexColor, [String opacity = 'FF']) {
    /// [hexColor] #ffffff
    // * Delete #
    String color = hexColor.replaceAll('#', '');
    // color = FFFFFF;
    String opacityColor = '$opacity$color'; // FFFFFFFF

    return Color(int.parse(opacityColor, radix: 16));
    // 0xFFFFFFFF
  }

  // * color App
  static final Color blueDetailsBG = colorFromHex('#a2e7f5');
  static final Color darkModeCardDetails = colorFromHex('#484848');
  static final Color darkModeBodyDetails = colorFromHex('#303030');
  static final Color lightModeInstallBtn = colorFromHex('#456369');
  static final Color darkModeInstallBtn = colorFromHex('#BB86FC');
  static final Color lightModeUnInstallBtn = colorFromHex('#e95f44');
  static final Color darkModeUnInstallBtn = colorFromHex('#FF0266');
  static final Color lightModeToast = colorFromHex('#90ee02');
  static final Color darkModeToast = colorFromHex('#BB86FC');
  static final Color mb = colorFromHex('#FF0266');

  static final Color red = colorFromHex('#B71c1c');
  static final Color orange = colorFromHex('#F57C00');
  static final Color blackCardSocial = colorFromHex('#000000', '54');

  static final Color cardClick = colorFromHex('#46B5F6');
  static final Color cardClickDark = colorFromHex('#BB86FC');

  static final Color bgWhite = colorFromHex('#FFFFFF');
  static final Color bgBlack = colorFromHex('#000000');
  static final Color bgDark = colorFromHex('#000000');
  static final Color bgCursor = colorFromHex('#3A3B3C');
  static final Color bgGrey = colorFromHex('#C8C8C8');
  static final Color bgGreen = colorFromHex('#A5D6A7');
  static final Color bgGreenBold = colorFromHex('#1B5E20');
  static final Color bgBlue = colorFromHex('#2196F3');
  static final Color bgRed = colorFromHex('#FD1D1D');
  static final Color bgPink = colorFromHex('#BB86FC');
  static final Color star = colorFromHex('#FFC107');

  // * Theme
  static final Color darkMode = colorFromHex('#121212');
  static final Color lightMode = colorFromHex('#fff');
  // * loading
  static final Color lightLoading = colorFromHex('#46B5F6');
  static final Color darkLoading = colorFromHex('#BB86FC');
  // * Tab
  static final Color lightTab = colorFromHex('#46B5F6');
  static final Color darkTab = colorFromHex('#BB86FC');
  // * SnackBar
  static final Color lightModeSnack = colorFromHex('#90ee02');
  static final Color darkModeSnack = colorFromHex('#BB86FC');

  // * Btn Color
  static final List<Color> btnColorsLight = [bgBlue, colorFromHex('#99C5E8')];
  static final List<Color> btnColorsDark = [colorFromHex('#7005F3'), bgPink];
  static final Color splashBtnLight = bgBlue.withOpacity(0.5);
  static final Color splashBtnDark = bgPink.withAlpha(100);

  static final Color backgroundColor = colorFromHex("#131C21");
  static final Color textColor = colorFromHex('#F1F1F2');
  static final Color appBarColor = colorFromHex('#1F2C34');
  static final Color webAppBarColor = colorFromHex('#2A2F32');
  static final Color messageColor = colorFromHex('#056062');
  static final Color senderMessageColor = colorFromHex('#252D31');
  static final Color tabColor = colorFromHex('#00A783');
  static final Color searchBarColor = colorFromHex('#323739');
  static final Color dividerColor = colorFromHex('#252D32');
  static final Color chatBarMessage = colorFromHex('#1E2428');
  static final Color mobileChatBoxColor = colorFromHex('#1F2C34');
}
