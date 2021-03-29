import 'dart:core';
import 'dart:io';
import 'package:mysql1/mysql1.dart';

void main() async {

  var today = DateTime.now();
  print(DateTime.utc(today.year, today.month, today.day, today.hour, today.minute, today.second));

  var generator = Generator();
  print("==: Product Review Generator :==");

  String templateName = generator.takeTemplateName();
  int templateType = generator.takeTemplateType(templateName);

  String review = generator.convertTemplateToReview(templateName, templateType);
  print("==: Generated Review :==");

  print("Title := " + generator.reviewTitle);
  print("$review");

  // Generated Review into DB Storage
  // Open a connection
  final conn = await MySqlConnection.connect(ConnectionSettings(host: 'localhost',
                                                                port: 3306,
                                                                user: 'mahbubur',
                                                                password: 'Dark_Fantasy_2021',
                                                                db: 'db_DRIFT'));

  // Insert some data
  var productResult = await conn.query('INSERT INTO tbl_product (title, price, category, brand, seller) VALUES (?, ?, ?, ?, ?)',
                                        [generator.productInfo["title"], double.parse(generator.productInfo["price"]),
                                          generator.productInfo["category"], generator.productInfo["brand"],
                                          generator.productInfo["seller"]]);
  print('Inserted row id=${productResult.insertId}');

  var reviewResult = await conn.query('INSERT INTO tbl_review (header, body, product_id, submit_date) VALUES (?, ?, ?, ?)',
                                      [generator.reviewTitle, review, productResult.insertId, DateTime.utc(today.year, today.month, today.day, today.hour, today.minute, today.second)]);
  print('Inserted row id=${reviewResult.insertId}');

  // Finally, close the connection
  await conn.close();
}

class Generator {

  String header = "";
  Map<String, Map<int, String>> template = Map<String, Map<int, String>>();
  Map<String, String> product = Map<String, String>();

  String get reviewTitle {
    return header;
  }

  Map<String, String> get productInfo {
    return product;
  }

  Generator() {
    template.putIfAbsent("3_Paragraph", () {
      Map<int, String> types = Map<int, String>();

      types.putIfAbsent(1, () => "I give this product a 5-star rating because this <product_name_with_some_text> is very strong. The product quality is also very good.\n\n" +
      "I did not find any defects with this <product_name_2>. The <product_feature_1> of this <product_name_3> has <product_feature_1_adjective_1> and is <product_feature_1_adjective_2> for <product_feature_1_adjective_2_object>. Also, it has <product_feature_2> that <product_feature_2_adjective_1>. Compared to other <product_category>, the material of this product has better durability and <product_feature_3>. Also, this product is easy to use <product_feature_3_adjective_1>.\n\n" +
      "I like this product because of its good design and quality. Therefore, I recommend this product to future buyers.");

      types.putIfAbsent(2, () => "I give this product a 5 star rating because this <product_name_with_some_text> is very informative and has multiple functions. The product quality is also very good.\n\n" +
      "I have not found any flaws with this <product_name_2>. It is so <product_feature_1> and equipped with <product_feature_2> that <product_feature_1_adjective_1> and <product_feature_2_adjective_1> on my <product_place_where_it_is_used>. It also has <product_feature_3> that helps to <product_feature_3_adjective_1>. Compared to other <product_category>, this product has better ease of use, <product_feature_4> and <product_feature_5>.\n\n" +
      "I like this product because of its good design and quality. Therefore, I recommend this product to future buyers.");

      types.putIfAbsent(3, () => "This product is rated 5 stars because it has some additional features compared to other <product_category>. These extra features are <product_feature_1>, <product_feature_2> and <product_feature_3>.\n\n" +
      "There are no issues with the product and the product fits properly on my <product_place_where_it_is_used>. However, at first it is not <product_negative_text_1>. Later it is successful with the help of <product_feature_4> provided by the seller, so thanks to the seller for the <product_feature_4> to <product_feature_4_adjective_1>.\n\n" +
      "Because of the smart functionalities and better quality, I like this product very much and at the same time I recommend future buyers to buy this product for their <product_place_where_it_is_used>.");

      types.putIfAbsent(4, () => "Because of the smart and sexy look with excellent <product_feature_1>, I give this product 5 stars. Compared to other <product_category>, this product has a <product_feature_2>, is <product_feature_2_adjective_1>, is <product_feature_2_adjective_2>, and has a <product_feature_3>.\n\n" +
      "There are no issues with the product, and the product fits my <product_place_where_it_is_used> just right. In addition, this product includes <product_feature_4> for <product_feature_4_adjective_1>.\n\n" +
      "Because of the smart functionalities and better quality, I really like this product and recommend future buyers to buy this product.");

      return types;
    });

    template.putIfAbsent("1_Paragraph", () {
      Map<int, String> types = Map<int, String>();

      types.putIfAbsent(1, () => "The price seems to be higher than its features. However, the product is good and the most important thing that I satisfy using this product. So I give this product 5 stars.");
      types.putIfAbsent(2, () => "I am very pleased with this product and specially my dear <product_present_for_someone> loved it so much. Its features are awesome. My <product_present_for_someone> loves the <product_feature_1> and <product_feature_2> features :). So I gave 5 star rating for this product. Thank you <product_seller>.");
      types.putIfAbsent(3, () => "I give this product 5 star rating because its good and the <product_feature_1> is <product_feature_1_adjective_1> for <product_feature_1_adjective_2_object>. Now I can enjoy <product_usage_object> with this <product_name_with_some_text>. I like this <product_name_2> and also the quality is very good. So I recommend others to buy this product.");

      return types;
    });

    template.putIfAbsent("Point_Based", () {
      Map<int, String> types = Map<int, String>();

      types.putIfAbsent(1, () => "5 stars rating for this product because\n" +
          "- <product_feature_1>\n" +
          "- <product_feature_2>\n" +
          "- <product_feature_3>\n" +
          "- <product_feature_4>\n" +
          "- Price is affordable\n" +
          "- <product_feature_5>\n\n" +
          "Considering above attractive features and multi-purpose functionalities, I like this product and give personal recommendation to buy this product.");

      return types;
    });

    template.putIfAbsent("5_Paragraph", () {
      Map<int, String> types = Map<int, String>();

      types.putIfAbsent(1, () => "I love the <product_brand_name> brand because it maintains product quality.\n\n" +
      "I rate this product 5 stars because these <product_name_with_some_text> has <product_feature_1> that is very <product_feature_1_adjective_1>. It is also a perfect <product_feature_2> and <product_feature_3> <product_category>.\n\n" +
      "When I was looking for <product_category>, I looked at this product along with other similar products. The useful features of this product among other similar products are its price and <product_feature_4>. The price is perfect with its brand and the outlook is smart and beautiful.\n\n" +
      "I have been using the <product_name_2> regularly for <product_usage_day_count> days in <product_usage_environment>. Another noteable feature is <product_feature_5> and the service of the <product_name_3> is trouble-free.\n\n" +
      "I really like this product because it is high quality and the service is satisfactory according to the product description. Therefore, I recommend others to buy this product.");

      return types;
    });
  }

