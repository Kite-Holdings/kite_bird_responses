import 'package:kite_bird_responses/kite_bird_responses.dart';
import 'package:kite_bird_responses/models/model.dart';
import 'package:kite_bird_responses/models/settings.dart';

class ResponsesController extends ResourceController{
  @Operation.get()
  Future<Response>  fetch()async{
    final Model responses = Model(dbUrl: databaseUrl, collectionName: 'responses');
    final Map<String, dynamic> _dbRes = await responses.find(where
    .sortBy('_id', descending: true)
    .limit(40)
    );
    return Response.ok(_dbRes);
  }
}