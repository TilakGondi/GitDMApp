//
//  GitDMViewController.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class GitDMViewController: UIViewController {
    @IBOutlet weak var messagesTable: UITableView!
    @IBOutlet weak var messageInputView: UIView!
    @IBOutlet weak var messageTextInput: UITextView!
    @IBOutlet weak var messageInputBottomSpace: NSLayoutConstraint!
    
    fileprivate var presenter: MessagesListPresenter!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.adremoveObserversForKeyboardDisplayStates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles  = false
        self.title = presenter.account_handler
        self.messageTextInput.layer.cornerRadius = 20
        self.addObserversForKeyboardDisplayStates()
        presenter.loadMessagesFromDB {
            self.messagesTable.reloadData()
        }
    }
    
    @IBAction func sendAction(_ sender: Any) {
        presenter.sendMessage(messageStr: self.messageTextInput.text) {[unowned self] in
            self.insertMessageAndScrollTable(With: .right)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
                self.presenter.echoResponseFor(Message: self.messageTextInput.text, finished: {
                    self.insertMessageAndScrollTable(With: .left)
                    self.messageTextInput.text = ""
                })
            }
        }
    }
    
    //To insert cell for message into the tableview
    func insertMessageAndScrollTable(With animation:UITableView.RowAnimation) {
        self.messagesTable.insertRows(at: [self.presenter.indexPathForlastMessage], with: animation)
        self.messagesTable.scrollToRow(at: self.presenter.indexPathForlastMessage, at: .bottom, animated: true)
    }
   
    
    func configure(with presenter:MessagesListPresenter) {
        self.presenter = presenter
    }
    
}

extension GitDMViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.userMessagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = presenter.userMessagesArray[indexPath.row]
        if message.msgTag == .Sent {
            let cell = SentMessageCell.dequeue(for: tableView, for: indexPath, with: message)
            return cell
        }else {
            let cell = RecievedMessageCell.dequeue(for: tableView, for: indexPath, with: message)
            return cell
        }
    }
    
}

//To handle the frame changes of the bottom input text view when keyboard is shown and hidden.
extension GitDMViewController {
    
    func addObserversForKeyboardDisplayStates() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func adremoveObserversForKeyboardDisplayStates() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func keyBoardShown(notification:Notification){
        if let keyBoardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.5) {[unowned self] in
                    self.messageInputBottomSpace.constant = -(keyBoardSize.height)
            }
        }
    }
    
    @objc fileprivate func keyBoardHidden(notification:Notification){

        UIView.animate(withDuration: 0.5) {[unowned self] in
            self.messageInputBottomSpace.constant = 0
        }
    }
}


