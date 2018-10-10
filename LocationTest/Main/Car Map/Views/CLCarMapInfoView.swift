//
//  CLCarMapInfoView.swift
//  LocationTest
//
//  Created by Saeed Dehshiri on 9/30/18.
//  Copyright © 2018 Saeed Dehshiri. All rights reserved.
//

import UIKit

class CLCarMapInfoView: UIView {
    
    let headerImageView: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    
    let interiorLabel: UILabel = UILabel()
    let exteriorLabel: UILabel = UILabel()
    
    let interiorStatus: UIImageView = UIImageView()
    let exteriorStatus: UIImageView = UIImageView()
    
    let fuelContainer: UIView = UIView()
    let fuelOuter: UIImageView = UIImageView(image: UIImage(named: "fuel-outer"))
    let fuelInner: UIImageView = UIImageView(image: UIImage(named: "fuel-inner"))
    
    let addressLabel: UILabel = UILabel()
    
    let engineTypeLabel: UILabel = UILabel()
    
    var fuel: Int = 0
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        nameLabel.font = UIFont.systemFont(ofSize: Layout.carMapTitle, weight: .bold)
        
        headerImageView.contentMode = .scaleAspectFill
        headerImageView.layer.mask = CAShapeLayer()
        
        exteriorLabel.font = UIFont.systemFont(ofSize: Layout.carMapSubtitle, weight: .bold)
        exteriorLabel.text = String.localized("CL.Car.Exterior")
        exteriorLabel.sizeToFit()
        exteriorStatus.contentMode = .scaleAspectFit
        
        interiorLabel.font = exteriorLabel.font
        interiorLabel.text = String.localized("CL.Car.Interior")
        interiorLabel.sizeToFit()
        interiorLabel.contentMode = .scaleAspectFit
        
        addressLabel.numberOfLines = 0
        addressLabel.font = UIFont.systemFont(ofSize: Layout.carMapSubtitle, weight: .regular)
        
        fuelInner.contentMode = .scaleAspectFit
        fuelOuter.contentMode = .scaleAspectFit
        
        self.layer.cornerRadius = Layout.carMapCornerRadius
        self.backgroundColor = Colors.mapDetailBackground
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.setShadow(5, alpha: 0.1)
        
