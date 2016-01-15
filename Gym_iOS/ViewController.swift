//
//  ViewController.swift
//  Gym_iOS
//
//  Created by elite on 2016. 1. 12..
//  Copyright © 2016년 sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func moveBMI(sender:AnyObject){
    
            //이동할 뷰 컨트롤러 인스턴스 생성
            let uvc1 = self.storyboard?.instantiateViewControllerWithIdentifier("BMI01")
            
            //화면 전환 스타일 설정
            //uvc1?.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
            
            //화면전환
//            self.presentViewController(uvc1!, animated: true, completion: nil)
        self.navigationController?.pushViewController(uvc1!, animated: true)
    
    }

    @IBAction func moveExPt(sender: AnyObject) {
        //이동할 뷰 컨트롤러 인스턴스 생성
        let uvc2 = self.storyboard?.instantiateViewControllerWithIdentifier("EP01")
        
        //화면 전환 스타일 설정
        //uvc2?.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        
        //화면전환
        //self.presentViewController(uvc2!, animated: true, completion: nil)
         self.navigationController?.pushViewController(uvc2!, animated: true)
    }

}

















































