//
//  NetworkingService.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


struct NetworkingService {
    
    
    static func fetchJSONData (endPoint: EndPoint, completion : @escaping (APIResult<Any>) -> Void ) {
        
        Alamofire.request(endPoint.request).responseJSON { (response) in
            
            
            switch response.result {
            case .failure(let error) : completion(.failure(error))
            case .success(let value) :
                let json = JSON(value)
                completion(.success(json))
            }
        }
    }
    
    
    
    static func fetchData(url: URL, completion: @escaping (APIResult<Data>) -> Void) {
        // this function will be used to download image data from the server
        
        let request = URLRequest(url:url)
        
        // to remove cached image
        URLCache.shared.removeCachedResponse(for: request)
        
        
        Alamofire.request(request).responseData { (response) in
            
            if response.error != nil {
                print(response.error!)
                completion(.failure(response.error!))
            }
            
            guard let data = response.data else {return}
            
            completion(.success(data))
        }
        
    }
    
    
    
    
    static func uploadImage (parameters: [String:Any], image: UIImage, endPoint: EndPoint, completion : @escaping (APIResult<Any>) -> Void ) {
        
        let urlString = "\(endPoint.baseURL)\(endPoint.path)"
        let imgData = UIImageJPEGRepresentation(image, 0.7)!
        let url = try! URLRequest(url: URL(string: urlString)!, method: .post, headers: nil)
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "file", fileName: "avatar.jpeg", mimeType: "image/jpeg")
                
                for (key, value) in parameters {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        },
            with: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if((response.result.value) != nil) {
                            guard let json = response.result.value as? [String:Any] else {return}
                            
                            guard let id = json["id"] as? String,
                                let username = json["username"] as? String,
                                let fullname = json["fullname"] as? String,
                                let email = json["email"] as? String,
                                let avatar = json["avatar"] as? String else {
                                    return
                            }
                            
                            
                            let userData : [String : Any] = [
                                "userID" : id,
                                "username" : username,
                                "email" : email,
                                "avatar" : avatar,
                                "fullname" : fullname
                            ]
                            completion(.success(userData))
                            
                            
                        } else {
                            
                        }
                    }
                case .failure(let encodingError):
                    completion(.failure(encodingError))
                    print(encodingError)
                    break
                }
        }
        )
        
        
    }
    
    
    
    
}

