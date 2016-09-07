//
//  AllAlbumCell.swift
//  Pokemon
//
//  Created by Evgeny on 9/6/16.
//  Copyright © 2016 Evgeny. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
//import RxCocoa

class AllAlbumCell: UITableViewCell {
  
    
    private(set) var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        
        self.disposeBag = DisposeBag()
        
        super.prepareForReuse()
    }
    
    
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var checkSwitch: UISwitch!
    
    @IBAction func check(sender: AnyObject) {
        
        
  
        
//        checkSwitch.on = false
//            (sender as! UISwitch).on
//        dupSwitch.on = (sender as UISwitch).on
        
    }
    
}