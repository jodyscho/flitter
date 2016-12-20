//
//  TweetTableViewCell.swift
//  flitter
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var tweetText: UILabel!
}

extension TweetTableViewCell {
    
    func configure(viewModel: TweetViewModel) {
        displayName.text = viewModel.displayName
        userName.text = viewModel.userName
        createdDate.text = viewModel.createdDate
        tweetText.text = viewModel.tweetText
    }
}
