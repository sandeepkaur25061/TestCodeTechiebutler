//
//  NetworkManager.swift
//  TechiebutlerTest
//
//  Created by sandeep kaur on 02/05/24.
//

import Foundation
class NetworkManager {
     
    static var shared = NetworkManager()
    
    private init() {
        
    }
    
    func getApiCall<T: Decodable>(page:Int, limit:Int,callBack: @escaping (T, Int) -> Void) {
        
        if !NetworkConnectionManager.isConnectedToNetwork() {
         let error = NSError(domain: "No Internet Connection", code: 2515, userInfo: [NSLocalizedDescriptionKey: "Make sure your device is connected to the internet."])
            Alert.show(title: error.domain, message: error.localizedDescription)
            return
        }
        let apiUrl = "https://jsonplaceholder.typicode.com/posts?_page=\(page)&_limit=\(limit)"
        if let url = URL(string:apiUrl ) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let header:[String:String] = ["Content-Type": "application/json"]
            request.allHTTPHeaderFields = header
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    var statusCodde : Int = 0
                    if let httpResponse = response as? HTTPURLResponse {
                        statusCodde = httpResponse.statusCode
                    }

                    if self.isReponseSuccess(urlResponse: response, error: error) {
                        
                        if let err = error {
                            Alert.show(message: err.localizedDescription)
                        } else {
                            if let datum = data {
                                do {
                                    
                                    let obj = try JSONDecoder().decode(T.self, from: datum)
                                    callBack(obj, statusCodde)
                                } catch let jsonErr {
                                    Alert.show(message: jsonErr.localizedDescription)
                                }
                            } else {
                                    Alert.show(message: "No data found")
                               
                            }
                        }
                    }
                    
                }
            }.resume()
            
        } else {
            Alert.show(message: "Invalid URL")
        }
    }
    
      func isReponseSuccess(urlResponse: URLResponse?, error:Error?) -> Bool {
        if let resp = urlResponse {
            let httpResponse = resp as? HTTPURLResponse
            let statusCode =   httpResponse?.statusCode ?? 0
            
            if statusCode == 200 || statusCode == 201 || statusCode == 400 {
                return true
            } else if statusCode == 401 {
                Alert.show(message: "Session Expired")
                return false
            } else {
                Alert.show(message:"Error: Status Code \(statusCode)")
                return false
            }
        } else {
            if let err = error {
                Alert.show(message:err.localizedDescription)
                return false
            } else {
               return false
            }
        }
    }
    
    
    
}
