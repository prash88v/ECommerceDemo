//
//  jsonHelper.swift
//  ECommerceDemo
//
//  Created by Prashant  on 3/6/20.
//  Copyright © 2020 Prashant. All rights reserved.
//

import Foundation



class JsonHelper{
    
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    
    
    // MARK: - Download json file and save to local
    
    func loadJsonFromServerToLocal() {

        //Create URL to the source file you want to download
        let fileURL = URL(string: kFileServerUrl)

        // Create destination URL with file name
        let destinationFileUrl:URL = self.getDocumentsDirectory().appendingPathComponent("eComm.json")
        let fileExists = FileManager().fileExists(atPath: destinationFileUrl.path)
        
        if (fileExists)
        {
            print("file already dowbloaded")
        
            
        }else{
            
            do{
             let data = try Data(contentsOf: fileURL!)
                
                do{
                    
                try data.write(to: destinationFileUrl, options: [.atomicWrite])
                }
                catch{
                    print("error in saving file at local url ---")
                }
                    
           
                
            }catch{
                print("error in file parsing at server url ---")
            }
            
        }
        
    }
    
    

    
    func parseJsonContent()->[Categories]?
    {
       
       
        // Create destination URL with file name
        let destinationFileUrl:URL = self.getDocumentsDirectory().appendingPathComponent("eComm.json")

            do {

                
               let data = try Data(contentsOf: destinationFileUrl, options: [])
               let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves]) as? Dictionary<String, Any>
                
                //Parse ranking info
                 
                 var rankingObjList:[Rankings] = [Rankings] ()
                let rankingDictList:[Dictionary<String,Any>] = jsonObject!["rankings"] as! [Dictionary]
                 
                 for ranking in rankingDictList{
                     
                     let rankingValue = ranking["ranking"]
                     
                 var productInfoList:[ProductInfo] = [ProductInfo] ()
                 let prodInfoList:[Dictionary<String,Any>] = ranking["products"] as! [Dictionary]
                     for productInfo in prodInfoList
                      {
                          
                          let prodInfo : ProductInfo = ProductInfo(id: productInfo["id"] as? Int ?? 0, view_count: productInfo["view_count"] as? Int ?? 0)
                          
                          productInfoList.append(prodInfo)
                     
                          
                          
                      }
                     
                     let rankingObj = Rankings(ranking: rankingValue as? String ?? "", productsInfo: productInfoList)
                     
                     rankingObjList.append(rankingObj)
                     
                 }
                 
                
                 globalDelegate.rankingList = rankingObjList
                 
                 
                 
            
                
                if let categorieDictList : [Dictionary<String, Any>]   = jsonObject!["categories"] as? [Dictionary<String, Any>] {
                    print("categorieDictList list ---",categorieDictList)
                    
                    var categoryObjList:[Categories] = [Categories]()
                    
                    for category in categorieDictList
                    {
                       
                        let categoryName = category["name"] as? String ?? ""
                        let categoryID = category["id"] as? Int ?? 0
                        
                        let prodList:[Dictionary<String,Any>] = category["products"] as! [Dictionary]
                        var productObjList:[Products] = [Products] ()
                        
                        
                        for prod in prodList
                        {
                            
                        print("prodcuts in category",categoryName,prod)
                            
                            //parse product name and id
                            
                            let productName = prod["name"]
                            let productID = prod["id"]
                            
                            //Parse Vareinst Details
                            var varientsObjList:[Variants] = [Variants] ()
                            let variantsList:[Dictionary<String,Any>] = prod["variants"] as! [Dictionary]
                            
                            for varient in variantsList{

                                let varientObj:Variants = Variants(id:varient["id"] as? Int ?? 0, color: varient["color"] as? String ?? "", size: varient["size"] as? Int ?? 0, price: varient["price"] as? Int ?? 0)
                                
                                varientsObjList.append(varientObj)
                            }
                            
                            
                            //Parse Tax Details
                            
                            let taxInfo:Dictionary<String,Any> = prod["tax"] as! Dictionary
                            let taxObj = Tax(name: taxInfo["name"] as? String ?? "", value: taxInfo["value"] as? Double ?? 0.0)
                            
                            
                            //fill all details in product object
                            
                            let product:Products = Products(id: productID as? Int ?? 0, name: productName as? String ?? "", date_added: "", tax: taxObj, variants: varientsObjList)
                            
                            
                            globalDelegate.globalProductList.append(product)
                            productObjList.append(product)
                            
                        }
                     
                        //Create category object
                        
                        let categoryObj = Categories(id: categoryID, name: categoryName, products: productObjList)
                        
                        categoryObjList.append(categoryObj)
                       
                    }
                    
                    return categoryObjList
                    //globalDelegate.categoriesList = categoryObjList
                    
                  
                }
                
                
                
               
            }catch {
                print(error)
            }

        return nil
        }
    }

  
