import 'package:kite_bird_responses/kite_bird_responses.dart';
import 'package:kite_bird_responses/models/model.dart';
import 'package:kite_bird_responses/models/settings.dart';

class AccountsController extends ResourceController{
  @Operation.get()
  Future<Response>  fetch()async{
    final Model accounts = Model(dbUrl: databaseUrl, collectionName: 'accounts');
    Map<String, dynamic> _res = {};
    final Map<String, dynamic> _dbRes = await accounts.find(where.sortBy('_id', descending: true).fields(['phoneNo', 'username', '_id']));
    if(_dbRes['status'] == 0){
      _dbRes['body'] = _dbRes['body'].map((item){
        final DateTime _date = ObjectId.parse(item['_id'].toJson().toString()).dateTime;
        item['datetimeCreated'] = _date.toString();

        return item;
      }).toList();
      _res = _dbRes;
    }
    return Response.ok(_res);
  }
}