//
// Copyright (c) 2017 iGenius Srl
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

enum CheckState: Int {
    case uncheck = 0
    case check = 1
    case topLeftToBottomRight = 2
    case leftToRight = 3
    case topRightToBottomLeft = 5
    
    func startPoint() -> CGPoint {
        switch self {
        case .check:
            return CGPoint(x: 0.5, y: 0)
        case .topLeftToBottomRight:
            return CGPoint(x: 0, y: 0)
        case .leftToRight:
            return CGPoint(x: 0, y: 0.5)
        case .topRightToBottomLeft:
            return CGPoint(x: 1, y: 0)
        default:
            return CGPoint(x: 0.5, y: 0)
        }
    }
    
    
    
    func endPoint() -> CGPoint {
        switch self {
        case .check:
            return CGPoint(x: 0.5, y: 1)
        case .topLeftToBottomRight:
            return CGPoint(x: 1, y: 1)
        case .leftToRight:
            return CGPoint(x: 1, y: 0.5)
        case .topRightToBottomLeft:
            return CGPoint(x: 0, y: 1)
        default:
            return CGPoint(x: 0.5, y: 1)
        }
    }
    
    func nextState() -> CheckState {
        switch self {
        case .check:
            return .topLeftToBottomRight
        case .topLeftToBottomRight:
            return .leftToRight
        case .leftToRight:
            return .topRightToBottomLeft
        case .topRightToBottomLeft:
            return .check
        default:
            return .check
        }
    }
}

