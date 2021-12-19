//
//  ViewController.swift
//  GalaryAppDemo
//
//  Created by Rishi Jha on 18/12/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate,DismissDelegte {
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
 
    //   MARK: ---------------------IBOUTLET------------------
    @IBOutlet weak var gallaryCollectionView: UICollectionView!
    //   MARK: ---------------------Local Variable------------------
    var gallaryData = [GallaryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.gallaryCollectionView.register(UINib(nibName: "GallaryViewCell", bundle: nil), forCellWithReuseIdentifier: "GallaryViewCell")
//        galleryViewModel.VC = self
        self.callGetApi(url: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=42")
    }
    
    //   MARK: ---------------------Custom functions------------------
    func setuNavigation(){
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popupVC = storyboard.instantiateViewController(withIdentifier: "DisplaySelectedImgVC") as! DisplaySelectedImgVC
        popupVC.modalPresentationStyle = .popover
//                popupVC.preferredContentSize = CGSizeMake(300, 300)
                let pVC = popupVC.popoverPresentationController
        pVC?.permittedArrowDirections = .any
                pVC?.delegate = self
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
                pVC?.sourceRect = CGRect(x: 100, y: 100, width: 1, height: 1)
        present(popupVC, animated: true, completion: nil)
    }
    
    //   MARK: ---------------------Api Call------------------
    func callGetApi(url: String){
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if error == nil{
                if let data = data{
                    do {
                        let responseData = try JSONDecoder().decode([GallaryModel].self, from: data)
                        print("Response Data = \(responseData)")
                        for resp in responseData{
                            self.gallaryData.append(resp)
                        }
                        DispatchQueue.main.async {
                            self.gallaryCollectionView.reloadData()
                        }
                    }catch let err{
                        print(err.localizedDescription)
                    }
                }
            }else{
                print(error?.localizedDescription)
            }
        }.resume()
    }

}
//   MARK: ---------------------Extenssion------------------
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gallaryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GallaryViewCell", for: indexPath) as! GallaryViewCell
        let data = self.gallaryData[indexPath.row]
//        print("")
        cell.imgView.sd_setImage(with: URL(string: data.url!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Width = collectionView.bounds.width/3.0 - 3
        let Height = Width

        return CGSize(width: Width, height: Height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DisplaySelectedImgVC") as! DisplaySelectedImgVC
        nextVC.popDelegate = self
        nextVC.selectedImgArr = gallaryData
        nextVC.indexPath = indexPath
//        nextVC.present(nextVC, animated: true, completion: nil)
//        self.navigationController?.pushViewController(nextVC, animated: true)
        self.present(nextVC, animated: true, completion: nil)
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.zero
//    }
    
}