  String takeTemplateName() {
    print("==: Choose Template Name :==");
    print("==: 1 = 3_Paragraph :==");
    print("==: 2 = 1_Paragraph :==");
    print("==: 3 = Point_Based :==");
    print("==: 4 = 5_Paragraph :==");

    int input = int.parse(stdin.readLineSync());

    switch(input) {
      case 1: return "3_Paragraph";
      case 2: return "1_Paragraph";
      case 3: return "Point_Based";
      case 4: return "5_Paragraph";
    }

    return "";
  }

  int takeTemplateType(String templateName) {
    print("==: Choose Template Type :==");

    switch (templateName) {
      case "3_Paragraph":  {
        print("==: 1 = Type 1 :==");
        print("==: 2 = Type 2 :==");
        print("==: 3 = Type 3 :==");
        print("==: 4 = Type 4 :==");

        int input = int.parse(stdin.readLineSync());

        switch(input) {
          case 1: return 1;
          case 2: return 2;
          case 3: return 3;
          case 4: return 4;
        }
      }
      break;

      case "1_Paragraph": {
        print("==: 1 = Type 1 :==");
        print("==: 2 = Type 2 :==");
        print("==: 3 = Type 3 :==");

        int input = int.parse(stdin.readLineSync());

        switch(input) {
          case 1: return 1;
          case 2: return 2;
          case 3: return 3;
        }
      }
      break;

      case "Point_Based":
      case "5_Paragraph": print("1");
                          return 1;
    }

    return 0;
  }

  String convertTemplateToReview(String templateName, int templateType) {
    String review = this.template[templateName][templateType];
    Map<String, String> replacements = Map<String, String>();

    print("==: Review Template :==\n$review");
    print("==: Enter Reivew Title :==");

    header = stdin.readLineSync();
    print("==: Enter Values :==");

    String key;
    RegExp(r"(<product\w+>)+").allMatches(review).forEach((match) {
      key = review.substring(match.start, match.end).trim();
      replacements.putIfAbsent(key, () => "");
    });

    for (String key in replacements.keys) {
      print("$key := ");

      String value = stdin.readLineSync();
      replacements.update(key, (v) => v = value );
    }

    replacements.forEach((key, value) => review = review.replaceAll(key, value));

    if (replacements.containsKey("<product_name_with_some_text>")) {
      product.putIfAbsent("title", () => replacements["<product_name_with_some_text>"]);
    } else {
      print("Product Title := ");
      product.putIfAbsent("title", () => stdin.readLineSync());
    }

    if (replacements.containsKey("<product_category>")) {
      product.putIfAbsent("category", () => replacements["<product_category>"]);
    } else {
      print("Product Category := ");
      product.putIfAbsent("category", () => stdin.readLineSync());
    }

    if (replacements.containsKey("<product_brand_name>")) {
      product.putIfAbsent("brand", () => replacements["<product_brand_name>"]);
    } else {
      print("Product Brand := ");
      product.putIfAbsent("brand", () => stdin.readLineSync());
    }

    print("Product Price :=");
    product.putIfAbsent("price", () => stdin.readLineSync());

    print("Product Seller :=");
    product.putIfAbsent("seller", () => stdin.readLineSync());

    return review;
  }
}
