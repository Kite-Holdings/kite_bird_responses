import 'package:kite_bird_responses/kite_bird_responses.dart';
import 'package:kite_bird_responses/models/model.dart';
import 'package:kite_bird_responses/models/settings.dart';

class CardController extends ResourceController{
  @Operation.get()
  Future<Response>  fetch()async{
    final Model transactions = Model(dbUrl: databaseUrl, collectionName: 'transactions');
    final Map<String, dynamic> _dbRes = await transactions.find(where
    .eq('transactionType', 'cardToWallet')
    .sortBy('_id', descending: true)
    );
    return Response.ok(_dbRes);
  }
}

class MpesaController extends ResourceController{
  @Operation.get()
  Future<Response>  fetch()async{
    final Model transactions = Model(dbUrl: databaseUrl, collectionName: 'transactions');
    final Map<String, dynamic> _dbRes = await transactions.find(where
    .eq('transactionType', 'mpesaCb')
    .sortBy('_id', descending: true)
    );
    return Response.ok(_dbRes);
  }
}

class WalletController extends ResourceController{
  @Operation.get()
  Future<Response>  fetch()async{
    final Model transactions = Model(dbUrl: databaseUrl, collectionName: 'transactions');
    final Map<String, dynamic> _dbRes = await transactions.find(where
    .eq('transactionType', 'walletTowallet')
    .sortBy('_id', descending: true)
    );
    return Response.ok(_dbRes);
  }
}

