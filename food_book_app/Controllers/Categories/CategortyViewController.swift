//
//  ViewController.swift
//  food_book_app
//
//  Created by Cenk Bahadır Çark on 2.09.2022.
//

import UIKit
import SDWebImage

class CategoryViewController: UIViewController {
    
    var categoryList = [Category]()
    var chosenCategory : Category?

    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getAllCategory()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getAllCategory() {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php")!
        
        URLSession.shared.dataTask(with: url){data, response, error in
            guard error == nil else {
                print("error")
                return
            }
            do{
                
                let response = try JSONDecoder().decode(CategoriesResponse.self, from: data!)
                if let gelenListe = response.categories{
                    self.categoryList = gelenListe
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }catch{
                print("catch error")
            }
        }.resume()
    }
    //sending selected data to another view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        
        let destinationVC = segue.destination as! DetayCategoryViewController
        destinationVC.selectedCategoryID = indeks! + 1
    }



}
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath) as! CategoryCollectionViewCell
        
        let category = categoryList[indexPath.row]
        
        cell.categoryName.text = category.strCategory
        cell.categoryImage.sd_setImage(with: URL(string: category.strCategoryThumb!))
        
        cell.layer.cornerRadius = 25.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetayCategory", sender: indexPath.row)
    }
    
}

