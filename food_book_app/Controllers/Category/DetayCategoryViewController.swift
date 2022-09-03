//
//  DetayCategoryViewController.swift
//  food_book_app
//
//  Created by Cenk Bahadır Çark on 3.09.2022.
//

import UIKit
import SDWebImage

class DetayCategoryViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var detayCollectionView: UICollectionView!
    
    var selectedCategoryID : Int?
    var mealList = [Meal]()
    var selectedCategoryName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detayCollectionView.delegate = self
        detayCollectionView.dataSource = self
        navBar.largeTitleDisplayMode = .always
        
        getMeal(from: selectedCategoryID!)
        getCategory(from: selectedCategoryName!)
        navBar.title = selectedCategoryName
        navigationController?.navigationBar.prefersLargeTitles = true
  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let meal = sender as? Meal
        
        //TODO: Ünlem kullanımından kaçın. Optional yap
        if segue.identifier == "toMeal" {
            if let destination = segue.destination as? MealViewController {
                destination.selectedMeal = meal
            }
        }
    }
    
    func getMeal(from selectedCategoryID : Int){
        switch selectedCategoryID {
        case 1:
            return selectedCategoryName = "Beef"
        case 2:
            return selectedCategoryName = "Chicken"
        case 3:
            return selectedCategoryName = "Dessert"
        case 4:
            return selectedCategoryName = "Lamb"
        case 5:
            return selectedCategoryName = "Miscellaneous"
        case 6:
            return selectedCategoryName = "Pasta"
        case 7:
            return selectedCategoryName = "Pork"
        case 8:
            return selectedCategoryName = "Seafood"
        case 9:
            return selectedCategoryName = "Side"
        case 10:
            return selectedCategoryName = "Starter"
        case 11:
            return selectedCategoryName = "Vegan"
        case 12:
            return selectedCategoryName = "Vegetarian"
        case 13:
            return selectedCategoryName = "Breakfast"
        case 14:
            return selectedCategoryName = "Goat"
        default:
            break
        }
    }
    //TODO: Servis istekleri asla burada atılmaz. Bunun için Network class'ı oluştur.
    func getCategory(from categoryName: String){
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(categoryName)")
        
        URLSession.shared.dataTask(with: url!){data, response, error in
            guard error == nil else {
                print("error")
                return
            }
            do{
                
                let response = try JSONDecoder().decode(CategoryResponse.self, from: data!)
                if let gelenListe = response.meals{
                    self.mealList = gelenListe
                }
                DispatchQueue.main.async {
                    self.detayCollectionView.reloadData()
                }
            }catch{
                
            }
            
        }.resume()
    }

}
extension DetayCategoryViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mealList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let meal = mealList[indexPath.row]
        
        let cell = detayCollectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! DetayCategoryCollectionViewCell
        //TODO: cell içerisine config() gibi bir fonksiyon tanımla onu burada çağır.
        
        cell.foodNameLbl.text = meal.strMeal
        cell.imageView.sd_setImage(with: URL(string: meal.strMealThumb!))
        cell.layer.cornerRadius = 25.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMeal", sender: mealList[indexPath.row])
    }
    
}
