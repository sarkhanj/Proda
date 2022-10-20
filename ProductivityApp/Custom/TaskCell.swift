//
//  TaskCellTableViewCell.swift
//  ProductivityApp
//
//  Created by Sarkhan Jafarli on 10/13/22.
//

import UIKit

class TaskCell: UITableViewCell {

    static let reuseId = "TaskCell"
//
    let taskTitle = CustomTitle(textAlingment: .left, fontSize: 17)
    var attributeString: NSMutableAttributedString?
    
//    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    
    func set(task: UserTask) {
        if task.done {
            attributeString = NSMutableAttributedString(string: task.taskTitle ?? "")
            attributeString!.addAttribute(.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString!.length))
            attributeString!.addAttribute(.foregroundColor, value: UIColor.systemGray, range: NSRange(location: 0, length: attributeString!.length))
            
        }else {
            attributeString = NSMutableAttributedString(string: task.taskTitle ?? "")
            attributeString!.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSRange(location: 0, length: attributeString!.length))
            attributeString!.addAttribute(.foregroundColor, value: UIColor.label, range: NSRange(location: 0, length: attributeString!.length))
        }
        taskTitle.attributedText = attributeString
        taskTitle.numberOfLines = 0
        
        
    }
    
    private func configure(){
        contentView.addSubview(taskTitle)
        
//        clipsToBounds = true
        
//        backgroundColor = .systemGray6
//        layer.cornerRadius = 10
        
//        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 22
        
        NSLayoutConstraint.activate([
            taskTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            taskTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            taskTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            taskTitle.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }

}

