import 'package:betta/models/model_product.dart';
import 'package:flutter/material.dart';

class ProductCardItem extends StatelessWidget {
  ProductCardItem({Key key, this.item, this.local}) : super(key: key);

  final ProductModel item;
  final Locale local;

  @override
  Widget build(BuildContext context) {
    print(local.languageCode);
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            offset: Offset(1, 0),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      // "assets/images/${item.type.toString().split('.').last}/${item.category}/${item.id}.jpg"),
                      "assets/images/bottle/wide/1.jpg"),
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 5),
            // color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  local.languageCode == 'en' ? item.name : item.nameTH,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                ),
                Text(
                  item.price.toString(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
