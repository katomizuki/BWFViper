
import Foundation
import UIKit

//ViewController
//Protocol

protocol AnyView {
    var presentar:AnyPresenter? { get set }
    func update(with bwfEntites: [BWFEntity])
    func update(with error: String)
}

class BWFViewController:UIViewController,AnyView {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
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
    
    func update(with bwfEntites: [BWFEntity]) {
        DispatchQueue.main.async {
            self.entities = bwfEntites
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        print(error)
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
