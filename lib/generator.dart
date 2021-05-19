import 'dart:core';
import 'dart:io';
import 'package:mysql1/mysql1.dart';

void main() async {

  var generator = Generator();
  print("==: Review Generator :==");

  int reviewTypeId = await generator.takeReviewType();

  print("Now, do you want to generate review? [yes / no]");
  String answer = stdin.readLineSync().trim().toLowerCase();

  if (answer == "no") {
    if (reviewTypeId == 0) {
      await generator.storeReviewType();
    }
    exit(0);
  }

  if (answer == "yes" && reviewTypeId == 0) {
    reviewTypeId = await generator.storeReviewType();
  }

  String templateName = generator.takeTemplateName();
  int templateType = generator.takeTemplateType(templateName);

  String review = generator.convertTemplateToReview(templateName, templateType);
  print("==: Generated Review :==");

  print("Title := " + generator.reviewTitle);
  print("$review\n");

  await generator.storeReview(reviewTypeId, review);
}

class Generator {

  String type, header, tmplName;
  int tmplType;
  Map<String, Map<int, String>> template = Map<String, Map<int, String>>();
  Map<String, String> product = Map<String, String>();
  Map<String, String> service = Map<String, String>();

  String get reviewType {
    return type;
  }

  set reviewType(String type) {
    this.type = type;
  }

  String get reviewTitle {
    return header;
  }

  set reviewTitle(String title) {
    this.header = title;
  }

  set templateName(String name) {
    this.tmplName = name;
  }

  set templateType(int type) {
    this.tmplType = type;
  }

  Map<String, String> get productInfo {
    return product;
  }

  set productInfo(Map<String, String> product) {
    this.product = product;
  }

  Map<String, String> get serviceInfo {
    return service;
  }

  Generator() {
    template.putIfAbsent("3_Paragraph", () {
      Map<int, String> types = Map<int, String>();

      types.putIfAbsent(1, () => "I give this <review_type> a 5-star rating because this <product_name_with_some_text> is very strong. The <review_type> quality is also very good.\n\n" +
      "I did not find any defects with this <product_name_2>. The <product_feature_1> of this <product_name_3> has <product_feature_1_adjective_1> and is <product_feature_1_adjective_2> for <product_feature_1_adjective_2_object>. Also, it has <product_feature_2> that <product_feature_2_adjective_1>. Compared to other <product_category>, the material of this <review_type> has better durability and <product_feature_3>. Also, this <review_type> is easy to use <product_feature_3_adjective_1>.\n\n" +
      "I like this <review_type> because of its good design and quality. Therefore, I recommend this <review_type> to future buyers.");

      types.putIfAbsent(2, () => "I give this <review_type> a 5 star rating because this <product_name_with_some_text> is very informative and has multiple functions. The <review_type> quality is also very good.\n\n" +
      "I have not found any flaws with this <product_name_2>. It is so <product_feature_1> and equipped with <product_feature_2> that <product_feature_1_adjective_1> and <product_feature_2_adjective_1> on my <product_place_where_it_is_used>. It also has <product_feature_3> that helps to <product_feature_3_adjective_1>. Compared to other <product_category>, this <review_type> has better ease of use, <product_feature_4> and <product_feature_5>.\n\n" +
      "I like this <review_type> because of its good design and quality. Therefore, I recommend this <review_type> to future buyers.");

      types.putIfAbsent(3, () => "This <review_type> is rated 5 stars because it has some additional features compared to other <product_category>. These extra features are <product_feature_1>, <product_feature_2> and <product_feature_3>.\n\n" +
      "There are no issues with the <review_type> and the <review_type> fits properly on my <product_place_where_it_is_used>. However, at first it is not <product_negative_text_1>. Later it is successful with the help of <product_feature_4> provided by the seller, so thanks to the seller for the <product_feature_4> to <product_feature_4_adjective_1>.\n\n" +
      "Because of the smart functionalities and better quality, I like this <review_type> very much and at the same time I recommend future buyers to buy this <review_type> for their <product_place_where_it_is_used>.");

      types.putIfAbsent(4, () => "Because of the smart and sexy look with excellent <product_feature_1>, I give this <review_type> 5 stars. Compared to other <product_category>, this <review_type> has a <product_feature_2>, is <product_feature_2_adjective_1>, is <product_feature_2_adjective_2>, and has a <product_feature_3>.\n\n" +
      "There are no issues with the <review_type>, and the <review_type> fits my <product_place_where_it_is_used> just right. In addition, this <review_type> includes <product_feature_4> for <product_feature_4_adjective_1>.\n\n" +
      "Because of the smart functionalities and better quality, I really like this <review_type> and recommend future buyers to buy this <review_type>.");

      return types;
    });

    template.putIfAbsent("1_Paragraph", () {
      Map<int, String> types = Map<int, String>();

      types.putIfAbsent(1, () => "The price seems to be higher than its features. However, the <review_type> is good and the most important thing that I satisfy using this <review_type>. So I give this <review_type> 5 stars.");
      types.putIfAbsent(2, () => "I am very pleased with this <review_type> and specially my dear <product_present_for_someone> loved it so much. Its features are awesome. My <product_present_for_someone> loves the <product_feature_1> and <product_feature_2> features :). So I gave 5 star rating for this <review_type>. Thank you <product_seller>.");
      types.putIfAbsent(3, () => "I give this <review_type> a 5 star rating because its good and the <product_feature_1> is <product_feature_1_adjective_1> for <product_feature_1_adjective_2_object>. Now I can enjoy <product_usage_object> with this <product_name_with_some_text>. I like this <product_name_2> and also the quality is very good. So I recommend others to buy this <review_type>.");

      return types;
    });

    template.putIfAbsent("Point_Based", () {
      Map<int, String> types = Map<int, String>();

      types.putIfAbsent(1, () => "5 stars rating for this <review_type> because\n" +
          "- <product_feature_1>\n" +
          "- <product_feature_2>\n" +
          "- <product_feature_3>\n" +
          "- <product_feature_4>\n" +
          "- Price is affordable.\n" +
          "- <product_feature_5>\n\n" +
          "Considering above attractive features and multi-purpose functionalities, I like this <review_type> and give personal recommendation to buy this <review_type>.");

      return types;
    });

    template.putIfAbsent("5_Paragraph", () {
      Map<int, String> types = Map<int, String>();

      types.putIfAbsent(1, () => "I love the <product_brand_name> brand because it maintains <review_type> quality.\n\n" +
      "I rate this <review_type> 5 stars because this <product_name_with_some_text> has <product_feature_1> that is very <product_feature_1_adjective_1>. It is also a perfect <product_feature_2> and <product_feature_3> <product_category>.\n\n" +
      "When I was looking for <product_category>, I looked at this <review_type> along with other similar <review_type>s. The useful features of this <review_type> among other similar <review_type>s are its price and <product_feature_4>. The price is perfect with its brand and the outlook is smart and beautiful.\n\n" +
      "I have been using the <product_name_2> regularly for <product_usage_day_count> days in <product_usage_environment>. Another notable feature is <product_feature_5> and the service of the <product_name_3> is trouble-free.\n\n" +
      "I really like this <review_type> because it is high quality and the service is satisfactory according to the <review_type> description. Therefore, I recommend others to buy this <review_type>.");

      return types;
    });
  }

