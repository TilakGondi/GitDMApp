//
//  UserCell.swift
//  GitDMApp
//
//  Created by Tilakkumar Gondi on 02/08/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var avatar_Image: UIImageView!
    @IBOutlet weak var gitHandle_Label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var imageVersion = 0
    
    public static var cellId :String {
        return "UserCell"
    }
    //This will configure the cell for User and returns the cell object to be loaded
    public static func dequeue(for tableView:UITableView,for indexPath:IndexPath, with user:User) -> UserCell{
        let userCellPresenter = UserCellPresenter(with: user)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.cellId, for: indexPath) as! UserCell
        cell.configure(with: userCellPresenter)
        return cell
        
    }
    
    //To configure the cell with the presenter values.
    func configure(with presenter:UserCellPresenter)  {
        activityIndicator.startAnimating()
        self.gitHandle_Label.text = presenter.userLoginName
        
        //To make sure that the image is not repeated
        let currentImgVer = self.imageVersion
        
        
        presenter.loadProfileImage { [unowned self](imageData) in
            guard currentImgVer == self.imageVersion else{ return }
            guard let data = imageData else {
                self.activityIndicator.stopAnimating()
                return
            }
            self.avatar_Image.image = UIImage(data: data)
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatar_Image.image = nil
        imageVersion += 1
    }
}
