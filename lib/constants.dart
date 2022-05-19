String projectName = "Vantage - Workbench";
String version = "Version 1.4.19052211";

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

String ret(String tst) {
  String test = "";
  List<String> htmlTags = ["<p>", "<ul>", "</li>", "</ul>"];
  test = tst.replaceAll("</p>", "\n\n");
  test = test.replaceAll("<li>", "\n* ");

  for (String ele in htmlTags) {
    test = test.replaceAll(ele, "");
  }

  return test;
}

Map<String, String> dropPTG = {
  "Choose Category": "Choose PTG",
  "Home":
      "Choose PTG|All Coffee and Tea Appliances & Accessories|All Lamps and Light Bulb Lighting & Light Fixtures|All Novelty Lighting & Light Accessories|All Outdoor Lighting & Light Fixtures|Artifical Plant Decor|Bakeware|Bathroom Accessories|Bedding|Candle Accessories|Ceiling and Wall Lighting & Light Fixtures|Home|Home Decorative Objects|Home Mats & Rugs|Kitchen Brushes, Separators, Molds|Picture & Art Decor|Windows & Wall Decor",
  "Baby": "Choose PTG|Baby|Baby Diapering|Baby Foods & Formulas|Baby Transport",
  "Sports":
      "Choose PTG|All Sport Accessories|Archery|Backpacking & Camping|Sports & Recreation",
  "Arts & Crafts":
      "Choose PTG|Art Supplies|Arts & Crafts|Fabrics, Yarn and Thread|Hooks & Needles|Machines and Cabinets|Quilting Accessories|Sewing Accessories|Sewing, Knitting, and Weaving Kits|Weaving Accessories",
  "Beauty":
      "Choose PTG|Beauty|Fragrance|Hair Care|Hair Tools|Lip Products|Skincare",
  "Health":
      "Choose PTG|Bathroom Aids & Safety|Diabetes Management|Family Planning & Contraceptive|Feminine Care & Incontinence|First Aid|Health|Nutrition & Weight Management|Nutritional Supplements|Oral Care|OTC|Waxing & Hair Removal",
  "Media": "Choose PTG|Books",
  "Furniture": "Choose PTG|Bed|Furniture|Indoor|Outdoor|Table",
  "Apparel":
      "Choose PTG|Full Body Garments|Lower Body Garments|Swimwear|Underwear, Nightwear & Lingerie|Uniforms|Upper Body Garments|Traditional Garments",
  "Food & Beverage":
      "Choose PTG|Added Baking Ingredients|Bakery|Beverages|Beverages Adult Alcohol & Mixers|Coffee & Tea|Dairy & Eggs|Fresh Meat|Grains & Cereals|Prepared & Frozen Foods|Snack Food",
};

Map<String, String> dropDD = {
  "main image url":
      ",-|,Contains Watermark (Fail),Low Quality/Blurred Image (Fail),Image Unavailable on the URL (Fail),Cropped Images (Fail),No URL (Fail),Dropbox/Google Drive Images (Fail),Lifestyle/Label/Scaling Images (Fail),Mismatch with Base Data (Fail)",
  "correct product type":
      ",Missing/Insufficient Base Data,Different Category PT,Not Part of Closed List,Re-tagged to Correct PT,Image-Content Mismatch|,Missing/Insufficient Base Data,Different Category PT,Not Part of Closed List,Re-tagged to Correct PT,Image-Content Mismatch",
  "correct product name":
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
  List<String> x2 = t2!.split(":");
  Duration a2 = Duration(
      hours: int.parse(x2[0]),
      minutes: int.parse(x2[1]),
      seconds: int.parse(x2[2]));

  return format(a1 + a2);
}

//highlight duplicate words
//dupString(text1)

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false);

  return htmlText.replaceAll(exp, ' ');
}

List<String> dupString(String text1) {
  text1 = removeAllHtmlTags(text1);
  text1 = remCommonWords(text1);
  List<String> tst = [];
  List<String> sent = text1.split(".");

  for (String sen in sent) {
    List<String> txt = sen.split(" ");
    for (String wrd in txt) {
      if (wrd != "" && wrd != " ") {
        if (countOccurences(text1, wrd) >= 2 && wrd.length >= 4) {
          tst.add(wrd);
        }
      }
    }
  }
  tst = tst.toSet().toList();
  // print(tst);
  // for (String wrd in tst) {
  //   if (wrd.length <= 3) {
  //     // print(wrd.length);
  //     tst.remove(wrd);
  //   }
  // }
  // print(tst);

  return tst;
}

int countOccurences(String text, String wrd) {
  int count = 0;
  text = text.replaceAll(".", " ");
  List<String> wrdList = text.toLowerCase().split(" ");
  for (String wd in wrdList) {
    if (wd == wrd) {
      count++;
    }
  }

  return count;
}

String remCommonWords(String text) {
  text = text.replaceAll("(", "");
  text = text.replaceAll(")", "");

  List<String> commonWrds = [
    "for",
    "this",
    "that",
    "an",
    "a",
    "but",
    "other",
    "are",
    "is",
    "was",
    "were",
    "has",
    "have",
    "because"
        "to",
    "with",
  ];
  for (String wrds in commonWrds) {
    wrds = " " + wrds + " ";
    text = text.toLowerCase().replaceAll(
          wrds,
          "",
        );
  }

  //print(text);
  return text;
}
