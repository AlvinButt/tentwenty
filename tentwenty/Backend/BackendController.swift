//
//  BackendController.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 09/08/2022.
//

import Alamofire
import UIKit

var API: BackendController {
    return BackendController.sharedConrtoller()
}

class BackendController {
    
    //Singelton instance
    static fileprivate let _backendController = BackendController()
    class func sharedConrtoller() -> BackendController {
        return _backendController
    }
    
    fileprivate let baseURL = "https://api.themoviedb.org/3"
    fileprivate let api_key = "5afc1db152699f2edc4cbe337b473d1f"
//    let imageBaseURL = "https://image.tmdb.org/t/p/w500/"

    init() {
        //init called
        print("init called ....")
        AF.sessionConfiguration.timeoutIntervalForRequest = 60
    }

    
    fileprivate func setRequestHeader(_ token: String) -> HTTPHeaders{
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        return headers
    }
    
    // This function only returns the response in silent. Only Network error would be notified
    private func getSilentResponse(_ response: DataResponse<Any, AFError>) -> (Bool, JSON) {
        if let _ = response.error {
            invalidResponse(response)
            return (false, JSON.null)
        }
        if let obj = response.value {
            let json = JSON(obj)
            let result = true
            return (result, json)
        }
        return (false, JSON.null)
    }
    
    private func invalidResponse(_ response: DataResponse<Any, AFError>) {
        if let error = response.error as NSError?, error.code == -1009 {
            showAlertWithAPICode(code: 0) //NETWORK FAILURE
        } else if let error = response.error as NSError?, error.code == -1001 {
            showAlertWithAPICode(code: 1001) // REQUEST TIME OUT
        } else {
            showAlertWithAPICode(code: 100) //INVALID SESSION RESPONSE
        }
    }
    
    func showAlertWithAPICode(code: Int) {
        showErrorMessage(code)
    }
    
    func showErrorMessage(_ code: Int) {
        let alert = UIAlertController(title: "Error", message: "This Server Error", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Remind Me Tomorrow", style: UIAlertAction.Style.default, handler: nil))
        alert.show()
        if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
            rootVC.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func serverCallWithUrl(apiUrl: String, token:String, method: HTTPMethod, params: [String: Any]?, encodingUrl: ParameterEncoding ,completion: @escaping (Bool, JSON) -> ()) {
        
        
        AF.request(apiUrl, method: method, parameters: params, encoding: encodingUrl, headers: setRequestHeader(token))
            .responseJSON { response in
                
                if let code = response.response?.statusCode {
                    if code == 200 {
                        let (result, json) = self.getSilentResponse(response)
                        completion(result, json)
                    }else{
                        completion(false, "status code error")
                    }
                }
            }
        
    }
    
    func getGenerList(completion: @escaping (Bool, JSON) -> ()) {
        
        serverCallWithUrl(apiUrl: "\(baseURL)/genre/movie/list?api_key=\(api_key)&language=en-US",
                          token: "",
                          method: .get,
                          params: nil,
                          encodingUrl:  JSONEncoding.default,
                          completion: completion)
    }
    
    func getUpCommingMovies(completion: @escaping (Bool, JSON) -> ()) {
        
        serverCallWithUrl(apiUrl: "\(baseURL)/movie/upcoming?api_key=\(api_key)&language=en-US",
                          token: "",
                          method: .get,
                          params: nil,
                          encodingUrl:  JSONEncoding.default,
                          completion: completion)
    }
    
    func getMovieInfo(id:Int,
                      completion: @escaping (Bool, JSON) -> ()) {
        
        serverCallWithUrl(apiUrl: "\(baseURL)/movie/\(id)?api_key=\(api_key)",
                          token: "",
                          method: .get,
                          params: nil,
                          encodingUrl:  JSONEncoding.default,
                          completion: completion)
    }
    
   
}
