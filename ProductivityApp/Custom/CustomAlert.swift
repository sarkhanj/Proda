//
//  CustomAlert.swift
//  ProductivityApp
//
//  Created by Sarkhan Jafarli on 10/13/22.
//

import UIKit

class CustomAlert: UIViewController {
    
    let containerView = UIView()
    let titleLabel = CustomTitle(textAlingment: .center, fontSize: 20)
    let messageLabel = CustomBody(textAlingment: .center)
    let actionButton = CustomButton(backgroundColor: .systemBlue, title: "Ok")
    let textField = UITextField()
    var taskTitle = ""
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(alertTitle: String!, message: String!, buttonTitle: String!) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureTextField()
//        configureMessageLabel()
        
    }
    
    func configureContainerView(){
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
  
    func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureTextField() {
        containerView.addSubview(textField)
        textField.placeholder = "Enter task title"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            textField.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
    func configureActionButton(){
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func buttonTapped(){
        if let text = textField.text {
//            PersistenceManager.shared.addTask(taskTitle: text)
        }
        
        dismiss(animated: true)
    }
//
//    func configureMessageLabel(){
//        containerView.addSubview(messageLabel)
//        messageLabel.text = message ?? "Unable to complete request"
//        messageLabel.numberOfLines = 4
//
//        NSLayoutConstraint.activate([
//            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
//            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
//            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
//            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
//        ])
//    }

}

