import 'package:flutter/cupertino.dart';

enum IconConstants {
  ellipse1('ic_ellipse1'),
  ellipse2('ic_ellipse2'),
  ellipse3('ic_ellipse3'),
  back('ic_back'),
  logo('ic_logo'),
  background('ic_background'),
  facebook('ic_facebook'),
  google('ic_google'),
  twitter('ic_twitter'),
  home('ic_home'),
  fav('ic_fav'),
  book('ic_book'),
  comment('ic_comment'),
  account('ic_account'),
  live('ic_live'),
  body('ic_body'),
  user('ic_user'),
  doc('ic_doc'),
  dinner('ic_dinner'),
  payment('ic_payment'),
  stripe('ic_stripe'),
  sidebar('ic_sidebar'),
  appback('ic_appback'),
  background2('ic_backgrond2'),
  card1('ic_card1'),
  card2('ic_card2'),
  card3('ic_card3'),
  card4('ic_card4'),
  card5('ic_card5'),
  illu('ic_illu'),
  people('ic_people');

  final String value;
  // ignore: sort_constructors_first
  const IconConstants(this.value);

  String get toPng => 'assets/icons/$value.png';
  Image get toImage => Image.asset(toPng);
  ImageIcon get toIcon => ImageIcon(AssetImage(toPng));
}

enum ImageConstants {
  dietitian('dietitian');

  final String value;

  const ImageConstants(this.value);

  String get toPng => 'assets/images/$value.png';
  Image get toImage => Image.asset(toPng);
}
