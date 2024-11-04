import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../domain/invoices_cubit.dart';
import '../widgets/empty_invoices_screen.dart';
import '../widgets/invoice_tile_widget.dart';
import '../widgets/unpaid_invoices_loading_widget.dart';
import 'invoice_details_screen.dart';

class UserInvoicesScreen extends StatefulWidget {
  const UserInvoicesScreen({super.key});

  @override
  State<UserInvoicesScreen> createState() => _UserInvoicesScreenState();
}

class _UserInvoicesScreenState extends State<UserInvoicesScreen> {
  @override
  void initState() {
    BlocProvider.of<InvoicesCubit>(context).getAllInvoices(limit: 1000);
    super.initState();
  }

  InvoicesCubit cubit = InvoicesCubit();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Unpaid Invoices",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<InvoicesCubit, InvoicesState>(
          bloc: context.read<InvoicesCubit>(),
          builder: (context, state) {
            if (state is GetAllInvoicesSuccessful) {
              String formatDate(DateTime date) {
                // Define the date format
                final dateFormat = DateFormat("MMMM d, yyyy");
                // Format the date
                final formattedDate = dateFormat.format(date);
                return formattedDate;
              }

              if (state.count == 0) {
                return const EmptyInvoicesWidget();
              } else {
                return Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.count,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InvoiceDetailsScreen(
                                              invoice:
                                                  state.responseModel[index],
                                            )));
                              },
                              child: InvoiceTileWidget(
                                date: formatDate(state.responseModel[index]
                                    .invoiceDetails!.date!),
                                status: state.responseModel[index]
                                        .invoiceDetails!.status ??
                                    'Pending',
                                title:
                                    '${state.responseModel[index].amount} AED',
                                invoiceId: state.responseModel[index]
                                    .invoiceDetails!.invoiceNumber
                                    .toString(),
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                );
              }
            }
            if (state is GetAllInvoicesError) {
              return CustomErrorWidget(onRetry: () {
                BlocProvider.of<InvoicesCubit>(context).getAllInvoices(limit: 100);
              });
            } else if (state is GetAllInvoicesLoading) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: InvoicesLoadingWidget()),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
