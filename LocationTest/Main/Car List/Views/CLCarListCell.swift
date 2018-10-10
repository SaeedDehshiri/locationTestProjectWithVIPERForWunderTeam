//
//  CLCarListCell.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 10/4/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import UIKit

class CLCarListCell: UITableViewCell {
    
    let container: UIView = UIView()
    let visualEffectView: APCustomBlurView = APCustomBlurView(withRadius: 9)
    
    let backgroundImageView: UIImageView = UIImageView()
    
    let titleLabel: UILabel = UILabel()
    
    let interiorLabel: UILabel = UILabel()
    let interiorStatus: UIImageView = UIImageView()
    let exteriorLabel: UILabel = UILabel()
    let exteriorStatus: UIImageView = UIImageView()
    
    let fuelContainer: UIView = UIView()
    let fuelOuter: UIImageView = UIImageView(image: UIImage(named: "fuel-outer"))
    let fuelInner: UIImageView = UIImageView(image: UIImage(named: "fuel-inner"))
    
    var fuel: Int = 0
    
    init(reuseIdentifier: String? = nil) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.setShadow(5, alpha: 0.2)
        self.backgroundColor = UIColor.clear
        self.layer.masksToBounds = false
        
        container.clipsToBounds = true
        container.layer.masksToBounds = true
        container.layer.cornerRadius = Layout.carListCellCornerRadius
        
        backgroundImageView.contentMode = .scaleAspectFill
        
        visualEffectView.backgroundColor = Colors.cellEffect
        
        titleLabel.font = UIFont.systemFont(ofSize: Layout.carListCellTitle, weight: .bold)
        titleLabel.textColor = Colors.cellText
        
        interiorLabel.font = UIFont.systemFont(ofSize: Layout.carListCellSubtitle, weight: .regular)
        interiorLabel.textColor = Colors.cellText
        interiorLabel.text = String.localized("CL.Car.Interior")
        
        interiorStatus.contentMode = .scaleAspectFit
        
        exteriorLabel.font = interiorLabel.font
        exteriorLabel.textColor = Colors.cellText
        exteriorLabel.text = String.localized("CL.Car.Exterior")
        
        exteriorStatus.contentMode = .scaleAspectFit
        
        fuelOuter.contentMode = .scaleAspectFit
        fuelInner.contentMode = .scaleAspectFit
        
        self.selectionStyle = .none
        
        self.addSubview(container)
        container.addSubview(backgroundImageView)
        container.addSubview(visualEffectView)
        container.addSubview(titleLabel)
        container.addSubview(interiorLabel)
        container.addSubview(interiorStatus)
        container.addSubview(exteriorLabel)
        container.addSubview(exteriorStatus)
        container.addSubview(fuelContainer)
        fuelContainer.addSubview(fuelOuter)
        fuelContainer.addSubview(fuelInner)
        
    }
    convenience required init?(coder aDecoder: NSCoder) {self.init(reuseIdentifier: nil)}
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        container.frame.size = CGSize(width: self.frame.size.width - Layout.carListCellInnerDistance * 2,
                                      height: self.frame.size.height - Layout.carListCellInnerDistance * 2)
        container.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        
        backgroundImageView.frame = container.bounds
        
        visualEffectView.transform = .identity
        visualEffectView.frame.size = CGSize(width: container.frame.size.height * 2,
                                             height: self.frame.size.height * 3)
        visualEffectView.center = CGPoint(x: -container.frame.size.height * tan(Layout.carListCellCoverAngle) / 2,
                                          y: container.frame.size.height / 2)
        visualEffectView.transform = .init(rotationAngle: Layout.carListCellCoverAngle)
        
        titleLabel.sizeToFit()
        exteriorLabel.sizeToFit()
        interiorLabel.sizeToFit()
        
        titleLabel.frame.origin = CGPoint(x: Layout.carListCellInnerDistance,
                                          y: Layout.carListCellInnerDistance)
        interiorLabel.frame.origin = CGPoint(x: Layout.carListCellInnerDistance,
                                             y: titleLabel.frame.origin.y
                                                + titleLabel.frame.size.height
                                                + Layout.carListCellInnerDistance * 2)
        exteriorLabel.frame.origin = CGPoint(x: Layout.carListCellInnerDistance,
                                             y: interiorLabel.frame.origin.y
                                                + interiorLabel.frame.size.height
                                                + Layout.carListCellInnerDistance)
        interiorStatus.frame = CGRect(x: interiorLabel.frame.origin.x + interiorLabel.frame.size.width + Layout.carListCellInnerDistance,
                                      y: interiorLabel.frame.origin.y,
                                      width: interiorLabel.frame.size.height,
                                      height: interiorLabel.frame.size.height)
        exteriorStatus.frame = CGRect(x: exteriorLabel.frame.origin.x + exteriorLabel.frame.size.width + Layout.carListCellInnerDistance,
                                      y: exteriorLabel.frame.origin.y,
                                      width: exteriorLabel.frame.size.height,
                                      height: exteriorLabel.frame.size.height)
        
        fuelContainer.frame.size = CGSize(width: Layout.carListCellFuelMeterWidth,
                                          height: Layout.carListCellFuelMeterWidth * 1013 / 718)
        fuelContainer.frame.origin = CGPoint(x: 0,
                                             y: container.frame.size.height
                                                - fuelContainer.frame.size.height)
        
        fuelInner.transform = .identity
        fuelOuter.frame = fuelContainer.bounds
        let ratio: CGFloat = Layout.carListCellFuelMeterWidth / 718
        fuelInner.frame = CGRect(x: ratio * 117.00, y: ratio * 461,
                                 width: ratio * 261, height: ratio * 298)
        fuelInner.layer.anchorPoint = CGPoint(x: 68 / 261.0, y: 68 / 298.0)
        fuelInner.transform = .init(rotationAngle: -0.77 * CGFloat.pi * CGFloat(fuel) / 100)
        
    }
    
    func load(car: CMCar) {
        titleLabel.text = "\(car.name)"
        interiorStatus.image = UIImage(named: "icon-quality-\(car.interior == "GOOD" ? "good" : "bad")")
        exteriorStatus.image = UIImage(named: "icon-quality-\(car.exterior == "GOOD" ? "good" : "bad")")
        backgroundImageView.image = UIImage(named: "car-\(car.id % 3 + 1)")
        fuel = car.fuel
        layoutSubviews()
        
    }
    
}
