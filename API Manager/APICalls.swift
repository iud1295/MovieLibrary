
import Foundation

class APICalls {

    let manager = APIManager.init()

    func getConfigurations(completion: @escaping (_ result: ConfigModel?) -> ()) {

        manager.getAPICall(url: APIDomain.Configuration, parameters: PostParameters().getConfigParams(), authRequired: false, userToken: "") { (result, error) in
            if error != nil {
                print(error ?? "")
                completion(nil)
            } else {
                print(result as! NSDictionary)
                let response = ConfigModel.init(dictionary: result as! NSDictionary)
                completion(response)
            }
        }
    }

    func getMovieList(completion: @escaping (_ result: MovieListModel?) -> ())  {

        manager.getAPICall(url: APIDomain.PopularMovies, parameters: PostParameters().getPopularMovieListParams(), authRequired: false, userToken: "") { (result, error) in
            if error != nil {
                print(error ?? "")
                completion(nil)
            } else {
                print(result as! NSDictionary)

                let response = MovieListModel.init(dictionary: result as! NSDictionary)
                completion(response)
            }
        }
    }

//    func getMyBookings(id: Int?, completion: @escaping (_ result: Any?) -> ())  {
//
//        var url = APIDomain.MyBookings
//        if let userBookingID = id {
//            url = url + "/\(userBookingID)"
//        }
//
//        manager.getAPICall(url: url, parameters: nil, authRequired: true, userToken: userToken) { (result, error) in
//            if error != nil {
//                print(error ?? "")
//                completion(nil)
//            } else {
//                print(result as! NSDictionary)
//
//                completion((id == nil) ? (MyBookingsModel.init(dictionary: result as! NSDictionary)) : (ConfirmBookingModel.init(dictionary: result as! NSDictionary)))
//            }
//        }
//    }

//    func getWalletBalance(completion: @escaping (_ result: WalletBalanceModel?) -> ())  {
//
//        manager.getAPICall(url: APIDomain.GetWallet, parameters: nil, authRequired: true, userToken: userToken) { (result, error) in
//            if error != nil {
//                print(error ?? "")
//                completion(nil)
//            } else {
//                print(result as! NSDictionary)
//
//                let response = WalletBalanceModel.init(dictionary: result as! NSDictionary)
//                completion(response)
//            }
//        }
//    }

//    func getTransactionHistory(limit: Int, completion: @escaping (_ result: TransactionHistoryModel?) -> ())  {
//
//        manager.getAPICall(url: APIDomain.TransactionHistory, parameters: PostParameters().getTransactionHistoryParameters(limit: limit), authRequired: true, userToken: userToken) { (result, error) in
//            if error != nil {
//                print(error ?? "")
//                completion(nil)
//            } else {
//                print(result as! NSDictionary)
//
//                let response = TransactionHistoryModel.init(dictionary: result as! NSDictionary)
//                completion(response)
//            }
//        }
//    }

//    func bookTickets(eventID: Int, totalAmount: String, date: String, daytime: String, ticketType: [NSDictionary], completion : @escaping (_ result : BookTicketsModel?) -> ()) {
//
//
//        manager.postAPICall(url: APIDomain.BookTickets,
//                            parameters: PostParameters().getBookTicketsParameters(eventID: eventID,
//                                                                                  totalAmount: totalAmount,
//                                                                                  date: date,
//                                                                                  daytime: daytime,
//                                                                                  ticketType: ticketType),
//                            authRequired: true,
//                            userToken: userToken)
//        { (result, error) in
//            if error != nil {
//                print(error ?? "")
//                completion(nil)
//            } else {
//                print(result as! NSDictionary)
//                let response = BookTicketsModel.init(dictionary: result as! NSDictionary)
//                completion(response)
//            }
//        }
//    }

//    func confirmBooking(userBookingID: Int, cashbackAmount: Int, walletAmount: Int, completion : @escaping (_ result : ConfirmBookingModel?) -> ()) {
//
//
//        manager.postAPICall(url: APIDomain.ConfirmBooking,
//                            parameters: PostParameters().getConfirmBookingParameters(userBookingID: userBookingID,
//                                                                                     cashbackAmount: cashbackAmount,
//                                                                                     walletAmount: walletAmount),
//                            authRequired: true,
//                            userToken: userToken)
//        { (result, error) in
//            if error != nil {
//                print(error ?? "")
//                completion(nil)
//            } else {
//                print(result as! NSDictionary)
//                let response = ConfirmBookingModel.init(dictionary: result as! NSDictionary)
//                completion(response)
//            }
//        }
//    }

}
