//
//  GigController.swift
//  Gigs
//
//  Created by FGT MAC on 2/6/20.
//  Copyright © 2020 FGT MAC. All rights reserved.
//

//API DOCS:
//https://github.com/LambdaSchool/ios-gigs/blob/master/APIDocumentation.md
//


enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case get = "GET"
    
}

enum NetworkError: Error {
    case noAuth
    case badAuth
    case otherError
    case badData
    case noDecode
}


import Foundation

class GigController {
    
    //Use to save the token
    var bearer: Bearer?
    
    //1.Base URL
    var baseURL = URL(string: "https://lambdagigs.vapor.cloud/api")
    
    //MARK: - Sign up method
    func signUp(for user: User, completion: @escaping (Error?)-> Void){
        
        // A)Constructing URL \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        guard let baseURL = baseURL else {return}
        
        //2.This is the end point to sign up which we append it to the end of the base URL
        let signUpURL = baseURL.appendingPathComponent("/users/signup")
        
        //3.Starting the request
        var request = URLRequest(url: signUpURL)
        
        //4.Type of request
        request.httpMethod = HTTPMethod.post.rawValue
        
        //5.Set the headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        // B)Encoding data  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        
        //1.Create instance of JSONEncoder which is use to encode from swift class of user to json
        let jsonEncoder = JSONEncoder()
        
        do{
            //2. try to encode the user which is an instace of User struct into json format
            let jsonData = try jsonEncoder.encode(user)
            
            //3.Pass the encoded data which includes the username and password to the request body
            request.httpBody = jsonData
        }catch{
            
            //4. Handle errors
            print("Error encoding user: \(error)")
            //pass the error to the completion closure
            completion(error)
            //return to terminate the process since there is likely an issue at this point
            return
        }
        
        
        // C)Start the session request \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            
            //1.Unwrap values to handle potential errors, basically if the response is not 200 there is an issue
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            //2.Unwrap error and pass it to the completion closure if exist
            if let error = error {
                completion(error)
                return
            }
            
            //3.Finally if there is no error to this point we simply pass nil to the completion closure
            completion(nil)
            
        //4.Resume to start the request
        }.resume()
        
    }
    
    
    //MARK: - Sign in method
    func signIn(for user: User, completion: @escaping (Error?)-> Void){
        // A)Constructing URL \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        guard let baseURL = baseURL else {return}
        
        //2.This is the end point to sign up which we append it to the end of the base URL
        let signInURL = baseURL.appendingPathComponent("/users/login")
        
        //3.Starting the request
        var request = URLRequest(url: signInURL)
        
        //4.Type of request
        request.httpMethod = HTTPMethod.post.rawValue
        
        //5.Set the headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        // B)Encoding data  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        
        //1.Create instance of JSONEncoder which is use to encode from swift class of user to json
        let jsonEncoder = JSONEncoder()
        
        do{
            //2. try to encode the user which is an instace of User struct into json format
            let jsonData = try jsonEncoder.encode(user)
            
            //3.Pass the encoded data which includes the username and password to the request body
            request.httpBody = jsonData
        }catch{
            
            //4. Handle errors
            print("Error encoding user: \(error)")
            //pass the error to the completion closure
            completion(error)
            //return to terminate the process since there is likely an issue at this point
            return
        }

        // C)Start the session request \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            //1.Unwrap values to handle potential errors, basically if the response is not 200 there is an issue
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            //2.Unwrap error and pass it to the completion closure if exist
            if let error = error {
                completion(error)
                return
            }
            
            
            //3.unwarp data
            guard let data = data else {
                completion(NSError())
                return
            }
            
            //4.Start an instance of JSONDecoder to decode the json token into our Bearer sift struct
            let dataDecoder = JSONDecoder()
            
            do{
                 self.bearer = try dataDecoder.decode(Bearer.self, from: data)
            }catch{
                print("Error while decoding json: \(error)")
                completion(error)
                return
            }
            
            
            //3.Finally if there is no error to this point we simply pass nil to the completion closure
            completion(nil)
            
            //4.Resume to start the request
        }.resume()
    }
    
    //Get all Gigs
    func getAllGigs(completion: @escaping (Result<[Gig], NetworkError>) -> Void) {
        
        guard let bearer = bearer else {
            completion(.failure(.noAuth))
            return
        }
        
        
        
    }
    
}
