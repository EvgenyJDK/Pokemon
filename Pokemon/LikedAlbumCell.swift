//
//  LikedAlbumCell.swift
//  Pokemon
//
//  Created by Evgeny on 9/6/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import UIKit

class LikedAlbumCell : UITableViewCell {
  
    
    @IBOutlet weak var idLike: UILabel!
    @IBOutlet weak var titleLike: UILabel!
    @IBOutlet weak var nameLike: UILabel!
    @IBOutlet weak var likeSwitch: UISwitch!
    @IBAction func dislikeAction(sender: AnyObject) {
    }
    
    
    func setupSwitch (like : Bool) {
        
        likeSwitch.on = like
    }

    
    
}