import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/blocs/internet_bloc/internet_bloc.dart';
import 'package:store/blocs/product_bloc/product_bloc.dart';
import 'package:store/blocs/product_bloc/product_event.dart';
import 'package:store/services/repositories/product_repo.dart';
import 'package:store/view/screens/home_screen.dart';


void main() {
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider<ProductRepo>(
        create: (context) => ProductRepo(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ProductsBloc>(
              create: (context) => ProductsBloc(context.read<ProductRepo>())
                ..add(LoadProductEvent()),
            ),
            BlocProvider<InternetBloc>(
              create: (context) => InternetBloc(),
            ),
          ], child:HomePage() ,

        )
      ),
    );
  }
}
