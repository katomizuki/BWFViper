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
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
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
    
    //Mark LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //Mark setupMethod
    private func setupTableView() {
        view.addSubview(tableView)
        view.addSubview(label)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .white
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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
            self.label.text = error
            self.tableView.isHidden = true
            self.label.isHidden = false
        }
    }
    
    
}

extension BWFViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = entities[indexPath.row].name
        return cell
    }
    
    
}
