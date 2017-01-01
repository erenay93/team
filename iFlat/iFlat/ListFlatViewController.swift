//
//  ListFlatViewController.swift
//  iFlat
//
//  Created by Eren AY on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class ListFlatViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var receivedFilter = FilterModel()
    var filteredFlats: [FilteredFlat] = []
    var ownerID:String?
    var flatID:String?
    @IBOutlet weak var listFlatCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = false
        self.tabBarController?.tabBar.isUserInteractionEnabled = false
        
        
        let qm = Querymaster()
        
        
        qm.getFilteredFlats(filter: self.receivedFilter) { (dsa) in
            self.filteredFlats = dsa
            
            DispatchQueue.main.async {
                self.listFlatCollectionView.reloadData()
                self.indicator.stopAnimating()
                self.tabBarController?.tabBar.isUserInteractionEnabled = true
                self.view.isUserInteractionEnabled = true


                
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getFlatInfoFromFireBase(filter : FilterModel){
        print("getFlatInfoCalled")
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSize(width: (UIScreen.main.bounds.width),height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = listFlatCollectionView.dequeueReusableCell(withReuseIdentifier: "flatCell", for: indexPath) as! ListFlatCollectionViewCell
        if let urlString =  self.filteredFlats[indexPath.row].flatThumbnailImage?.imageDownloadURL
        {
            let url = URL(string:urlString)
            cell.flatThumbnail.kf.setImage(with: url)
        }
        cell.flatID = self.filteredFlats[indexPath.row].flatID!
        cell.flatOwnerID = self.filteredFlats[indexPath.row].userID!
        cell.flatTitle.text = self.filteredFlats[indexPath.row].flatTitle
        cell.flatPrice.text = "₺" + String(describing: self.filteredFlats[indexPath.row].flatPrice!)
        cell.flatCity.text = self.filteredFlats[indexPath.row].flatCity
        cell.flatRating.text = "****"
        
        
        

        return cell
    }
    
    /** This function returns filteredFlats.count quantity to collection view which is delegate function of Collection View
     
     - returns: int
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredFlats.count
    }
    
    



        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let cell = listFlatCollectionView.cellForItem(at: indexPath) as! ListFlatCollectionViewCell
            let storyboard = UIStoryboard(name: "FlatProfile", bundle: nil)

            let flatProfileVC = storyboard.instantiateViewController(withIdentifier: "flatProfile") as! FlatProfileViewController


            performSegue(withIdentifier: "flatProfileSegue", sender: cell)
            
        }
        
    // Segue function for passing variable to 'FlatProfileViewController' and 'FiltersViewController'
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          
          if segue.identifier == "filterSegue"{
                let filterVC = segue.destination as! FiltersViewController
                filterVC.filter = self.receivedFilter
            }
          else if(segue.identifier == "flatProfileSegue"){
          
            let indexPath = listFlatCollectionView.indexPath(for: sender as! ListFlatCollectionViewCell)

            let flatProfileVC = segue.destination as! FlatProfileViewController
            flatProfileVC.ownerID = self.filteredFlats[(indexPath?.row)!].userID
            flatProfileVC.receivedFlat = self.filteredFlats[(indexPath?.row)!] as! FilteredFlat
            

            }
            
            
            
        }

        
        
        
        
    }
    
    



