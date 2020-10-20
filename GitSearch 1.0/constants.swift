//
//  constants.swift
//  GitSearch 1.0
//
//  Created by Ravi Thakur on 18/10/20.
//

import Foundation
import UIKit

let appdelegate = UIApplication.shared.delegate as! AppDelegate
let context = persistanceService.persistentContainer.viewContext

var histrotyUser = [User]()

var searchcontrolelr: UISearchController = UISearchController(searchResultsController: nil)


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
//var saveduser : [Users] = []


