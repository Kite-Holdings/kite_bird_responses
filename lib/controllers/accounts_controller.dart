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


class MerchantAccountsController extends ResourceController{
  @Operation.get()
  Future<Response>  fetch()async{
    final Model accounts = Model(dbUrl: databaseUrl, collectionName: 'accounts');
    Map<String, dynamic> _res = {};
    final Map<String, dynamic> _dbRes = await accounts.find(where.eq("accountType", 'merchant').sortBy('_id', descending: true).excludeFields(['password']));
    if(_dbRes['status'] == 0){
      final List _bodyList = [];
      for(dynamic item in _dbRes['body']){
        final DateTime _date = ObjectId.parse(item['_id'].toJson().toString()).dateTime;
        item['datetimeCreated'] = _date.toString();

        // get merchant wallet
        final Model merchantAccounts = Model(dbUrl: databaseUrl, collectionName: 'merchantWallets');
        final Map<String, dynamic> _merchantAccRes = await merchantAccounts.findOneBy(where.eq('accountId', item['_id'].toJson()).excludeFields(['accountId']));
          item['merchantWalletId'] = _merchantAccRes['body']['_id'].toJson();
          item['shortCode'] = _merchantAccRes['body']['shortCode'];
          item['companyName'] = _merchantAccRes['body']['companyName'];
          item['merchantBalance'] = _merchantAccRes['body']['balance'];
        
        //get account wallet
        final Model _accountsWallet = Model(dbUrl: databaseUrl, collectionName: 'wallets');
        final Map<String, dynamic> _accWalletRes = await _accountsWallet.findOneBy(where.eq('ownerId', item['_id'].toJson()).excludeFields(['ownerId']));
        print(_accWalletRes);
        item['accountWalletId'] = _accWalletRes['body']['_id'];
        item['accountWalletNo'] = _accWalletRes['body']['walletNo'];
        item['accountWalletType'] = _accWalletRes['body']['walletType'];
        item['accountWalletBalance'] = _accWalletRes['body']['balance'];

        _bodyList.add(item);
      }
      _dbRes['body'] =  _bodyList;
      _res = _dbRes;
    }
    return Response.ok(_res);
  }
}

