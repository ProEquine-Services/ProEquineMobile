import 'package:flutter/material.dart';

import '../../../../core/widgets/shimmer.dart';

class HorseAssociationsLoadingWidget extends StatefulWidget {
  const HorseAssociationsLoadingWidget({Key? key}) : super(key: key);

  @override
  State<HorseAssociationsLoadingWidget> createState() =>
      _HorseAssociationsLoadingWidgetState();
}

class _HorseAssociationsLoadingWidgetState
    extends State<HorseAssociationsLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        children: [
          const SizedBox(
            height: 7,
          ),
          GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 8,
                childAspectRatio: 0.88,
                crossAxisSpacing: 15,
                crossAxisCount: 2, // Adjust the number of columns
              ),
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 12,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 10),
                  child: ShimmerLoading(
                    isLoading: true,
                    child: Container(
                      height: 180,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