  Future<int> takeReviewType() async {
    print("==: Enter Review Type (Product or Service) :==");
    this.type = stdin.readLineSync().trim().toLowerCase();

    int reviewTypeId = 0;
    if (this.type == "product") {
      reviewTypeId = await takeProductInfo();
    } else if (this.type == "service") {
      reviewTypeId = await takeServiceInfo();
    }

    return Future.value(reviewTypeId);
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

    review = review.replaceAll("<review_type>", this.type);

    print("==: Review Template :==\n$review");
    print("==: Enter Review Title :==");

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

    return review;
  }

  Future<int> isProductExist(String orderNo, String title) async {
    // Open a connection
    final conn = await MySqlConnection.connect(ConnectionSettings(host: 'db-drift.cygfsaorvowd.eu-central-1.rds.amazonaws.com',
        port: 3306,
        user: 'admin_mahbubur',
        password: 'Dark_Fantasy_2021',
        db: 'db_DRIFT'));

    int productId = 0;

    // Finally, close the connection
    await conn.close();

    return Future.value(productId);
  }

  Future<int> takeProductInfo() async {
    print("==: Enter Product Information :==");

    print("Product Order No :=");
    product.putIfAbsent("order_no", () => stdin.readLineSync());

    print("Product Title := ");
    product.putIfAbsent("title", () => stdin.readLineSync());

    int product_id = await isProductExist(product["order_no"], product["title"]);
    if (product_id > 0) {
      return Future.value(product_id);
    }

    print("Product Category := ");
    product.putIfAbsent("category", () => stdin.readLineSync());

    print("Product Brand := ");
    product.putIfAbsent("brand", () => stdin.readLineSync());

    print("Product Price :=");
    product.putIfAbsent("price", () => stdin.readLineSync());

    print("Product Seller :=");
    product.putIfAbsent("seller", () => stdin.readLineSync());

    print("Product Marketer :=");
    product.putIfAbsent("marketer", () => stdin.readLineSync());

    return Future.value(product_id);
  }

  Future<int> isServiceExist(String title, String provider) async {
    // Open a connection
    final conn = await MySqlConnection.connect(ConnectionSettings(host: 'db-drift.cygfsaorvowd.eu-central-1.rds.amazonaws.com',
        port: 3306,
        user: 'admin_mahbubur',
        password: 'Dark_Fantasy_2021',
        db: 'db_DRIFT'));

    int service_id = 0;

    // Finally, close the connection
    await conn.close();

    return Future.value(service_id);
  }
  
