//
//  NetworkingService.swift
//  HRIS
//
//  Created by Muchammad Agung Laksana on 2/1/18.
//  Copyright © 2018 Muchammad Agung Laksana. All rights reserved.
//

import UIKit
import Alamofire


struct NetworkingService {
    
     // this struct job is to get JSON data / raw data from the given endpoint.
    
    static func fetchJSONData (endPoint: EndPoint, completion : @escaping (APIResult<Any>) -> Void ) {
        
        Alamofire.request(endPoint.request).responseJSON { (response) in
            
            guard let JSON = response.result.value as? [String:Any]  else {
                if let error = response.result.error {
                    completion(.failure(error))
                }
                return
            }
            
            guard let postJSON = JSON["posts"] as? [[String:Any]] else {
                print("the user has no post")
                return
                
            }
            
            completion(.success(postJSON))
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
    
    
    static func uploadImage (image: UIImage, endPoint: EndPoint, completion : @escaping (APIResult<Any>) -> Void ) {
        
        let urlString = "\(endPoint.baseURL)\(endPoint.path)"
        let imgData = UIImageJPEGRepresentation(image, 0.7)!
        let url = try! URLRequest(url: URL(string: urlString)!, method: .post, headers: nil)
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "file", fileName: "avatar.jpeg", mimeType: "image/jpeg")
                
                for (key, value) in endPoint.parameters {
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