class CheckView: UIView {
    var state: CheckState = .uncheck {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var colorCount = 1
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if colorCount == 1 && state != .uncheck {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: rect.width * 0.25, y: rect.height * 0.25))
            path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.lineCapStyle = .round
            path.lineJoinStyle = .round
            path.apply(CGAffineTransform.init(translationX: -5, y: 15))
            path.lineWidth = 5
            UIColor.init(white: 0, alpha: 0.3).set()
            path.stroke()
            path.lineWidth = 3
            UIColor.white.set()
            path.stroke()
            return
        }
                
        switch state {
        case .uncheck:
            return
        case .check:
            let path = UIBezierPath()
            path.lineCapStyle = .round
            path.lineJoinStyle = .round
            path.move(to: CGPoint(x: rect.width * 0.5 - 5, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5 - 5))
            
            path.move(to: CGPoint(x: rect.width * 0.5 - 5 - 5, y: rect.height * 0.5 - 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 - 5, y: rect.height * 0.5 - 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 - 5, y: rect.height * 0.5 - 5 - 5))
            
            path.move(to: CGPoint(x: rect.width * 0.5 - 5 + 5, y: rect.height * 0.5 + 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 + 5, y: rect.height * 0.5 + 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 + 5, y: rect.height * 0.5 - 5 + 5))
            
            path.apply(CGAffineTransform(translationX: -rect.width * 0.5, y: -rect.height * 0.5))
            path.apply(CGAffineTransform(rotationAngle: .pi / 4.0))
            path.apply(CGAffineTransform(translationX: rect.width * 0.5, y: rect.height * 0.5))
            path.lineWidth = 5
            UIColor.init(white: 0, alpha: 0.3).set()
            path.stroke()
            path.lineWidth = 3
            UIColor.white.set()
            path.stroke()
        case .topLeftToBottomRight:
            let path = UIBezierPath()
            path.lineCapStyle = .round
            path.lineJoinStyle = .round
            path.move(to: CGPoint(x: rect.width * 0.5 - 5, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5 - 5))
            
            path.move(to: CGPoint(x: rect.width * 0.5 - 5 - 5, y: rect.height * 0.5 - 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 - 5, y: rect.height * 0.5 - 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 - 5, y: rect.height * 0.5 - 5 - 5))
            
            path.move(to: CGPoint(x: rect.width * 0.5 - 5 + 5, y: rect.height * 0.5 + 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 + 5, y: rect.height * 0.5 + 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 + 5, y: rect.height * 0.5 - 5 + 5))
            
            path.lineWidth = 5
            UIColor.init(white: 0, alpha: 0.3).set()
            path.stroke()
            path.lineWidth = 3
            UIColor.white.set()
            path.stroke()
        case .leftToRight:
            let path = UIBezierPath()
            path.lineCapStyle = .round
            path.lineJoinStyle = .round
            path.move(to: CGPoint(x: rect.width * 0.5 - 5, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5 - 5))
            
            path.move(to: CGPoint(x: rect.width * 0.5 - 5 - 5, y: rect.height * 0.5 - 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 - 5, y: rect.height * 0.5 - 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 - 5, y: rect.height * 0.5 - 5 - 5))
            
            path.move(to: CGPoint(x: rect.width * 0.5 - 5 + 5, y: rect.height * 0.5 + 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 + 5, y: rect.height * 0.5 + 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 + 5, y: rect.height * 0.5 - 5 + 5))
            
            path.apply(CGAffineTransform(translationX: -rect.width * 0.5, y: -rect.height * 0.5))
            path.apply(CGAffineTransform(rotationAngle: .pi / 4.0 * -1 ))
            path.apply(CGAffineTransform(translationX: rect.width * 0.5, y: rect.height * 0.5))
            path.lineWidth = 5
            UIColor.init(white: 0, alpha: 0.3).set()
            path.stroke()
            path.lineWidth = 3
            UIColor.white.set()
            path.stroke()
        case .topRightToBottomLeft:
            let path = UIBezierPath()
            path.lineCapStyle = .round
            path.lineJoinStyle = .round
            path.move(to: CGPoint(x: rect.width * 0.5 - 5, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5))
            path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.5 - 5))
            
            path.move(to: CGPoint(x: rect.width * 0.5 - 5 - 5, y: rect.height * 0.5 - 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 - 5, y: rect.height * 0.5 - 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 - 5, y: rect.height * 0.5 - 5 - 5))
            
            path.move(to: CGPoint(x: rect.width * 0.5 - 5 + 5, y: rect.height * 0.5 + 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 + 5, y: rect.height * 0.5 + 5))
            path.addLine(to: CGPoint(x: rect.width * 0.5 + 5, y: rect.height * 0.5 - 5 + 5))
            
            path.apply(CGAffineTransform(translationX: -rect.width * 0.5, y: -rect.height * 0.5))
            path.apply(CGAffineTransform(rotationAngle: .pi / 2.0))
            path.apply(CGAffineTransform(translationX: rect.width * 0.5, y: rect.height * 0.5))
            path.lineWidth = 5
            UIColor.init(white: 0, alpha: 0.3).set()
            path.stroke()
            path.lineWidth = 3
            UIColor.white.set()
            path.stroke()
        }
    }
}

class ColorPickerCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    /// The reuse identifier used to register the UICollectionViewCell to the UICollectionView
    static let cellIdentifier = String(describing: ColorPickerCell.self)
    /// The checkbox use to show the tip on the cell
    var checkbox = CheckView()
    
    lazy var gradientLayer: CAGradientLayer = {
        var l = CAGradientLayer()
        l.frame = self.bounds
        self.layer.insertSublayer(l, at: 0)
        return l
    }()
    
    var colors: [UIColor] = [] {
        didSet {
            if colors.count == 1 {
                gradientLayer.colors = nil
                gradientLayer.backgroundColor = colors.first?.cgColor
            } else {
                gradientLayer.colors = colors.map({$0.cgColor})
            }
            checkbox.colorCount = colors.count
        }
    }
    
    //MARK: - Initializer
    
    init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    // MARK: - Private methods
    
    fileprivate func commonInit() {
        
        // Setup of checkbox
        checkbox.isUserInteractionEnabled = false
        checkbox.backgroundColor = .clear
        
        self.addSubview(checkbox)
        
        // Setup constraints to checkbox
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraint(NSLayoutConstraint(item: checkbox, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: checkbox, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: checkbox, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: checkbox, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
    }
    
}
