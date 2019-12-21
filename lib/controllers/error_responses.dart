import 'package:kite_bird_responses/kite_bird_responses.dart';
import 'package:kite_bird_responses/models/model.dart';
import 'package:kite_bird_responses/models/settings.dart';

class ErrorResponsesController extends ResourceController{
  @Operation.get()
  Future<Response>  fetch()async{
    final Model responses = Model(dbUrl: databaseUrl, collectionName: 'responses');
    final Map<String, dynamic> _dbRes = await responses.find(where
    .ne('status.statusCode', 0).and(where.ne('status.statusCode', 1))
    .sortBy('_id', descending: true)
    .limit(60)
    // .fields(['phoneNo', 'username', '_id'])
    );

    return Response.ok(_dbRes);
  }
}