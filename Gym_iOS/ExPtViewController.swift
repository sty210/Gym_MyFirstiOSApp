//
//  ExPtViewController.swift
//  Gym_iOS
//
//  Created by elite on 2016. 1. 14..
//  Copyright © 2016년 sun. All rights reserved.
//

import Alamofire

import UIKit

class ExPtViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var ExPtTableView: UITableView!
    @IBOutlet weak var InputPartBox: UITextField!
    
    var ExerciseListArray = [ExerciseListModel]()
    var ExerciseImageListArray = [ExerciseImageListModel]()
    var Expart:String?
    
    @IBAction func SearchBtnClicked(sender: AnyObject) {
        if InputPartBox.text == "가슴" {
            Expart = "1"
        }else if InputPartBox.text == "팔" {
            Expart = "2"
        }else if InputPartBox.text == "다리" {
            Expart = "3"
        }else if InputPartBox.text == "복근" {
            Expart = "4"
        }else if InputPartBox.text == "등" {
            Expart = "5"
        }else if InputPartBox.text == "전신" {
            Expart = "6"
        }else{
            
        }
        
        startLogic()
    }
    
    func startLogic(){
        
        self.ExerciseListArray.removeAll()
        self.ExerciseImageListArray.removeAll()
        
        //API호출
        Alamofire.request(.GET, "http://gymdb.dev/expts/"+Expart!+".json", parameters: nil)
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
                
                let parameters = ["category": "expt", "id": self.Expart!]
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
                                            ExImgModel.id = dict2["ex_det_cd"] as? Int
                                            print(ExImgModel.cellImageViewStr)
                                            self.ExerciseImageListArray.append(ExImgModel)
                                        }
                                    }
                                }
                                self.ExPtTableView.reloadData()
                            }
                        }
                }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ExerciseListArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ExPtTableViewCell", forIndexPath: indexPath) as! ExPtTableViewCell

        cell.nameLabel.text = ExerciseListArray[indexPath.row].nameLabelStr!;
        
        cell.id = ExerciseImageListArray[indexPath.row].id!;
        let imagePath = ExerciseImageListArray[indexPath.row].cellImageViewStr!;
        
        Alamofire.request(.GET, imagePath).response() {
            //imagePath가 가지고있는 url로 이미지를 로드하여 UIImageView에 세팅한다
            (_, _, data, _) in
            let image = UIImage(data:data!)
            cell.cellImageView.image = image
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let cell = sender as? UITableViewCell {
            let i = ExPtTableView.indexPathForCell(cell)!.row
            if segue.identifier == "ToExMthVC2" {
                let vc = segue.destinationViewController as! ExMthViewController
                vc.id = ExerciseImageListArray[i].id
            }
        }
    }
    
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

        
}
