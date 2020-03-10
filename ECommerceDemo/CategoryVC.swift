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
    
     @IBOutlet var tableFilterList : UITableView?
    
    var filterProductList:[Products]?
    var filterTitle = ""
    var isFilter = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Categories"
        
        self.tableFilterList?.isHidden = true
        
        globalDelegate.categoriesList = globalDelegate.jsonHelper.parseJsonContent()
        self.addFilterBtnonNavigationBar()
        self.tableCategory?.reloadData()
    }
    
    // MARK: View related Functions
    func addFilterBtnonNavigationBar(){
      
        let filterBtn = UIButton ()
        filterBtn.setImage(UIImage(named: "filter"), for: .normal)
        filterBtn.frame = CGRect(x : 0, y : 0, width : 22, height : 22)
        filterBtn.addTarget(self, action: #selector(filterBtnClick(sender:)), for: .touchUpInside)
        let addSettingBtn = UIBarButtonItem()
        addSettingBtn.customView = filterBtn
        
        self.navigationItem.rightBarButtonItems = [addSettingBtn]
    }
    
    @IBAction func filterBtnClick(sender : UIButton)
       {
        self.tableFilterList?.isHidden = !self.tableFilterList!.isHidden
       }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let tagValue:Int = sender! as! Int
        let productListVC:ProductListVC = segue.destination as! ProductListVC
        
        if(isFilter)
        {
            productListVC.productList = self.filterProductList
            productListVC.strTitle = self.filterTitle
        }else{
            let categoryObj = globalDelegate.categoriesList![tagValue]
            productListVC.productList = categoryObj.products
        }
        
       
    }
    
   


}


extension CategoryVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(tableView == self.tableFilterList)
        {
            return globalDelegate.rankingList!.count
        }else{
           return globalDelegate.categoriesList!.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as? CategoryCell
        if(tableView == self.tableFilterList)
        {
             let rankingObj = globalDelegate.rankingList![indexPath.row]
            cell?.lblCategoryName?.text = rankingObj.ranking
            
        }
        else{
        
        
        let categoryObj = globalDelegate.categoriesList![indexPath.row]
        if(indexPath.row % 2 == 0){
            cell?.categoryView?.backgroundColor = UIColor.darkGray
        }
        else{
            cell?.categoryView?.backgroundColor = UIColor.lightGray
        }
        
        cell?.lblCategoryName?.text = categoryObj.name
        cell?.lblCategoryName?.textColor = UIColor.white
        
        
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    
}


extension CategoryVC:UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        isFilter = false
        if(tableView == self.tableFilterList)
        {
            let rankingObj:Rankings = globalDelegate.rankingList![indexPath.row]
            
            let prodLis:[ProductInfo] = rankingObj.productsInfo!
           
            //let filteredNames = peopleArray.filter( {$0.age > 18 }).map({ return $0.name })
            
            var prodId:[Int] = []
            
            for prod in prodLis{
                prodId.append(prod.id)
            }
            
            filterProductList = (globalDelegate.globalProductList.filter({prodId.contains($0.id ?? 0)}))
            filterTitle = rankingObj.ranking ?? "Filterd Product"
            isFilter = true
            
            
        }
        
        
        self.performSegue(withIdentifier: "ProductListVC", sender: indexPath.row)
        
        
    }
}
