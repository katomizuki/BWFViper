import Foundation
import UIKit
import SDWebImage

class BWFCell:UITableViewCell {
    
    var bwfEntity:BWFEntity? {
        didSet {
            configure()
        }
    }
    private let label:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    private let playerImage:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPurple
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
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
        backgroundColor = .white
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
        switch bwfEntity.name {
        case "Kento MOMOTA":
            playerImage.image = UIImage(named: "桃田")
        case "Viktor AXELSEN":
            playerImage.image = UIImage(named: "アクセルセン")
        case "Anders ANTONSEN":
            playerImage.image = UIImage(named: "アントセン")
        case "CHOU Tien Chen":
            playerImage.image = UIImage(named: "周天成")
        case "Anthony Sinisuka GINTING":
            playerImage.image = UIImage(named: "ギンティン")
        case "CHEN Long":
            playerImage.image = UIImage(named: "チェンロン")
        case "Jonatan CHRISTIE":
            playerImage.image = UIImage(named: "ジョナサン")
        case "LEE Zii Jia":
            playerImage.image = UIImage(named: "リージージャ")
        case "NG Ka Long Angus":
            playerImage.image = UIImage(named: "NG")
        case "WANG Tzu Wei":
            playerImage.image = UIImage(named: "王")
        default:
            break
        }
    }
}
