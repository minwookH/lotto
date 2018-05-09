//
//  SaveLottoViewController.swift
//  lotto
//
//  Created by teruten on 2018. 5. 4..
//  Copyright © 2018년 Dev. All rights reserved.
//

import UIKit

class SaveLottoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        var items = navigationItem
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(backAction))
        
        navigationBar.items = [navigationItem]
        // Do any additional setup after loading the view.
    }
    
    @objc func backAction() -> Void {
        print("back action!!!!!")
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt start")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaveLottoCollectionViewCell", for: indexPath) as! SaveLottoCollectionViewCell
        
        cell.displayContent(name: (String)(indexPath.row+1))
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
        
        cell.backgroundColor = UIColor.yellow
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 45
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("sizeForItemAt start")
        let width = collectionView.bounds.size.width
        let height = collectionView.bounds.size.height
        
        let cellWidth = width / 7 - 3
        let cellHeight = height / 7 - 3
        
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt start!!!!")
        
        let cell = collectionView.cellForItem(at: indexPath) as! SaveLottoCollectionViewCell
        cell.setSelectNumber()
        
        if indexPath.row == 0{
            print("didSelectItemAt 0")
        } else if indexPath.row == 1{
            print("didSelectItemAt 1")
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
