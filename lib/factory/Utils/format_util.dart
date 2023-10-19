class FormatUtil{

  static final FormatUtil collection = FormatUtil();

  String? formattedDate(DateTime date){
    late String strMonth;
    int mnth = date.month;

    switch (mnth) {
      case 1:
          strMonth = "Januari";
          break;
      case 2:
          strMonth = "Februari";
          break;
      case 3:
          strMonth = "Maret";
          break;
      case 4:
          strMonth = "April";
          break;
      case 5:
          strMonth = "Mei";
          break;
      case 6:
          strMonth = "Juni";
          break;
      case 7:
          strMonth = "Juli";
          break;
      case 8:
          strMonth = "Agustus";
          break;
      case 9:
          strMonth = "September";
          break;
      case 10:
          strMonth = "Oktober";
          break;
      case 11:
          strMonth = "November";
          break;
      case 12:
          strMonth = "Desember";
          break;
      default: strMonth = "-";
    }
    return "${date.day} $strMonth ${date.year}";
  }

}