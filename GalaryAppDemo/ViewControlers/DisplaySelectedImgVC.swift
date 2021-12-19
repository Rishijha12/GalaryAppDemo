//
//  DisplaySelectedImgVC.swift
//  GalaryAppDemo
//
//  Created by Rishi Jha on 19/12/21.
//

import UIKit
import SDWebImage

protocol DismissDelegte{
    func dismiss()
}

class DisplaySelectedImgVC: UIViewController{
    
    
    
    //   MARK: ---------------------IBOUTLET------------------
//    @IBOutlet weak var selectedImgTblView: UITableView!{
//        didSet{
//
//        }
//    }
//
    @IBOutlet weak var selectedImgTblView: UICollectionView!{
        didSet{
        
        }
    }
    
    @IBOutlet weak var dismissBtn: UIButton!{
        didSet{
            
        }
    }
    
    //   MARK: ---------------------Local Variable------------------
    var selectedImgArr = [GallaryModel]()
    var popDelegate: DismissDelegte?
    var indexPath = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedImgTblView.delegate = self
        self.selectedImgTblView.dataSource = self
    }
    
    //   MARK: ---------------------IBACTION------------------
    @IBAction func btnActionDismiss(_ sender: UIButton) {
        self.popDelegate?.dismiss()
    }
}

extension DisplaySelectedImgVC: UICollectionViewDelegate, UICollectionViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return selectedImgArr.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "selectedImgCell") as! selectedImgCell
//        let data = selectedImgArr[indexPath.row]
//        cell.selectetImg.sd_setImage(with: URL(string: data.url!))
//        return cell
//    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectedImgCell", for: indexPath) as! selectedImgCell
        
        let data = selectedImgArr[self.indexPath.row]
        cell.selectetImg.sd_setImage(with: URL(string: data.url!))
        return cell
    }
}
