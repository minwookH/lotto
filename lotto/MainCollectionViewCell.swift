//
//  MainCollectionViewCell.swift
//  lotto
//
//  Created by teruten on 2018. 4. 10..
//  Copyright © 2018년 Dev. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var menuimageView: UIImageView!
    
    func displayContent(name : String, image : String){
        menuLabel.text = name
    }
}
