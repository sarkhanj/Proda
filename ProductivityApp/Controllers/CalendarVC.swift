//
//  CalendarVC.swift
//  ProductivityApp
//
//  Created by Sarkhan Jafarli on 10/13/22.
//

import UIKit
import FSCalendar
import Combine

class CalendarVC: UIViewController, FSCalendarDelegate {

    var calendar = FSCalendar()
    private var tasks = [UserTask]()
    var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    var observers: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        PersistenceManager.shared.loadTasks()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Calendar page tasks loaded")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { value in
                self.tasks = value
                print(value)
                self.tableView.reloadData()
            }.store(in: &observers)

        configureUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(calendar)
        calendar.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: (view.frame.size.width - 10), height: (view.frame.size.width - 10))
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: calendar.frame.size.height + 60, width: view.frame.size.width, height: view.frame.size.height - calendar.frame.size.height - view.safeAreaInsets.bottom)
        tableView.rowHeight = 40
        tableView.backgroundColor = .systemBlue
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 30),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            tableView.heightAnchor.constraint(equalToConstant: 100)
//        ])
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        let string = formatter.string(from: date)
        print(string)
        
       
        
        // here will be the functions to show the tasks for that date
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground

    }
}


extension CalendarVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row].taskTitle
        return cell
    }
}
