import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../misc/text_style.dart';
import '../cubit/wallet_cubit.dart';

import '../../../misc/colors.dart';
import '../../../misc/price_currency.dart';
import '../../../widgets/header/header_text.dart';
import '../models/top_up_model.dart';

part '../widgets/_grid_denom.dart';
part '../widgets/_field_nominal.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletCubit()..fetchProfile(),
      child: WalletView(),
    );
  }
}

class WalletView extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, st) {
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 10, right: 20, left: 20),
            child: InkWell(
              onTap: () {
                context.read<WalletCubit>().checkTopUp(context);
              },
              child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(16)),
                child: const Center(
                  child: Text(
                    "Top-Up",
                    style: TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.grey[300],
          body: CustomScrollView(
            slivers: [
              const HeaderText(text: "Topup e-Wallet"),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 80,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.shade900,
                                Colors.green.shade500,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Member Name",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      st.profile?.profile?.fullname ?? "",
                                      style: AppTextStyles.textProfileNormal,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),

                              // Garis Pemisah di Tengah
                              Container(
                                width: 2,
                                height: 40,
                                color: Colors.white.withOpacity(0.6),
                              ),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Saldo e-Wallet",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      '${Price.currency(st.profile?.balance?.toDouble() ?? 0)}',
                                      style: AppTextStyles.textProfileNormal,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  _GridDenom(
                    controller: controller,
                  ),
                  _FieldNominal(
                    controller: controller,
                  ),
                ])),
              )
            ],
          ),
        );
      },
    );
  }
}
