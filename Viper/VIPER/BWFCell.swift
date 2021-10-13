
import Foundation
import UIKit
class BWFCell:UITableViewCell {
    
    var bwfEntity:BWFEntity? {
        didSet {
            configure()
        }
    }
    
    private let label:UILabel = {
        let label = UILabel()
        return label
    }()
    private let playerImage:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let rankLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    private let earningsLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .cyan
        addSubview(playerImage)
        addSubview(label)
//        addSubview(rankLabel)
//        addSubview(earningsLabel)
        playerImage.anchor(left:leftAnchor,paddingLeft: 20,centerY: centerYAnchor,width: 50,height: 50)
        label.anchor(left:playerImage.rightAnchor,paddingLeft: 20,centerY: centerYAnchor,height: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        guard let bwfEntity = bwfEntity else {
            return
        }
        label.text = bwfEntity.name
    }
}
