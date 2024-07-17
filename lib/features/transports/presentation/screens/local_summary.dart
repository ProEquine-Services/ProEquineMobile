import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/home/data/join_show_request_model.dart';
import 'package:proequine/features/home/presentation/widgets/summary_widget.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:proequine/features/transports/domain/transport_cubit.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../data/create_transport_response_model.dart';

class LocalSummary extends StatefulWidget {
  final TransportModel? tripServiceDataModel;
  final bool edit;
  final int tripId;
  final JoinShowTransportRequestModel? joinShowTransportRequestModel;

  const LocalSummary(
      {super.key,
      this.tripServiceDataModel,
      this.edit = false,
      this.joinShowTransportRequestModel,
      required this.tripId});

  @override
  State<LocalSummary> createState() => _LocalSummaryState();
}

class _LocalSummaryState extends State<LocalSummary> {
  TransportCubit cubit = TransportCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Summary",
          isThereBackButton: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 14,
            ),
            SummaryBoxWidget(
              tripServiceDataModel: widget.tripServiceDataModel,
            ),
            const Spacer(),
            BlocConsumer<TransportCubit, TransportState>(
              bloc: cubit,
              listener: (context, state) {
                if (state is PushTransportError) {
                  RebiMessage.error(msg: state.message!, context: context);
                } else if (state is PushTransportSuccessfully) {
                  RebiMessage.success(msg: state.message, context: context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavigation(
                              selectedIndex: 1,
                            )),
                  );
                }
              },
              builder: (context, state) {
                if (state is PushTransportLoading) {
                  return const LoadingCircularWidget();
                }
                return RebiButton(
                    //
                    onPressed: () {
                      if (widget.edit &&
                          widget.tripServiceDataModel!.status == 'Draft') {
                        cubit.pushTransport(widget.tripId);
                      } else if (widget.edit) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNavigation(
                                    selectedIndex: 1,
                                  )),
                        );
                      } else {
                        cubit.pushTransport(widget.tripId);
                      }
                    },
                    child: Text(
                      widget.edit ? "Close" : "Submit",
                      style: AppStyles.buttonStyle,
                    ));
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
