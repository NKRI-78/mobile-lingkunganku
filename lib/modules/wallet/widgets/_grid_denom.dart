part of '../view/wallet_page.dart';

List<TopUpModel> listMenu = [
  TopUpModel(
    denom: "25.000",
    totalDenom: '27.000',
    amount: 25000,
  ),
  TopUpModel(denom: "50.000", totalDenom: '52.000', amount: 50000),
  TopUpModel(denom: "75.000", totalDenom: '77.000', amount: 75000),
  TopUpModel(denom: "100.000", totalDenom: '102.000', amount: 100000),
  TopUpModel(denom: "200.000", totalDenom: '202.000', amount: 200000),
  TopUpModel(denom: "300.000", totalDenom: '302.000', amount: 300000),
];

class _GridDenom extends StatefulWidget {
  final TextEditingController controller;
  const _GridDenom({required this.controller});

  @override
  State<_GridDenom> createState() => _GridDenomState();
}

class _GridDenomState extends State<_GridDenom> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 1.5,
                ),
                itemCount: listMenu.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context
                          .read<WalletCubit>()
                          .setDenom(listMenu[index].amount.toDouble(), index);
                      widget.controller.text = "";
                    },
                    child: Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: state.selectedCard == index
                                ? Border.all(
                                    color: AppColors.secondaryColor,
                                    width: 2,
                                  )
                                : null,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(top: 35, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                listMenu[index].denom,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -25,
                          child: Image.asset(
                            "assets/icons/coin.png",
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
