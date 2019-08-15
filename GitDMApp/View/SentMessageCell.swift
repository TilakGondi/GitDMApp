//
//  SentMessageCell.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class SentMessageCell: UITableViewCell {
    @IBOutlet weak var message_Label: UILabel!
    
    public static var cellId :String {
        return "SentCell"
    }
    //This will configure the cell for Sent message and returns the cell object to be loaded
    public static func dequeue(for tableView:UITableView,for indexPath:IndexPath, with message:Message) -> SentMessageCell{
        let sendCellPresenter = SentCellPresenter(with: message)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SentMessageCell.cellId, for: indexPath) as! SentMessageCell
        cell.configure(with: sendCellPresenter)
        return cell
        
    }
    //To configure the cell with the presenter values.
    func configure(with presenter:SentCellPresenter)  {
        self.message_Label.text = presenter.messageTxt
    }

}
