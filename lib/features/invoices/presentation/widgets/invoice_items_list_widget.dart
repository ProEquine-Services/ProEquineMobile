import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/widgets/divider.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../data/user_invoices_response_model.dart';

class InvoiceItemsListWidget extends StatelessWidget {
  final List<LineItem> items;

  const InvoiceItemsListWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 210,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    items[index].name!,
                    style: const TextStyle(
                      color: Color(0xFF232F39),
                      fontSize: 12,
                      fontFamily: 'Noto Sans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${items[index].quantity} x',
                      style: const TextStyle(
                        color: Color(0xFF9D9898),
                        fontSize: 12,
                        fontFamily: 'Noto Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 75,
                      child: Text(
                        '${items[index].itemTotal} AED',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
          separatorBuilder: (context, index) {
            return CustomDivider();
          },
          itemCount: items.length),
    );
  }
}
