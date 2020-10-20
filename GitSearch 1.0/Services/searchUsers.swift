//
//  searchUsers.swift
//  GitSearch 1.0
//
//  Created by Ravi Thakur on 18/10/20.
//

import Foundation
import UIKit

extension ViewController{
    
    func searchUserwith(name: String, page: Int) {
        
        guard let urls = URL(string: "https://api.github.com/search/users?q=\(name)&page=\(page)") else{
            return
        }
            
        print(urls)
        let request = URLRequest(url: urls)
        
        URLSession.shared.dataTask(with: request) { [self] (data, respon, error) in
            
            if error != nil{
                print(error?.localizedDescription as Any)
                return
            }
            
            guard let userdata = data else{
                return
            }
        
            do{
                //MARK: - method 1
//                let datastring = String(data: userdata, encoding: .utf8)
//                print(datastring as Any)
                //MARK: - method 2
//                let jsonData = try JSONSerialization.jsonObject(with: userdata, options: .mutableContainers)
//                print(jsonData)
                //MARK: - method 3
                
                let searchedData = try JSONDecoder().decode(SearchedResults.self, from: userdata)
            
                let RetrievedUsers = searchedData.items
                print(RetrievedUsers)
                
                saveduser.append(contentsOf: RetrievedUsers)
                //print(saveduser)
                
                
                
                
                
                self.totalFetched = searchedData.total_count
                
                //SearchUser.append(contentsOf: RetrievedUsers)

                
            }catch{
                DispatchQueue.main.async {
                    
                    if name != ""{
                        
                        self.searchlabel.text = "\(error.localizedDescription)"
                        
                    }
                    
                }
                
                print(error.localizedDescription)
                return
                
            }
        }.resume()
        
        
        
        
    }
    
}
