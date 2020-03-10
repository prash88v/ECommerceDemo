//
//  ProductDetailVC.swift
//  ECommerceDemo
//
//  Created by Prashant  on 3/9/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

//HFS015144

import UIKit

class ProductDetailVC: UIViewController {
  
     @IBOutlet var tableProductList : UITableView?
    @IBOutlet var productImageV:UIImageView?
    @IBOutlet var lblVat : UILabel?
    @IBOutlet var lblTotalPrice : UILabel?
    
    var product:Products?
    var tax:Tax?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Product Detail"
        
        
        tax = product?.tax
        let taxName = tax?.name ?? ""
        self.lblVat?.text = "  " + taxName  + " : " + (tax?.value.description)!
        
        self.tableProductList?.reloadData()
        
        
        
    }
  
}

extension ProductDetailVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        (self.product?.variants!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as? CategoryCell
        
        let prodVarientsObj = self.product?.variants![indexPath.row]

        let size = prodVarientsObj?.size
        let color = prodVarientsObj?.color
        cell?.lblCategoryName?.text = color! + "-" + size!.description
        
        let price = prodVarientsObj?.price ?? 0
        
        cell?.lblPrice!.text = "Price :- " + price.description
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120.0
    }
    
}


extension ProductDetailVC:UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let prodVarientsObj = self.product?.variants![indexPath.row]
       
        let price = prodVarientsObj?.price ?? 0
        
        let tottalPrice = self.tax!.value + Double(price)
        
        self.lblTotalPrice?.text = "  Total Price :-" + tottalPrice.description
        
        
        if(indexPath.row % 2 == 0){
            self.productImageV?.image = UIImage(named:"placeholder")
        }
        else{
            self.productImageV?.image = UIImage(named:"placeholder1")
        }
     
    }
}
