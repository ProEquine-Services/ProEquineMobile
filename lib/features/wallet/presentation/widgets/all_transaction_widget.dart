import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/wallet/presentation/widgets/transaction_widget.dart';
import 'package:proequine_dev/features/wallet/presentation/widgets/transactions_loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../data/transactions_response_model.dart';
import '../../domain/wallet_cubit.dart';

class AllTransactionsWidget extends StatefulWidget {
  const AllTransactionsWidget({super.key});

  @override
  AllTransactionsWidgetState createState() => AllTransactionsWidgetState();
}

class AllTransactionsWidgetState extends State<AllTransactionsWidget> {
  ScrollController scrollController = ScrollController();
  WalletCubit cubit = WalletCubit();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    context.read<WalletCubit>().getAllTransactions(limit: 10);
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: BlocConsumer<WalletCubit, WalletState>(
        bloc: context.read<WalletCubit>(),
        listener: (context, state) {
          if (state is GetTransactionsError) {
            RebiMessage.error(msg: state.message!,context: context);
          } else if (state is GetTransactionsSuccessfully) {
            Print("refreshController.refreshCompleted()");
            refreshController.refreshCompleted();

            if (state.transactions.length >= state.count) {
              refreshController.loadNoData();
              Print("refreshController.loadNoData();");
            } else {
              refreshController.loadComplete();
              Print("refreshController.loadComplete()");
            }
          }
        },
        builder: (context, state) {
          if (state is GetTransactionsError) {
            return Container();
          } else if (state is GetTransactionsLoading) {
            return  const TransactionsLoadingWidget();
          } else if (state is GetTransactionsSuccessfully) {
            if (state.transactions.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: 265,
                      child: Text(
                        'No Transactions..'.tra,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return _smartRefresher(
                state.transactions,
              );
            }
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  _smartRefresher(
    List<Transaction> transactions,
  ) {
    return SizedBox(
      // height: 100.0.h,
      child: Scrollbar(
        controller: scrollController,
        child: SmartRefresher(

          controller: refreshController,
          enablePullDown: false,
          enablePullUp: true,
          header:  const WaterDropHeader(
            waterDropColor: AppColors.gold,
          ),
          onRefresh: () {
            // context.read<WalletCubit>().getAllTransactions(
            //       limit: 8,
            //       isRefreshing: true,
            //     );
            return;
          },
          onLoading: () {
            BlocProvider.of<WalletCubit>(context).getAllTransactions(
              limit: 8,
              loadMore: true,
              // fullName: widget.followerName,
            );
            return;
          },
          child: buildTransactionsList(transactions),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("".tra);
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!".tra);
              } else if (mode == LoadStatus.canLoading) {
                body = const SizedBox.shrink();
              } else {
                body = Center(child: Text("".tra));
              }
              return body;
            },
          ),
        ),
      ),
    );
  }

  buildTransactionsList(List<Transaction> transactions) {
    return ListView.separated(
        controller: scrollController,
        itemCount: transactions.length,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (context,index){
          return const SizedBox(height: 20,);
        },
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == (transactions.length)) {
            return SizedBox(
              height: 4.5.h,
            );
          }
          return Column(
            children: [
              TransactionWidget(
                amount: transactions[index].amount!,
                type: transactions[index].type!,
                date: transactions[index].createdAt!,
                description: transactions[index].description!,
              ),
            ],
          );
        });
  }
}
