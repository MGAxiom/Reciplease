//
//  ViewController.swift
//  Reciplease
//
//  Created by Maxime Girard on 19/05/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        RecipeSearchService.shared.recipeAPI(userInput: "chicken")
    }


}

