//
//  SpacesVC.swift
//  iFlat
//
//  Created by Alican Yilmaz on 29/12/2016.
//  Copyright © 2016 SE 301. All rights reserved.
//

import UIKit

class SpacesVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var spacesTV: UITableView!
    var dbFlat = FIRFlat()
    var dbUser = FIRUSER()

    var flatsArr = [Flat]()
    var flatImgArr = [String]()

    var currentUsr:User? {
        didSet{
            self.dbFlat.getFlatsofUser(userID: (currentUsr?.id)!) { (flats) in
                self.flatsArr = flats as! [Flat]
                for a in flats!
                {
                    self.dbFlat.getFlatImages(flatID: a.id, completion: { (imgs) in
                        self.flatImgArr.append((imgs?.first?.imageDownloadURL)!)
                        self.spacesTV.reloadData()
                    })
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbUser.getCurrentLoggedIn { (usr) in
            self.currentUsr = usr as? User
        }

    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = spacesTV.dequeueReusableCell(withIdentifier: "spacescell", for: indexPath) as! spacescell
        let url = URL(string:self.flatImgArr[indexPath.row])
        cell.flatThumbImg.kf.setImage(with: url)
        cell.flatPricesLbl.text = String(describing: self.flatsArr[indexPath.row].price!) + "₺"
        cell.flatTitleLbl.text = self.flatsArr[indexPath.row].title
        cell.accessoryType = UITableViewCellAccessoryType.checkmark
        return cell
        
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flatsArr.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexpath) in
            
        }
        delete.backgroundColor = UIColor.red
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexpath) in
        }
        edit.backgroundColor = UIColor.blue
        
        let publish = UITableViewRowAction(style: .normal, title: "Publish") { (action, indexpath) in
        }
        publish.backgroundColor = UIColor.gray
        

        return [delete, publish, edit]
    }
    
    


}
