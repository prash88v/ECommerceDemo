//
//  ProductListVC.swift
//  ECommerceDemo
//
//  Created by Prashant  on 3/9/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import UIKit

class ProductListVC: UIViewController {
    
    
    var productList:[Products]?
    @IBOutlet var tableProductList : UITableView?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Products"
       
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
      {
          let tagValue:Int = sender! as! Int
          let prodDetailVC:ProductDetailVC = segue.destination as! ProductDetailVC
          
        prodDetailVC.product = self.productList![tagValue]
         
      }

}


extension ProductListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.productList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as? CategoryCell
        
       let prodObj = self.productList![indexPath.row]
        if(indexPath.row % 2 == 0){
            cell?.categoryView?.backgroundColor = UIColor.darkGray
        }
        else{
            cell?.categoryView?.backgroundColor = UIColor.lightGray
        }
        
        cell?.lblCategoryName?.text = prodObj.name
        cell?.lblCategoryName?.textColor = UIColor.white
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    
}


extension ProductListVC:UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.performSegue(withIdentifier: "ProductDetailVC", sender: indexPath.row)
        
        
    }
}
