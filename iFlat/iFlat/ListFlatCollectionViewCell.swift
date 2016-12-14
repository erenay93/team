//
//  ListFlatCollectionViewCell.swift
//  iFlat
//
//  Created by Eren AY on 05/12/16.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class ListFlatCollectionViewCell: UICollectionViewCell {
    
    
    var flatID : String = ""
    
    @IBOutlet var flatThumbnail: UIImageView!
    @IBOutlet weak var flatTitle: UILabel!
    @IBOutlet weak var flatPrice: UILabel!
    @IBOutlet weak var flatCity: UILabel!
    @IBOutlet weak var flatRating: UILabel!
    
    func setFlatListCell(ID : String, thumbnail : UIImage, title : String, price : String, city : String, rating : Int){
        flatID = ID
        flatThumbnail.image = thumbnail
        flatTitle.text = title
        flatPrice.text = price
        flatCity.text = city
        flatRating.text = String(rating)
    }

}
