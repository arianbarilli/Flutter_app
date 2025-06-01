import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/repository.dart';
import 'package:flutter_application_1/data/services/api/api_client.dart';
import 'package:flutter_application_1/router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting("pt_BR").then(
    (value) => runApp(
      MultiProvider(
        providers: [
          Provider(create: (context) => APIClient()),
          Provider(create: (context) => Repository(client: context.read())),
        ],
        child: MaterialApp.router(routerConfig: router()),
      ),
    ),
  );
}
