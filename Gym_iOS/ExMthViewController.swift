//
//  ExMthViewController.swift
//  Gym_iOS
//
//  Created by elite on 2016. 1. 15..
//  Copyright © 2016년 sun. All rights reserved.
//


import Alamofire
import UIKit

class ExMthViewController: UIViewController{
    var id: Int?
    var ExTitle: String?
    var ImageUrl: String!
    
    @IBOutlet weak var ExImage: UIImageView!
    @IBOutlet weak var ExerciseExplanation: UITextView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        Alamofire.request(.GET, "http://gymdb.dev/exmths/"+String(self.id!)+".json", parameters: nil)
            .responseJSON {
                response in
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.result)   // result of response serialization
                
                
                //API호출 결과
                if let JSON = response.result.value {
                    if let dict = JSON as? NSDictionary {
                                    
                        self.ExerciseExplanation.text = dict["ex_mth_ep"] as? String
                        self.ImageUrl = (dict["ex_mth_img"] as! String)
                        print(self.ExerciseExplanation!)
                        print(self.ImageUrl)
                        //self.ImageUrl = self.ImageUrl
                    }
                }
                
        
                let imagePath = self.ImageUrl
                //let imagePath = "http://high5.kr/upload/editor/deadfits.jpg"
                
                Alamofire.request(.GET, imagePath).response() {
                    //imagePath가 가지고있는 url로 이미지를 로드하여 UIImageView에 세팅한다
                    (_, _, data, _) in
                    let image = UIImage(data:data!)
                    self.ExImage.image = image
                }
        }
        

        

    }
    
}
