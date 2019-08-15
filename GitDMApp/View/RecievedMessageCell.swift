//
//  RecievedMessageCell.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class RecievedMessageCell: UITableViewCell {
    @IBOutlet weak var message_Label: UILabel!
    
    public static var cellId :String {
        return "RecievedCell"
    }
    
    //This will configure the cell for Recieved message and returns the cell object to be loaded
    public static func dequeue(for tableView:UITableView,for indexPath:IndexPath, with message:Message) -> RecievedMessageCell{
        let recvCellPresenter = RecievedCellPresenter(with: message)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecievedMessageCell.cellId, for: indexPath) as! RecievedMessageCell
        cell.configure(with: recvCellPresenter)
        return cell
    }
    
    //To configure the cell with the presenter values.
    func configure(with presenter:RecievedCellPresenter)  {
        self.message_Label.text = presenter.messageTxt
    }

}
