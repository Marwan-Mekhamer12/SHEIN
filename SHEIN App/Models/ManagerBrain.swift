//
//  ManagerBrain.swift
//  SHEIN App
//
//  Created by Marwan Mekhamer on 15/05/2025.
//

import Foundation

struct ManagerBrain {
    
    func fetchRequest(_ Completion: @escaping (([Main]) -> Void)) {
        if let url = URL(string: "https://dummyjson.com/products") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print("fetch error: \(error!.localizedDescription)")
                    
                }
                
                if let safedata = data {
                    self.parseData(urlString: safedata, Completion: Completion)
                }
            }
            task.resume()
        }else {
            print("Invalid URL")
        }
    }
    
    func parseData(urlString: Data, Completion: @escaping (([Main]) -> Void)) {
        let JsonDecoder = JSONDecoder()
        do {
            let request = try JsonDecoder.decode(ManagerDetails.self, from: urlString)
            Completion(request.products)
            print(request.products[0].title)
        }
        catch {
            print("Decode error: \(error.localizedDescription)")
            if let dataString = String(data: urlString, encoding: .utf8) {
                    print("Raw JSON: \(dataString)")
                }
        }
    }
}
