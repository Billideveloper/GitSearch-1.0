//
//  HistoryTableViewController.swift
//  GitSearch 1.0
//
//  Created by Ravi Thakur on 19/10/20.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController {
    
    var user = [User]()
    let UserHistory :NSFetchRequest<User> = User.fetchRequest()


    override func viewDidLoad() {
        super.viewDidLoad()

        fetchdata()
        
        print(user)
        
    }
    
    
    func fetchdata(){
        
        do{
            let user = try persistanceService.context.fetch(UserHistory)
            self.user = user
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    
    
    @IBAction func home(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return user.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "histroycell", for: indexPath) as! histroyTableViewCell

        cell.HName.text = user[indexPath.row].name
        
        let imageurl = user[indexPath.row].avtarUrl!
          
        cell.Himage.downloaded(from: imageurl)

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }


}
