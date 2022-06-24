import 'package:flutter/material.dart';
import 'package:multi_store_app/customer_screen/customer_orders.dart';
import 'package:multi_store_app/customer_screen/wishlist.dart';
import 'package:multi_store_app/main_screen/cart.dart';
import 'package:multi_store_app/wigets/appbar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Container(
            height: 230,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 33, 212, 243), Colors.brown])),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.white,
                expandedHeight: 140,
                flexibleSpace: LayoutBuilder(builder: ((context, constraints) {
                  return FlexibleSpaceBar(
                    title: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: constraints.biggest.height <= 120 ? 1 : 0,
                      child: const Text(
                        'Account',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    background: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 33, 212, 243),
                        Colors.brown
                      ])),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 30),
                        child: Row(
                          children: [
                            const CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    (AssetImage('images/inapp/guest.jpg'))),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text(
                                'guest'.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30))),
                            child: TextButton(
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: Text(
                                    'Cart',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 33, 212, 243),
                                        fontSize: 24),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CartScreen(back: AppBarBackButton(),),
                                    ));
                              },
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 33, 212, 243),
                            ),
                            child: TextButton(
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: Text(
                                    'Orders',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 20),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CustomerOrders(),
                                    ));
                              },
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30))),
                            child: TextButton(
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: Text(
                                    'Wishlist',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 33, 212, 243),
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const WishlistsScreen(),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade300,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 150,
                            child: Image(
                              image: AssetImage('images/inapp/easywayLogo.png'),
                              color: Color.fromARGB(255, 66, 54, 54),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          const ProfileMidelLabel(
                              headerLabel: '  Account Info  '),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 260,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(children: const [
                                RepeatedListTile(
                                  icon: Icons.email,
                                  subTitle: 'example@gmail.com',
                                  title: 'Email Address',
                                ),
                                BlueDivider(),
                                RepeatedListTile(
                                  icon: Icons.phone,
                                  subTitle: '000000',
                                  title: 'Phone Number',
                                ),
                                BlueDivider(),
                                RepeatedListTile(
                                  icon: Icons.location_pin,
                                  subTitle: 'Madina Ghana',
                                  title: 'Address',
                                ),
                              ]),
                            ),
                          ),
                          const ProfileMidelLabel(
                              headerLabel: '  Account Settings  '),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 260,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(children: [
                                RepeatedListTile(
                                  title: 'Edit Profile',
                                  subTitle: '',
                                  icon: Icons.edit,
                                  onPressed: () {},
                                ),
                                const BlueDivider(),
                                RepeatedListTile(
                                  title: 'Change Password',
                                  icon: Icons.lock,
                                  onPressed: () {},
                                ),
                                const BlueDivider(),
                                RepeatedListTile(
                                  title: 'Log Out',
                                  subTitle: '',
                                  icon: Icons.logout,
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/welcom_screen');
                                  },
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class BlueDivider extends StatelessWidget {
  const BlueDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Color.fromARGB(255, 33, 212, 243),
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;
  const RepeatedListTile(
      {Key? key,
      required this.icon,
      this.subTitle = '',
      required this.title,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileMidelLabel extends StatelessWidget {
  final String headerLabel;
  const ProfileMidelLabel({Key? key, required this.headerLabel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(
          headerLabel,
          style: const TextStyle(
              color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ]),
    );
  }
}