        self.addSubview(headerImageView)
        self.addSubview(nameLabel)
        self.addSubview(interiorLabel)
        self.addSubview(interiorStatus)
        self.addSubview(exteriorLabel)
        self.addSubview(exteriorStatus)
        self.addSubview(addressLabel)
        self.addSubview(engineTypeLabel)
        fuelContainer.addSubview(fuelOuter)
        fuelContainer.addSubview(fuelInner)
        self.addSubview(fuelContainer)
        
    }
    convenience required init?(coder aDecoder: NSCoder) { self.init() }
    
    func load(car: CMCar) {
        
        let fontBoldSub: UIFont = UIFont.systemFont(ofSize: Layout.carMapSubtitle, weight: .bold)
        let fontRegularSub: UIFont = UIFont.systemFont(ofSize: Layout.carMapSubtitle, weight: .regular)
        
        nameLabel.text = car.name
        nameLabel.sizeToFit()
        
        interiorStatus.image = UIImage(named: "icon-quality-\(car.interior == "GOOD" ? "good" : "bad")")
        exteriorStatus.image = UIImage(named: "icon-quality-\(car.exterior == "GOOD" ? "good" : "bad")")
        headerImageView.image = UIImage(named: "car-\(car.id % 3 + 1)")
        
        let engineLabelText: NSMutableAttributedString = NSMutableAttributedString()
        engineLabelText.append(NSAttributedString.init(string: String.localized("CL.Car.EngineType") + ": ", attributes: [
                .font: fontBoldSub,
                .foregroundColor: Colors.mapDetailText
            ]))
        engineLabelText.append(NSAttributedString.init(string: String.localized("CL.Car.EngineType") + ": ", attributes: [
                .font: fontRegularSub,
                .foregroundColor: Colors.mapDetailText
            ]))
        engineTypeLabel.attributedText = engineLabelText
        engineTypeLabel.sizeToFit()
        
        addressLabel.text = car.address
            
        fuel = car.fuel
        
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        
        headerImageView.frame = CGRect(origin: .zero, size: Layout.carMapDetailViewHeader)
        let shapeLayer: CAShapeLayer = headerImageView.layer.mask as! CAShapeLayer
        shapeLayer.path = UIBezierPath.init(roundedRect: headerImageView.bounds,
                                            byRoundingCorners: [.topLeft, .topRight],
                                            cornerRadii: CGSize(width: Layout.carMapCornerRadius,
                                                                height: Layout.carMapCornerRadius)).cgPath
        
        fuelContainer.frame.size = CGSize(width: Layout.carMapFuelMeterWidth,
                                          height: Layout.carMapFuelMeterWidth * 1013 / 718)
        fuelContainer.frame.origin = CGPoint(x: 0,
                                             y: Layout.carMapDetailViewHeader.height
                                                - fuelContainer.frame.size.height)
        
        fuelInner.transform = .identity
        fuelOuter.frame = fuelContainer.bounds
        let ratio: CGFloat = Layout.carMapFuelMeterWidth / 718
        fuelInner.frame = CGRect(x: ratio * 117.00, y: ratio * 461,
                                 width: ratio * 261, height: ratio * 298)
        fuelInner.layer.anchorPoint = CGPoint(x: 68 / 261.0, y: 68 / 298.0)
        fuelInner.transform = .init(rotationAngle: -0.77 * CGFloat.pi * CGFloat(fuel) / 100)
        
        nameLabel.frame.origin = CGPoint(x: Layout.carMapInnerDistance,
                                         y: Layout.carMapInnerDistance
                                            + Layout.carMapDetailViewHeader.height)
        
        let size: CGSize = addressLabel.sizeThatFits(
            CGSize(width: Layout.carMapDetailViewHeader.width - 2 * Layout.carMapInnerDistance,
                   height: CGFloat.greatestFiniteMagnitude))
        addressLabel.frame.size = size
        addressLabel.frame.origin = CGPoint(x: Layout.carMapInnerDistance,
                                            y: Layout.carMapInnerDistance
                                                + nameLabel.frame.origin.y
                                                + nameLabel.frame.size.height)
        
        engineTypeLabel.frame.origin = CGPoint(x: Layout.carMapInnerDistance,
                                               y: Layout.carMapInnerDistance
                                                + addressLabel.frame.origin.y
                                                + addressLabel.frame.size.height)
        
        let y: CGFloat = engineTypeLabel.frame.origin.y
            + engineTypeLabel.frame.size.height
            + Layout.carMapInnerDistance
        interiorLabel.frame.origin = CGPoint(x: Layout.carMapInnerDistance, y: y)
        interiorStatus.frame = CGRect(x: interiorLabel.frame.origin.x + interiorLabel.frame.size.width + Layout.carListCellInnerDistance,
                                      y: interiorLabel.frame.origin.y,
                                      width: interiorLabel.frame.size.height,
                                      height: interiorLabel.frame.size.height)
        
        let x: CGFloat = self.frame.size.width
            - 2 * Layout.carMapInnerDistance
            - exteriorLabel.frame.size.height
            - exteriorLabel.frame.size.width
        exteriorLabel.frame.origin = CGPoint(x: x, y: y)
        exteriorStatus.frame = CGRect(x: exteriorLabel.frame.origin.x + exteriorLabel.frame.size.width + Layout.carListCellInnerDistance,
                                      y: exteriorLabel.frame.origin.y,
                                      width: exteriorLabel.frame.size.height,
                                      height: exteriorLabel.frame.size.height)
        
    }
    
    func adjustSize() {
        layoutSubviews()
        let size: CGSize = CGSize(width: Layout.carMapDetailViewHeader.width,
                                  height: interiorLabel.frame.size.height
                                    + interiorLabel.frame.origin.y
                                    + Layout.carMapInnerDistance)
        self.frame.size = size
    }
    
    /*func setup(with car: CMCar) {
        
    }*/
    
}
