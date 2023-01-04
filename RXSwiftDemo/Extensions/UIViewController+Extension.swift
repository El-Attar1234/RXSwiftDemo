//
//  UIViewController+Extension.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 31/12/2022.
//

import UIKit

// MARK: - Containment
extension UIViewController {
    
    func embedVC(parentVC: UIViewController, parentView: UIView) {
        parentView.removeAllSubViews()
        parentVC.addChild(self)
        self.view.frame = parentView.fitWithFrame()
        parentView.addSubview(self.view)
        self.didMove(toParent: parentVC)
    }
    
    func removeEmbededVC( parentView: UIView) {
        willMove(toParent: nil)
        parentView.removeAllSubViews()
        removeFromParent()
    }
}

// MARK: - Add VC on viw as childs
extension UIView {
    func removeAllSubViews() {
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
    }
    func fitWithFrame() -> CGRect {
        return CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
}
