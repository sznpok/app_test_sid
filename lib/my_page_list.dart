import 'package:app_test_sid/bloc/get_data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';

class MyPageList extends StatefulWidget {
  const MyPageList({super.key});

  @override
  State<MyPageList> createState() => _MyPageListState();
}

class _MyPageListState extends State<MyPageList> {
  @override
  void initState() {
    BlocProvider.of<GetDataBloc>(context).add(FetchDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My List"),
      ),
      body: BlocBuilder<GetDataBloc, GetDataState>(
        builder: (context, state) {
          if (state is GetDataLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetDataSuccessState) {
            final ads = state.adResponse!.data.ads;
            return ListView(
              children: [
                if (ads.containsKey('FIRST_ROW'))
                  ...ads['FIRST_ROW']!.map((ad) => AdTile(ad: ad)).toList(),
                Divider(),
                if (ads.containsKey('SECOND_ROW'))
                  ...ads['SECOND_ROW']!.map((ad) => AdTile(ad: ad)).toList(),
                Divider(),
                if (ads.containsKey('THIRD_ROW'))
                  ...ads['THIRD_ROW']!.map((ad) => AdTile(ad: ad)).toList(),
              ],
            );
          } else if (state is GetDataErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

class AdTile extends StatelessWidget {
  final Ad ad;

  AdTile({required this.ad});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(ad.title.toUpperCase()),
      subtitle: Text(
        ad.redirectUrl,
        style: TextStyle(color: Colors.blueGrey),
      ),
      trailing: ad.images != null && ad.images!.isNotEmpty
          ? SizedBox(
              width: 100, // Adjust width based on the number of images
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: ad.images!.map((image) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(
                        'https://site.webcreationcanada.com/ds/public/$image',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 50,
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          : null,
    );
  }
}
