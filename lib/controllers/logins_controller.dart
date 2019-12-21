import 'package:kite_bird_responses/kite_bird_responses.dart';
import 'package:kite_bird_responses/models/model.dart';
import 'package:kite_bird_responses/models/settings.dart';

class LoginsController extends ResourceController{
  @Operation.get()
  Future<Response>  fetch()async{
    final Model tokens = Model(dbUrl: databaseUrl, collectionName: 'tokens');
    final Model accounts = Model(dbUrl: databaseUrl, collectionName: 'accounts');
    Map<String, dynamic> _res = {};
    final Map<String, dynamic> _dbRes = await tokens.find(
      where
      .eq('collection', 'accounts')
      .sortBy('_id', descending: true)
      .fields([ 'ownerId', '_id'])
      );
    if(_dbRes['status'] == 0){
      int i = 0;
      _dbRes['body'] = _dbRes['body'].map((item){
        final DateTime _date = ObjectId.parse(item['_id'].toJson().toString()).dateTime;
        item['datetimeCreated'] = _date.toString();


        return item;
      }).toList();
      

      for(i =0; i< int.parse(_dbRes['body'].length.toString()); i++){
        await accounts.findOneBy(where
        .eq('_id', ObjectId.parse(_dbRes['body'][i]['ownerId'].toString()))
        .sortBy('_id', descending: true)
        .fields(['phoneNo', 'username']).excludeFields(['_id'])
        ).then((value){
          _dbRes['body'][i]['owner'] = value['body'];
        });

      }
      
    }
    _res = _dbRes;

    return Response.ok(_res);
  }
}