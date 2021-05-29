//
//  ViewController.swift
//  CustomLoginPage
//
//  Created by Jaldeep Patel on 2021-05-04.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNavigationBarGradient()
        
    }
    
    
    
    //view.setGradientBackground(colorOne: Theme.gradientColor1, colorTwo: Theme.gradientColor2)
    //
    //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    //self.navigationController?.navigationBar.shadowImage = UIImage()
    //

    //func setGradientBackground(colorOne: UIColor, colorTwo: UIColor){
    //
    //    let gradientLayer = CAGradientLayer()
    //    gradientLayer.frame = bounds
    //    gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
    //
    //    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    //    gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
    //
    //    layer.insertSublayer(gradientLayer, at: 0)
    //
    //}
    
    func getNavigationBarGradient() {
        
        if let navigationBar = self.navigationController?.navigationBar {
            
            let gradient = CAGradientLayer()
            
            var bounds = navigationBar.bounds
            
            bounds.size.height += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            
            gradient.frame = bounds
            
            gradient.colors = [UIColor.init(red: 78/255, green: 114/255, blue: 186/255, alpha: 1).cgColor, UIColor.init(red: 62/255, green:178/255, blue: 174/255, alpha: 1).cgColor]
            
            gradient.startPoint = CGPoint(x: 0, y: 0)
            
            gradient.endPoint = CGPoint(x: 1, y: 0)
            
            if let image = getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
                navigationBar.tintColor = UIColor.white
            }
        }
    }
    
    
    func getImageFrom(gradientLayer: CAGradientLayer) -> UIImage? {
        
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
}






