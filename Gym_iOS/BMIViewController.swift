//
//  BMIViewController.swift
//  Gym_iOS
//
//  Created by elite on 2016. 1. 13..
//  Copyright © 2016년 sun. All rights reserved.
//
import Alamofire

import UIKit

class BMIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var HeightBox: UITextField!
    @IBOutlet weak var WeightBox: UITextField!
    @IBOutlet weak var ResultLabel: UILabel!
    
    var Height:Double?
    var Weight:Double?
    var Result:Double?
    var Extype:String?
    
    var ExerciseListArray = [ExerciseListModel]()
    var ExerciseImageListArray = [ExerciseImageListModel]()
    
    
    @IBAction func OkBtnCliekd(sender: AnyObject) {
        Height = Double(HeightBox.text!)
        Weight = Double(WeightBox.text!)
        //BMI 계산
        Result = Weight! / ((Height!/100)*(Height!/100))
        
        if Result<18.5{
            ResultLabel.text = "저체중!운동해야 됨"
            Extype = "1"
        }else if Result<23{
            ResultLabel.text = "정상!!적당한운동 고고"
            Extype = "1"
        }else if Result<25{
            ResultLabel.text = "과체중,비만되기 직전."
            Extype = "2"
        }else if Result<30{
            ResultLabel.text = "경도비만,살빼야 됨"
            Extype = "2"
        }else if Result<35{
            ResultLabel.text = "중증비만,살빼야 됨"
            Extype = "2"
        }else{
            ResultLabel.text = "고도비만,위험한 상태"
            Extype = "2"
        }
        
        
        startLogic()
    }

    
    func startLogic(){
        
        self.ExerciseListArray.removeAll()
        self.ExerciseImageListArray.removeAll()
        
        //API호출
        Alamofire.request(.GET, "http://gymdb.dev/extys/"+Extype!+".json", parameters: nil)
            .responseJSON {
                response1 in
                
                print(response1.request)  // original URL request
                print(response1.response) // URL response
                print(response1.result)   // result of response serialization
                
                //API호출 결과
                if let JSON1 = response1.result.value {
                    if let results1 = JSON1 as? NSArray {
                        print(results1)
                        for result1 in results1 {
                            for rs1 in (result1 as? NSArray)! {
                                if let dict1 = rs1 as? NSDictionary {
                                    let ExModel = ExerciseListModel()
                                    ExModel.nameLabelStr = dict1["cd_nm"] as? String
                                    print(ExModel.nameLabelStr)
                                    self.ExerciseListArray.append(ExModel)
                                }
                            }
                        }
                        //                        self.tableView.reloadData()
                    }
                }
                
                let parameters = ["category": "exty", "id": self.Extype!]
                
                Alamofire.request(.GET, "http://gymdb.dev/commoncds.json", parameters: parameters)
                    .responseJSON {
                        response2 in
                        
                        print(response2.request)  // original URL request
                        print(response2.response) // URL response
                        print(response2.result)   // result of response serialization
                        
                        //API호출 결과
                        if let JSON2 = response2.result.value {
                            if let results2 = JSON2 as? NSArray {
                                print(results2)
                                for result2 in results2 {
                                    for rs2 in (result2 as? NSArray)! {
                                        if let dict2 = rs2 as? NSDictionary {
                                            let ExImgModel = ExerciseImageListModel()
                                            ExImgModel.cellImageViewStr = dict2["ex_mth_img"] as? String
                                            print(ExImgModel.cellImageViewStr)
                                            self.ExerciseImageListArray.append(ExImgModel)
                                        }
                                    }
                                }
                                
                                self.tableView.reloadData()
                                
                            }
                        }
                }
        }

    }
    
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ExerciseListArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ExerciseTableViewCell", forIndexPath: indexPath) as! ExerciseTableViewCell
        
        
        cell.nameLabel.text = ExerciseListArray[indexPath.row].nameLabelStr!;
        
        let imagePath = ExerciseImageListArray[indexPath.row].cellImageViewStr!;
        
        Alamofire.request(.GET, imagePath).response() {
            //imagePath가 가지고있는 url로 이미지를 로드하여 UIImageView에 세팅한다
            (_, _, data, _) in
            let image = UIImage(data:data!)
            cell.cellImageView.image = image
        }
        
        return cell
    }
    
    
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}

