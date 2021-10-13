import Foundation
import UIKit

protocol AnyView {
    var presentar:AnyPresenter? { get set }
    func update(with bwfEntites: [BWFEntity])
    func update(with error: String)
}
//Mark View Viewに集中する
class BWFViewController:UIViewController,AnyView {
    //Mark Properties
    var presentar: AnyPresenter?
    private let tableView:UITableView = {
        let tb = UITableView()
        tb.register(BWFCell.self, forCellReuseIdentifier: "cellId")
        tb.isHidden = true
        return tb
    }()
    var entities:[BWFEntity] = []
    private let label:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    private let MSButton:UIButton = {
        let button = UIButton()
        button.setTitle("男子シングルス", for: .normal)
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.backgroundColor = .magenta
        return button
    }()
    private let MDButton:UIButton = {
        let button = UIButton()
        button.setTitle("男子ダブルス", for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return button
    }()
    private let WSButton:UIButton = {
        let button = UIButton()
        button.setTitle("女子シングルス", for: .normal)
        button.backgroundColor = .systemMint
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return button
    }()
    private let WDButton:UIButton = {
        let button = UIButton()
        button.setTitle("女子ダブルス", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return button
    }()
    private let MIXButton:UIButton = {
        let button = UIButton()
        button.setTitle("ミックス", for: .normal)
        button.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return button
    }()
    
    
    //Mark LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //Mark setupMethod
    private func setupTableView() {
        let stackview = UIStackView(arrangedSubviews: [MSButton,MDButton,WSButton,WDButton,MIXButton])
        stackview.axis = .horizontal
        stackview.spacing = 0
        stackview.distribution = .fillEqually
        view.addSubview(stackview)
        view.addSubview(tableView)
        view.addSubview(label)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        tableView.anchor(top:view.safeAreaLayoutGuide.topAnchor,bottom:view.bottomAnchor, left:view.leftAnchor,right: view.rightAnchor,paddingTop:100,paddingBottom:0, paddingRight:0, paddingLeft: 0)
        stackview.anchor(top:view.safeAreaLayoutGuide.topAnchor,bottom:tableView.topAnchor, left:view.leftAnchor,right:view.rightAnchor,paddingTop: 10,paddingBottom:5, paddingRight:0, paddingLeft: 0)
    }
    
    //Mark DelegateMethod
    func update(with bwfEntites: [BWFEntity]) {
        //MainQueue Update UI
        DispatchQueue.main.async {
            self.entities = bwfEntites
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        print(error)
        //MainQueue UPdate UI
        DispatchQueue.main.async {
            self.entities = []
            self.tableView.isHidden = true
            self.label.isHidden = false
        }
    }
    //Mark selector
    @objc private func handleTap(sender:UIButton) {
        print(#function)
        if sender == MSButton {
            presentar?.didTappedButton(text:"men-singles")
        } else if sender == MDButton {
            presentar?.didTappedButton(text:"men-doubles")
        } else if sender == WSButton {
            presentar?.didTappedButton(text:"women-singles")
        } else if sender == WDButton {
            presentar?.didTappedButton(text:"women-doubles")
        } else {
            presentar?.didTappedButton(text:"mixed-doubles")
        }
    }
}
//Mark Extension uitableViewdelegate
extension BWFViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BWFCell
        cell.bwfEntity = entities[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 10
    }
}
