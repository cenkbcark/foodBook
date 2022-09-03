//
//  MealViewController.swift
//  food_book_app
//
//  Created by Cenk Bahadır Çark on 3.09.2022.
//

import UIKit
import SDWebImage

class MealViewController: UIViewController {
    
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var mealNameLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    //from catergory
    var selectedMeal : Meal?
    //from http request
    var showingMeal : Response?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSelectedMeal(from: selectedMeal?.idMeal ?? "")

    }

    func getSelectedMeal(from mealID : String){
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)")
        
        URLSession.shared.dataTask(with: url!){data, response, error in
            if error != nil{
                print("error")
            }
            do{
                let response = try JSONDecoder().decode(MealResponse.self, from: data!)
                if let gelenMeal = response.meals{
                    DispatchQueue.main.async {
                        gelenMeal.map{self.mealNameLbl.text = $0.strMeal}
                        gelenMeal.map{self.areaLbl.text = $0.strArea}
                        gelenMeal.map{self.descText.text = $0.strInstructions}
                        gelenMeal.map{self.imageView.sd_setImage(with: URL(string: $0.strMealThumb!))}
                    }
                }
            }catch{
                print("catch error")
            }
        }.resume()
    }
}
