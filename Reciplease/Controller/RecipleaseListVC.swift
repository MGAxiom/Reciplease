//
//  RecipleaseListViewController.swift
//  Reciplease
//
//  Created by Maxime Girard on 24/05/2023.
//

import UIKit

class RecipleaseListVC: UIViewController {
    
    
    let data = [""]
    
    var filteredData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func fetchRecipes() {
        
    }
}

extension RecipleaseListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ingredientCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Insert precise recipe search API Call
    }
}
