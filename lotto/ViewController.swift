//
//  ViewController.swift
//  lotto
//
//  Created by teruten on 2018. 4. 3..
//  Copyright © 2018년 Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    

    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    var test : Array<String> = []
    
    override func viewDidLoad() {
        print("viewDidLoad start")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        test.append("금주의 추천번호")
        test.append("번호메모")
        test.append("구매내역")
        test.append("번호조합")
        test.append("당첨번호&당첨금")
        test.append("당첨후기")
        
        
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt start")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        
        cell.displayContent(name: test[indexPath.row], image: "aa")
//        if indexPath.row == 0{
//            cell.backgroundColor = UIColor.blue
//        } else if indexPath.row == 1{
//            cell.backgroundColor = UIColor.purple
//        } else if indexPath.row == 2{
//            cell.backgroundColor = UIColor.lightGray
//        } else if indexPath.row == 3{
//            cell.backgroundColor = UIColor.green
//        } else if indexPath.row == 4{
//            cell.backgroundColor = UIColor.gray
//        } else if indexPath.row == 5{
//            cell.backgroundColor = UIColor.brown
//        }
        
        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("sizeForItemAt start")
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        
        let cellWidth = width / 2 - 5
        let cellHeight = height / 3 - 3
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            print("didSelectItemAt 0")
        } else if indexPath.row == 1{
            print("didSelectItemAt 1")
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SaveLottoViewController") as! SaveLottoViewController
            self.present(nextViewController, animated:true, completion:nil)
        } else if indexPath.row == 2{
            print("didSelectItemAt 2")
        } else if indexPath.row == 3{
            print("didSelectItemAt 3")
        } else if indexPath.row == 4{
            print("didSelectItemAt 4")
        } else if indexPath.row == 5{
            print("didSelectItemAt 5")
        }
    }

}

