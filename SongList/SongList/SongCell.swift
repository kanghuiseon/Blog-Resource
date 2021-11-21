//
//  SongCell.swift
//  SongList
//
//  Created by 강희선 on 2021/11/20.
//

import UIKit

class SongCell: UITableViewCell {
    @IBOutlet var songImageView: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var artistName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
