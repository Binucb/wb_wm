String projectName = "Vantage - Workbench";
String version = "Version 1.3";

List<String> fetchURL(String text) {
  List<String> urlList = [];

  RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  Iterable<RegExpMatch> matches = exp.allMatches(text);

  for (var match in matches) {
    urlList.add(text.substring(match.start, match.end));
  }
  //print(urlList);

  return urlList;
}

Map<String, String> dropDD = {
  "main image url":
      ",-|,Contains Watermark (Fail),Low Quality/Blurred Image (Fail),Image Unavailable on the URL (Fail),Cropped Images (Fail),No URL (Fail),Dropbox/Google Drive Images (Fail),Lifestyle/Label/Scaling Images (Fail),Mismatch with Base Data (Fail)",
  "product type":
      ",Missing/Insufficient Base Data,Different Category PT,Not Part of Closed List,Re-tagged to Correct PT,Image-Content Mismatch|,Missing/Insufficient Base Data,Different Category PT,Not Part of Closed List,Re-tagged to Correct PT,Image-Content Mismatch",
  "product name":
      ",Added Brand,Formatting Errors Fixed,Casing Issues Fixed,Removed special characters/redundant text,Title Structure Fixed,Grammatical Error/Misspelling Fixed|,Missing Information (Fail),Insufficient Character Count (Fail),Missing Key Attributes (Fail)",
  "product short description":
      ",Promotional Text Removed,Special Characters/Redundant Text Removed,Formatting Errors Fixed,Grammatical Error/Misspelling Fixed,Casing Issues Fixed|,Duplicate/Repetition of LD (Fail),SD in Bullet Points (Fail),Insufficient Word Count (Fail)",
  "product long description":
      ",Edited HTML Tags,Promotional Text Removed,Formatting Errors Fixed,Special characters/redundant text Removed,Grammatical Error/Misspelling Fixed,Casing Issues Fixed|,Duplicate/Repetition of SD (Fail),LD in Paragraph (Fail),Insufficient Bullet Points/Word Count (Fail)",
  "product secondary image url":
      ",-|,Contains Watermark (Fail),Low Quality/Blurred Image (Fail),Image Unavailable on the URL (Fail),Cropped Images (Fail),No URL (Fail),Insufficient Image Count (Fail),Dropbox/Google Drive images (Fail)",
  "others":
      ",Curated from Base Data|,Unable to Curate (Fail),Mismatch with Base Data (Fail)"
};

format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
  String add2times({String? t1, String? t2}) {
    
   
  List<String> x1 = t1!.split(":");
     
  Duration a1 = Duration(
      hours: int.parse(x1[0]),
      minutes: int.parse(x1[1]),
      seconds: int.parse(x1[2]));
 List<String>x2 = t2!.split(":");
  Duration a2 = Duration(
      hours: int.parse(x2[0]),
      minutes: int.parse(x2[1]),
      seconds: int.parse(x2[2]));

  return format(a1 + a2);
}
 
