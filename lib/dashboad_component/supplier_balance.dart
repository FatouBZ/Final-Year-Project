import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/wigets/appbar_widget.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
        .collection('orders')
        .where('sid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){ 
         
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child:   Center(child: CircularProgressIndicator(),));
        }
    

        double totalPrice = 0.0;
        for (var item in snapshot.data!.docs){
          totalPrice += item['orderqty'] * item['orderprice'];
        }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: 'Balance'),
        leading: const AppBarBackButton(),
      ),

      body: 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            
            StaticsModel(
              label:' Total Balance',
              value: totalPrice,
              decimal: 2,
            ),
            const SizedBox(height: 100,),
            Container(
      height: 45,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color:  Colors.pink,
          borderRadius: BorderRadius.circular(25)),
      child: MaterialButton(
        onPressed: (){},
        child: const Text('Get My Money !',
        style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    ),
    const SizedBox(height: 60,)
          ]),
      ),
    );
        });
  }
}
class StaticsModel extends StatelessWidget {
  final String label;
  final dynamic value;
  final int decimal;

  const StaticsModel({
    Key? key, required this.label, required this.value, required this.decimal
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Column(children: [
      Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.55,
        decoration: const BoxDecoration(color: Colors.blueGrey,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25)
      )
      ),
      child: Center(child: Text(label.toUpperCase(), 
      style: const TextStyle(color: Colors.white, fontSize: 20) ,))
      ,),
       Container(
        height: 90,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration:  BoxDecoration(color: Colors.blueGrey.shade100,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25)
      )
      ),
      child:  AnimationCounter(
        count: value,
        decimal: decimal,
        ),
      )
    ]);
  }
}

class AnimationCounter extends StatefulWidget {
  final int decimal;
  final dynamic count;
  const AnimationCounter({Key? key, required this.count, required this.decimal}) : super(key: key);

  @override
  State<AnimationCounter> createState() => _AnimationCounterState();
}

class _AnimationCounterState extends State<AnimationCounter> 
with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = 
    AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = _controller;
    setState(() {
      _animation = Tween(
        begin: _animation.value, end: widget.count).animate(_controller);
    });
    _controller.forward();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child){
        return Center(child: 
        Text( 
          _animation.value.toStringAsFixed(widget.decimal), 
      style:  const TextStyle(color: Colors.pink, 
      fontSize: 40,
      fontWeight: FontWeight.bold,
      letterSpacing: 2,
      fontFamily: 'Acme') ));
      },
    );
    
  }
}