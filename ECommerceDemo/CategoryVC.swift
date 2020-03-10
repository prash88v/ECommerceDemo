//
//  CategoryVC.swift
//  ECommerceDemo
//
//  Created by Prashant  on 3/6/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    
    @IBOutlet var tableCategory : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Categories"
        globalDelegate.categoriesList = globalDelegate.jsonHelper.parseJsonContent()
        self.tableCategory?.reloadData()
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let tagValue:Int = sender! as! Int
        let productListVC:ProductListVC = segue.destination as! ProductListVC
        
        let categoryObj = globalDelegate.categoriesList![tagValue]
        productListVC.productList = categoryObj.products
    }
    
   


}


extension CategoryVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        globalDelegate.categoriesList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as? CategoryCell
        
        let categoryObj = globalDelegate.categoriesList![indexPath.row]
        if(indexPath.row % 2 == 0){
            cell?.categoryView?.backgroundColor = UIColor.darkGray
        }
        else{
            cell?.categoryView?.backgroundColor = UIColor.lightGray
        }
        
        cell?.lblCategoryName?.text = categoryObj.name
        cell?.lblCategoryName?.textColor = UIColor.white
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    
}


extension CategoryVC:UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.performSegue(withIdentifier: "ProductListVC", sender: indexPath.row)
        
        
    }
}
