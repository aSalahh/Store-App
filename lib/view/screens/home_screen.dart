import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store/blocs/internet_bloc/internet_bloc.dart';
import 'package:store/blocs/internet_bloc/internet_state.dart';
import 'package:store/blocs/product_bloc/product_bloc.dart';

import '../../blocs/product_bloc/product_state.dart';
import '../../models/product_model.dart';
import '../widgets/custom_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = 'HomePAge';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.cartPlus,
                color: Colors.black,
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'New Trend',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 65),
          child: BlocListener<InternetBloc, InternetState>(
            listener: (context, state) {
              if (state is Connected) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.msg)));
              } else if (state is NotConnected) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.msg)));
              }
            },
            child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductLoadingState) {
                  return const CircularProgressIndicator();
                } else if (state is ProductLoadedState) {
                  List<ProductModel> products = state.products;
                  return GridView.builder(
                      itemCount: products.length,
                      clipBehavior: Clip.none,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 100,
                      ),
                      itemBuilder: (context, index) {
                        return CustomCard(product: products[index]);
                      });
                } else if (state is ProductsFailure) {
                  return Text(state.errorMessage);
                } else {
                  return Container();
                }
              },
            ),
          )),
    );
  }
}
