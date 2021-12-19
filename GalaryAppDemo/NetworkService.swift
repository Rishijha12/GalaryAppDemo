//
//  NetworkService.swift
//  GalaryAppDemo
//
//  Created by Rishi Jha on 18/12/21.
//

import Foundation
class NetworkService{
    //   MARK: ---------------------Local variable------------------
//    static let Shared = NetworkService()
    let galleryData = [GallaryModel]()
    weak var VC : ViewController?
    //   MARK: ---------------------GetApiCallMethod------------------
    func callGetApi(url: String){
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if error == nil{
                if let data = data{
                    do {
                        let responseData = try JSONDecoder().decode([GallaryModel].self, from: data)
                        print("Response Data = \(responseData)")
                    }catch let err{
                        print(err.localizedDescription)
                    }
                }
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
}
