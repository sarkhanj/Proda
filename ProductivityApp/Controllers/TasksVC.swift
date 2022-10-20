//
//  TasksVC.swift
//  ProductivityApp
//
//  Created by Sarkhan Jafarli on 10/13/22.
//

import UIKit
import Combine


protocol TasksVCDelegate: AnyObject {
    func didTapMenuButton()
}

class TasksVC: UIViewController {
    
    weak var delegate: TasksVCDelegate?
    
    var tasks = [UserTask]()
    let tableView = UITableView()
    
    var observers: [AnyCancellable] = [] // Combine
    
    var addButton: UIButton = {
        let button = UIButton()
        button.tintColor = .red
        button.backgroundColor = .green
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        
        button.addTarget(TasksVC.self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Combine
        PersistenceManager.shared.loadTasks()
            .receive(on: DispatchQueue.main)
            .sink { completion in
            switch completion {
            case .finished:
                print("worked")
            case .failure(let error):
                print(error)
            }
        } receiveValue: { value in
            self.tasks = value
            self.tableView.reloadData()
        }.store(in: &observers)

        
    }
        
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.rowHeight = 40
        tableView.layer.cornerRadius = 30

        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseId)
        view.addSubview(tableView)
    }
    
    @objc func addButtonTapped() {
        
        DispatchQueue.main.async {
            let alertVC = CustomAlert(alertTitle: "Create task", message: "", buttonTitle: "Add")
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
        
        
    }
    
   
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(didTapMenuButton ))
        navigationItem.leftBarButtonItem = menuButton
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }

}

extension TasksVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseId, for: indexPath) as? TaskCell else {
            print("Error typcasting cell to TaskCell")
            return UITableViewCell()
        }

        cell.set(task: tasks[indexPath.row])

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let task = tasks[indexPath.row]
        task.done = !task.done
        print(task.done)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }


}
