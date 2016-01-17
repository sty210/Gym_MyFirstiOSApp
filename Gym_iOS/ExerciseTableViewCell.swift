//
//  ExerciseTableViewCell.swift
//  Gym_iOS
//
//  Created by elite on 2016. 1. 13..
//  Copyright © 2016년 sun. All rights reserved.
//

import Foundation
import UIKit

class ExerciseTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var id: Int?
    var cellImageViewStr: String?
    var nameLabelStr: String?
}