  Future<int> takeServiceInfo() async {
    print("==: Enter Service Information :==");

    print("Service Title := ");
    service.putIfAbsent("title", () => stdin.readLineSync());

    print("Provider :=");
    service.putIfAbsent("provider", () => stdin.readLineSync());

    int service_id = await isServiceExist(service["title"], service["provider"]);
    if (service_id > 0) {
      return Future.value(service_id);
    }

    print("Service Category := ");
    service.putIfAbsent("category", () => stdin.readLineSync());

    print("Provider Platform := ");
    service.putIfAbsent("provider_platform", () => stdin.readLineSync());

    print("Street :=");
    service.putIfAbsent("street", () => stdin.readLineSync());

    print("House Number :=");
    service.putIfAbsent("house_number", () => stdin.readLineSync());

    print("Postal Code :=");
    service.putIfAbsent("postal_code", () => stdin.readLineSync());

    print("Phone :=");
    service.putIfAbsent("phone", () => stdin.readLineSync());

    print("Website :=");
    service.putIfAbsent("website", () => stdin.readLineSync());

    print("Map Coordinates :=");
    service.putIfAbsent("map_coordinates", () => stdin.readLineSync());

    return Future.value(service_id);
  }

  Map<String, String> getReviewTemplateParameters() {
    String review = this.template[tmplName][tmplType];
    Map<String, String> replacements = Map<String, String>();

    String key;
    RegExp(r"(<product\w+>)+").allMatches(review).forEach((match) {
      key = review.substring(match.start, match.end).trim();
      replacements.putIfAbsent(key, () => "");
    });

    return replacements;
  }

  String generateReview(Map<String, String> replacements) {
    String review = this.template[tmplName][tmplType];
    review = review.replaceAll("<review_type>", this.type);
    replacements.forEach((key, value) => review = review.replaceAll(key, value));
    return review;
  }

  Future<int> storeReviewType() async {
    print("#blackmahbub : storeReviewType");

    // Open a connection
    final conn = await MySqlConnection.connect(ConnectionSettings(host: 'db-drift.cygfsaorvowd.eu-central-1.rds.amazonaws.com',
        port: 3306,
        user: 'admin_mahbubur',
        password: 'Dark_Fantasy_2021',
        db: 'db_DRIFT'));

    int reviewTypeId;

    if (reviewType == "product") {
      productInfo.putIfAbsent("marketer", () => "?");
      var productResult = await conn.query(
          'INSERT INTO tbl_product (title, price, category, brand, seller, marketer, order_no) VALUES (?, ?, ?, ?, ?, ?, ?)',
          [
            productInfo["title"],
            double.parse(productInfo["price"]),
            productInfo["category"],
            productInfo["brand"],
            productInfo["seller"],
            productInfo["marketer"],
            productInfo["order_no"]
          ]);
      reviewTypeId = productResult.insertId;
    } else if (reviewType == "service") {
      var serviceResult = await conn.query(
          'INSERT INTO tbl_service (title, provider, provider_platform, category, street, house_number, postal_code, phone, website, map_coordinates) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
          [
            serviceInfo["title"],
            serviceInfo["provider"],
            serviceInfo["provider_platform"],
            serviceInfo["category"],
            serviceInfo["street"],
            serviceInfo["house_number"],
            int.parse(serviceInfo["postal_code"]),
            serviceInfo["phone"],
            serviceInfo["website"],
            serviceInfo["map_coordinates"]
          ]);
      reviewTypeId = serviceResult.insertId;
    }

    print('Inserted row id=${reviewTypeId}');

    // Finally, close the connection
    await conn.close();

    return Future.value(reviewTypeId);
  }

  Future<void> storeReview(int reviewTypeId, String review) async {
    print("#blackmahbub : storeReview");

    // Generated Review into DB Storage
    // Open a connection
    final conn = await MySqlConnection.connect(ConnectionSettings(host: 'db-drift.cygfsaorvowd.eu-central-1.rds.amazonaws.com',
        port: 3306,
        user: 'admin_mahbubur',
        password: 'Dark_Fantasy_2021',
        db: 'db_DRIFT'));

    // final conn = await MySqlConnection.connect(ConnectionSettings(host: 'localhost',
    //     port: 3306,
    //     user: 'mahbubur',
    //     password: 'Dark_Fantasy_2021',
    //     db: 'db_DRIFT'));

    var today = DateTime.now();
    var reviewResult = await conn.query(
        'INSERT INTO tbl_review (header, body, ' + (reviewType == 'product' ? 'product_id' : 'service_id') + ', submit_date) VALUES (?, ?, ?, ?)',
        [
            reviewTitle,
            review,
            reviewTypeId,
            DateTime.utc(today.year, today.month, today.day, today.hour, today.minute, today.second)
        ]);

    print('Inserted row id=${reviewResult.insertId}');

    // Finally, close the connection
    await conn.close();
  }
}
