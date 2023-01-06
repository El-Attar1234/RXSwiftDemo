//
//  UICollectionView+Extension.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 26/12/2022.
//

import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
  
}

extension NSObject: ClassNameProtocol {}

extension UICollectionView{
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func registerHeader<T: UICollectionReusableView>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: "header", withReuseIdentifier: className)
    }
    func registerFooter<T: UICollectionReusableView>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: "footer", withReuseIdentifier: className)
    }
    
 
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                      for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderCell<T: UICollectionReusableView>(with type: T.Type,
                                                                for indexPath: IndexPath ,kind :String) -> T {
        
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as! T
    }
    
    
    func dequeueReusableFooterCell<T: UICollectionReusableView>(with type: T.Type,
                                                      for indexPath: IndexPath) -> T {
        
        let footer = dequeueReusableSupplementaryView(ofKind: "footer", withReuseIdentifier: type.className, for: indexPath)
        print(footer.self)
            let f = footer as! T
        
        return f
    }

}

public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
  
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T  else {
            fatalError("Can't dequeue cell")
        }
        return cell
    }
    func dequeueReusableHeader<T: UITableViewCell>(with type: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className) as? T  else {
            fatalError("Can't dequeue cell")
        }
        return cell
    }
    
}
