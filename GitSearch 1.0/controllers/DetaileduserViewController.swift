//
//  DetaileduserViewController.swift
//  GitSearch 1.0
//
//  Created by Ravi Thakur on 18/10/20.
//

import UIKit

class DetaileduserViewController: UIViewController {
    

    //MARK: - decelerations
    
    var name = String()
    var Husername = String()
    var HuserUrl = String()
    var followerss : [Followers] = []
    
    //MARK: - connections
    
    @IBOutlet weak var userlocation: UILabel!
    @IBOutlet weak var userimage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var userBio: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    //MARK: - view methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchuserDetail(for: name)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchuserDetail(for: name)
        
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if Husername == ""{
            if HuserUrl == ""{
                
                print("no user found")
                
                return
            }
        }
        DispatchQueue.main.async {
            let userinfo = User(context: persistanceService.context)
            userinfo.avtarUrl = self.HuserUrl
            userinfo.name = self.Husername
            persistanceService.saveContext()
        }
       
    }
    
    
    
    
    
    //MARK: - search for user by name in api
    
    func searchuserDetail(for username: String){
        
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {
            return
        }
        
        let requestUrl = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            
            if error != nil{
                print(error?.localizedDescription as Any)
                return
            }
            
            guard let userdata = data else{
                return
            }
            
            do {
                
                let data = try JSONDecoder().decode(Userinfo.self, from: userdata)
                
                print(data)
                if data.name == ""{
                    self.username.text = username
                }else{
                    DispatchQueue.main.async {
                        self.username.text = data.name
                    }
                }
                
                //MARK: - save data through main thread
                
                DispatchQueue.main.async {
                    self.Husername = data.name
                    self.HuserUrl = data.avatar_url
                    self.userBio.text = data.bio
                    self.userlocation.text = data.location
                    self.userimage.downloaded(from: data.avatar_url)
                    
                }
                
                print(data.followers_url)
                // request for followers
                
                
                //MARK: - got user followers url now fetch users followers and display it in table view cell
                
                let furl = data.followers_url
                guard let FollowrsUrl = URL(string: furl) else {
                    return
                }
                let requestdUrl = URLRequest(url: FollowrsUrl)
                
                URLSession.shared.dataTask(with: requestdUrl) { (data, response, error) in
                    if error != nil{
                        return
                    }
                    guard let followersData = data else{
                        return
                    }
                    do{
                        let data = try JSONDecoder().decode([Followers].self, from: followersData)
                        
                        self.followerss.append(contentsOf: data)
                        
                        DispatchQueue.main.async {
                            self.tableview.reloadData()
                        }
                        
                    }catch{
                        
                    }
                    
                    
                }.resume()
                
                
                
                
                
            }catch{
                
            }
            
        }.resume()
        
        
        
        
        
    }
    
    
    
    
    @IBAction func dismissview(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

//MARK: - tableview extensions

extension DetaileduserViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followerss.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "userinfo", for: indexPath) as! DetailedTableViewCell
        //let names = followerss[indexPath.row].login
        cell.name.text = followerss[indexPath.row].login
        let imageurl = followerss[indexPath.row].avatar_url
        print("here we are")
        print(imageurl)
        cell.Fimage.downloaded(from: imageurl)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
