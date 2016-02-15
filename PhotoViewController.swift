//
//  PhotoViewController.swift
//  Tutorial
//
//  Created by student on 15.02.2016.
//  Copyright © 2016 PWr. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    var index : Int?
    var photo : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoView.image=self.photo
    }   

}
