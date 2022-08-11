import 'package:flutter/material.dart';
import 'package:multi_store_app/wigets/appbar_widget.dart';
import 'package:provider/provider.dart';
import '../models/wishlist_model.dart';
import '../provider/wishlist_provider.dart';
import '../wigets/alert_dialog.dart';

class WishlistScreen extends StatefulWidget {

  const WishlistScreen({Key? key,}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: const AppBarBackButton(),
              title: const AppBarTitle(title: 'wishlist'),
             actions: [

                context.watch<Wish>().getWishItems.isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      MyAlertDialog.showMyDialog(
                        context: context, 
                        title: 'Clear Whishlist', 
                        content: 'Are you sure to clear Wishlist?', 
                        tabNo: (){
                          Navigator.pop(context);
                        }, 
                        tabYes: (){
                          context.read<Wish>().clearWishlist();
                          Navigator.pop(context);
                        }
                      );
                      
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                       color: Colors.black,
                    ))
              ]
              ),
          body: context.watch<Wish>().getWishItems.isNotEmpty
          ?const WishItems()
           :const EmptyWishlist(),
        ),
      ),
    );
  }
}

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
       child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
     children: const[
        Text(
         'Your Wishlist Is Empty !',
         style: TextStyle(fontSize: 30),
       ),
       
     ],
          ));
  }
}

class WishItems extends StatelessWidget {
  const WishItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(
      builder: (context, cart, child){
      return ListView.builder(
        itemCount: cart.count,
        itemBuilder: (context, index){
          final product = cart.getWishItems[index];
        return WishlistModel(product: product);

      });
    },
    );
  }
}
 