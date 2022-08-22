import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

import 'bus_position_entity.dart';

List<BusPositionEntity> listBusPosition = [];

void main() async {
  final path = 'specs/swagger.yaml';
  final app = Router();
  app.get('/', _handle);
  app.post('/position', _handlePostPosition);
  app.get('/position', _handleGetPositions);
  app.get('/seed', _handleSeed);

  var server = await shelf_io.serve(app, 'localhost', 8080);

  final handler = SwaggerUI(path, title: 'Swagger Test');
  var swaggerServer = await shelf_io.serve(handler, '0.0.0.0', 4001);

  print('Serving at http://${server.address.host}:${server.port}');
}

Response _handle(Request request) {
  return Response(200, body: 'Request for "${request.url}"');
}

Future<Response> _handlePostPosition(Request request) async {
  var bodyContent = await request.readAsString();
  var bodyMap = jsonDecode(bodyContent);
  var newBusPosition = BusPositionEntity.fromMap(bodyMap);

  listBusPosition
      .removeWhere((element) => element.busId == newBusPosition.busId);

  listBusPosition.add(newBusPosition);

  print(listBusPosition.length);

  return Response(201, body: 'Created');
}

Response _handleGetPositions(Request request) {
  var listResponse = '';

  for (var i = 0; i < listBusPosition.length; i++) {
    if (listResponse == '') {
      listResponse = listBusPosition[i].toJson();
    } else {
      listResponse = '$listResponse, ${listBusPosition[i].toJson()}';
    }
  }

  return Response(200, body: '[$listResponse]');
}

Response _handleSeed(Request request) {
  listBusPosition.clear();

  listBusPosition.add(BusPositionEntity.fromMap({
    "busId": "Jaqueira",
    "busInfo": "Linha Jaqueira x Centro 203, Saída do Bairro: 12:00",
    "lat": -22.0966545,
    "lon": -43.1911826,
    "positionTime": 162321923847584
  }));
  listBusPosition.add(BusPositionEntity.fromMap({
    "busId": "Cantagalo",
    "busInfo": "Linha Cantagalo x Centro 203, Saída do Bairro: 12:00",
    "lat": -22.1226058,
    "lon": -43.2433598,
    "positionTime": 162321923847584
  }));
  listBusPosition.add(BusPositionEntity.fromMap({
    "busId": "Monte Castelo",
    "busInfo": "Linha Monte Castelo x Centro 203, Saída do Bairro: 12:00",
    "lat": -22.0797305,
    "lon": -43.223236,
    "positionTime": 162321923847584
  }));
  listBusPosition.add(BusPositionEntity.fromMap({
    "busId": "Ponte das Garças",
    "busInfo": "Linha Ponte das Garças x Centro 203, Saída do Bairro: 12:00",
    "lat": -22.0962901,
    "lon": -43.1839949,
    "positionTime": 162321923847584
  }));
  listBusPosition.add(BusPositionEntity.fromMap({
    "busId": "Pilões",
    "busInfo": "Linha Pilões x Centro 203, Saída do Bairro: 12:00",
    "lat": -22.1342056,
    "lon": -43.1780077,
    "positionTime": 162321923847584
  }));
  listBusPosition.add(BusPositionEntity.fromMap({
    "busId": "Mirante Sul",
    "busInfo": "Linha Mirante Sul x Centro 203, Saída do Bairro: 12:00",
    "lat": -22.1011678,
    "lon": -43.2195175,
    "positionTime": 162321923847584
  }));
  listBusPosition.add(BusPositionEntity.fromMap({
    "busId": "Morada do Sol",
    "busInfo": "Linha Morada do Sol x Centro 203, Saída do Bairro: 12:00",
    "lat": -22.1081359,
    "lon": -43.1843591,
    "positionTime": 162321923847584
  }));
  listBusPosition.add(BusPositionEntity.fromMap({
    "busId": "Palmital",
    "busInfo": "Linha Palmital x Centro 203, Saída do Bairro: 12:00",
    "lat": -22.1002431,
    "lon": -43.1924867,
    "positionTime": 162321923847584
  }));

  return Response(201, body: 'Created');
}
