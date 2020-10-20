//
//  ViewController.swift
//  GitSearch 1.0
//
//  Created by Ravi Thakur on 18/10/20.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
    
    
    @IBOutlet weak var searchlabel: UILabel!
    
    //MARK: - decleartions
    
    var searchedUsersList = [Users]()
    var totalSearchedresults = 1
    var saveduser : [Users] = []
    var SearchUser : [Users] = []
    var Results : [Users] = []
    var limit = 20
    var totalFetched = Int()

    
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Search"
        tableview.delegate = self
        tableview.dataSource = self
        searchuser(controller: searchcontrolelr)

        searchlabel.text = "Write the name of user you want to search"
        // Do any additional setup after loading the view.
        //searchUserwith(name: "Dom", page: 1)
        
    
    }

    //MARK: - searchController
    
    func searchuser(controller: UISearchController){
        controller.searchResultsUpdater = self
        controller.searchBar.placeholder = "Search people"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = controller
        definesPresentationContext = true
        controller.obscuresBackgroundDuringPresentation = false
    }

    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == nil || searchController.searchBar.text!.isEmpty{
            SearchUser = []
            searchlabel.text = "Write the name of user you want to search"
            view.endEditing(true)

        }
        //else{
//            SearchUser = []
//
//            let searchFor = searchController.searchBar.text!
//
//            searchUserwith(name: searchFor, page: 1)
//
//
//            filterUser(name: searchController.searchBar.text!)
//
//            DispatchQueue.main.async {
//
//                self.tableview.reloadData()
//            }
//
//        }
        
        SearchUser = []

        let searchFor = searchController.searchBar.text!

        searchUserwith(name: searchFor, page: 1)
        print("here it is")
        
        //print(saveduser)
        
        if searchController.isActive{
            
        filterUser(name: searchController.searchBar.text!)
            
            self.tableview.reloadData()
            
        }
    
    
    }
    
    
    func filterUser(name: String){
        
        searchlabel.text = "Searching For \(name)"
        
        SearchUser = self.saveduser.filter{
            return $0.login.range(of: name) != nil
        }
        //print(SearchUser)
        
        DispatchQueue.main.async {
            
            self.Results = self.saveduser.filter{
                return $0.login.range(of: name) != nil
            }
            
            self.tableview.reloadData()
        }
        

     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueVc = segue.destination as? DetaileduserViewController , let userinfo = sender as? String{
            segueVc.name = userinfo
            
        }
    }
    
    
    @IBAction func refreshdata(_ sender: Any) {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return Results.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if Results.count >= 0{
            
        }
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! SearchedUserCell
        let name = Results[indexPath.row].login
        let imagUrl = Results[indexPath.row].avatar_url
        if name == ""{
            cell.username.text = "Searching"
            cell.userImage.isHidden = true
        }
        
        cell.username.text = name
        cell.userImage.downloaded(from: imagUrl)
       
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.isUserInteractionEnabled = true
        print(Results[indexPath.row].login)
        
        let userinfo = Results[indexPath.row].login
        
        self.performSegue(withIdentifier: "info", sender: userinfo)
        
    }
    
    
    
    
    
}


