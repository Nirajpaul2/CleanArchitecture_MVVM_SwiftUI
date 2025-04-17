//
//  LectureSearchCell.swift
//  CleanArchitecture
//
//  Created by Niraj Paul on 3/8/25.
//

import UIKit

class LectureSearchCell: UITableViewCell {
    @IBOutlet weak var lectureTitleLabel: UILabel!
    @IBOutlet weak var lectureSubTitleLabel: UILabel!
    @IBOutlet weak var lecturePriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension LectureSearchCell {
    func bindData(data: CultureLecture, row: Int) {
        self.lectureTitleLabel.text = data.crsNm
        
        if let applyCntCal = data.applyCntCal, let nickNm = data.nickNm, let timeclassinfo = data.timeclassinfo {
            self.lectureSubTitleLabel.text = "\(applyCntCal) times | \(nickNm) | \(timeclassinfo)"
        }
        if let tuition = data.tuition {
            self.lecturePriceLabel.text = "\(tuition.numberWithCommaFormat)원" // "원" means Korean Won (currency)
        }
    }
}
