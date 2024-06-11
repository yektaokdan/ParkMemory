//
//  PMCustomButton.swift
//  ParkMemory
//
//  Created by trc vpn on 11.06.2024.
//

import UIKit

class PMCustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(backgroundColor:UIColor, title:String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    private func configure(){
        layer.cornerRadius = 10
            setTitleColor(.white, for: .normal)
            titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .headline).pointSize)
            translatesAutoresizingMaskIntoConstraints = false
            
            
            // Gölge ekleme (isteğe bağlı)
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.3
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowRadius = 4
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
