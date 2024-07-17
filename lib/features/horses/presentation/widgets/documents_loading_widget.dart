import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/shimmer.dart';
import 'document_widget.dart';

class DocumentsLoadingWidget extends StatefulWidget {
  const DocumentsLoadingWidget({Key? key}) : super(key: key);

  @override
  State<DocumentsLoadingWidget> createState() => _DocumentsLoadingWidgetState();
}

class _DocumentsLoadingWidgetState extends State<DocumentsLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ScrollConfiguration(
        behavior:
        ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:  const EdgeInsets.symmetric(
                            horizontal: kPadding, vertical: 7),
                        child: ShimmerLoading(
                          isLoading: true,
                          child: DocumentWidget(
                              title: '',
                              category: '',
                          onTapEdit: (){},),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
