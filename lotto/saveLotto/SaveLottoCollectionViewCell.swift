//
//  SaveLottoCollectionViewCell.swift
//  lotto
//
//  Created by teruten on 2018. 5. 4..
//  Copyright © 2018년 Dev. All rights reserved.
//

import UIKit

class SaveLottoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    
    var isSelectedNumber: Bool = false
    
    func displayContent(name : String){
        numberLabel.text = name
    }
    
    func setSelectNumber() -> Void {
        print("setSelectNumber start!!!!")
        if isSelectedNumber {
            print("isSelectedNumber1 \(isSelectedNumber)!!!!")
            isSelectedNumber = false
            
            numberLabel.backgroundColor = UIColor.green
        }else{
            print("isSelectedNumber2 \(isSelectedNumber)!!!!")
            isSelectedNumber = true
            numberLabel.backgroundColor = UIColor.lightGray
        }
    }
}
