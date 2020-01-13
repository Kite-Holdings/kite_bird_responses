import 'package:kite_bird_responses/controllers/accounts_controller.dart';
import 'package:kite_bird_responses/controllers/error_responses.dart';
import 'package:kite_bird_responses/controllers/logins_controller.dart';
import 'package:kite_bird_responses/controllers/requested_opts_controller.dart';
import 'package:kite_bird_responses/controllers/requests_controller.dart';
import 'package:kite_bird_responses/controllers/responses_controller.dart';
import 'package:kite_bird_responses/controllers/transactions_controller.dart';

import 'kite_bird_responses.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class KiteBirdResponsesChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router
      .route("/example")
      .linkFunction((request) async {
        return Response.ok({"key": "value"});
      });
    router
      .route("/requestedOtps")
      .link(()=> RequestedOtpsController());
    router
      .route("/accounts")
      .link(()=> AccountsController());
    router
      .route("/merchantAccounts")
      .link(()=> MerchantAccountsController());
    
    router
      .route("/logins")
      .link(()=> LoginsController());
    router
      .route("/errorResponses")
      .link(()=> ErrorResponsesController());
    router
      .route("/responses")
      .link(()=> ResponsesController());
    router
      .route("/requests")
      .link(()=> RequestController());
    router
      .route("/cardTransactions")
      .link(()=> CardController());
    router
      .route("/mpesaTransactions")
      .link(()=> MpesaController());
    router
      .route("/walletTransactions")
      .link(()=> WalletController());
    

    return router;
  }
}