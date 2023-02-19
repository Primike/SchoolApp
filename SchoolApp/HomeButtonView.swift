//
//  HomeButtonView.swift
//  SchoolApp
//
//  Created by Prince Avecillas on 2/18/23.
//

//import Foundation
//import UIKit
//
//class HomeButtonView: UIButton {
//    
//    var title: String
//    var viewWidth: CGFloat
//    var imageName: String
//    
//    init(frame: CGRect, title: String, viewWidth: CGFloat, imageName: String) {
//        self.title = title
//        self.viewWidth = viewWidth
//        self.imageName = imageName
//        
//        super.init(frame: frame)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupButton() {
//        var config = UIButton.Configuration.filled()
//        config.titleAlignment = .center
//        config.baseBackgroundColor = .black
//        config.baseForegroundColor = .white
//        config.cornerStyle = .capsule
//        config.imagePlacement = .leading
//        config.imagePadding = 10.0
//
//        configuration = config
//        configuration?.title = title
//        configuration?.attributedTitle?.font = UIFont(name:"HelveticaNeue", size: CGFloat(Int(viewWidth))/17)
//        configuration?.image = UIImage(systemName: imageName,
//                                       withConfiguration: UIImage.SymbolConfiguration(font: UIFont(name:"HelveticaNeue", size: CGFloat(Int(viewWidth))/18)!))
//    }
//}
