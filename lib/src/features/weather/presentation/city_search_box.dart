import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:provider/provider.dart';

import '../data/api_exception.dart';
import 'message_dialog.dart';

class CitySearchBox extends StatefulWidget {
  const CitySearchBox({super.key});

  @override
  State<CitySearchBox> createState() => _CitySearchRowState();
}

class _CitySearchRowState extends State<CitySearchBox> {

  late final _searchController = TextEditingController();
  final GlobalKey<FormState> _weatherFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _searchController.text = context.read<WeatherProvider>().city;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _weatherFormKey,
      autovalidateMode: AutovalidateMode.always,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: _searchController,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: "City name",
            hintStyle: Theme.of(context).textTheme.displayMedium,
            labelStyle: Theme.of(context).textTheme.displayMedium,
            errorStyle: TextStyle(
                fontSize: Theme.of(context).textTheme.displayMedium?.fontSize,
                fontWeight: FontWeight.bold
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.search_outlined,
                color: Theme.of(context).primaryColor,
              ),

              onPressed: () async {
                if (_weatherFormKey.currentState!.validate()) {
                  try {
                    MessageDialog.showLoadingDialog(context, "Searching for weather");
                    await Future.delayed(const Duration(seconds: 2));

                   if(context.mounted)
                   {
                     final weatherProvider = context.read<WeatherProvider>();
                     weatherProvider.city = _searchController.text;

                     await weatherProvider.getWeatherData();
                     if(context.mounted)
                     {
                       Navigator.pop(context);
                     }
                   }
                  } catch (e) {
                    final errorMessage = getErrorMessage(e);
                    if(context.mounted)
                    {
                      Navigator.pop(context);
                      MessageDialog.showErrorMessage(context, "Oops! Something went wrong!", errorMessage);
                    }
                  }
                }
              },
            ),
          ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Required";
              }
              return null;
            }
        ),
      ),
    );
  }
}
