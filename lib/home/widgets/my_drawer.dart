import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:o_kay_sellers/address/screens/address_screen.dart';
import 'package:o_kay_sellers/authentication/screens/authentication_screen.dart';
import 'package:o_kay_sellers/constants/colors.dart';
import 'package:o_kay_sellers/order_history/screens/order_history_screen.dart';
import 'package:o_kay_sellers/providers/authentication_provider.dart';
import 'package:o_kay_sellers/register_shop/screens/register_shop_screen.dart';
import 'package:o_kay_sellers/widgets/my_alert_dialog.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  final BuildContext parentContext;
  const MyDrawer({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    final ap = context.read<AuthenticationProvider>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Builder(builder: (c) {
            return DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 16, 2, 214),
                  border: Border.all(color: Color.fromARGB(255, 16, 2, 214)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          ap.name!.isNotEmpty ? ap.name!.substring(0, 1) : 'F',
                          style: TextStyle(
                            color: Color.fromARGB(255, 16, 2, 214),
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RegisterShopScreen.routeName);
                      },
                      child: Text(
                        ap.name!.isNotEmpty ? ap.name! : 'Kay',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ));
          }),
          listTile(
            context,
            'Orders History',
            Icons.my_library_books_outlined,
            () {
              Navigator.pushNamed(context, OrderHistoryScreen.routeName);
            },
          ),
          listTile(
            context,
            'Addresses',
            Icons.location_on_outlined,
            () {
              Navigator.pushNamed(context, AddressScreen.routeName);
            },
          ),
          listTile(
            context,
            'Help center',
            Icons.help_outline_outlined,
            () {
              Navigator.pop(context);
            },
          ),
          Container(
            height: 1,
            color: MyColors.borderColor,
          ),
          listTile(
            context,
            'Settings',
            null,
            () {
              Navigator.pop(context);
            },
          ),
          listTile(
            context,
            'Terms & Conditions / Privacy',
            null,
            () {
              Navigator.pop(context);
            },
          ),
          Builder(builder: (c) {
            return listTile(
              context,
              'Log out',
              null,
              () {
                Scaffold.of(c).closeDrawer();
                showDialog(
                  context: c,
                  builder: (ctx) => MyAlertDialog(
                    title: 'Logging out?',
                    subtitle: 'Thanks for stopping by. See you again soon!',
                    action1Name: 'Cancel',
                    action2Name: 'Log out',
                    action1Func: () {
                      Navigator.pop(ctx);
                    },
                    action2Func: () async {
                      await ap.userSignOut();

                      Navigator.pushNamedAndRemoveUntil(ctx,
                          AuthenticationScreen.routeName, (route) => false);
                    },
                  ),
                );
              },
            );
          })
        ],
      ),
    );
  }

  ListTile listTile(
      BuildContext context, String text, IconData? icon, VoidCallback onTap) {
    return icon == null
        ? ListTile(
            title: Text(
              text,
              style: const TextStyle(
                color: MyColors.textColor,
                fontSize: 14,
              ),
            ),
            onTap: onTap,
          )
        : ListTile(
            title: Text(
              text,
              style: const TextStyle(
                color: MyColors.textColor,
                fontSize: 14,
              ),
            ),
            leading: Icon(
              icon,
              color: Color.fromARGB(255, 16, 2, 214),
            ),
            onTap: onTap,
          );
  }
}
