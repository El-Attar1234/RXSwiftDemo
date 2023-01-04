//
//  MenuTabsVC.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 31/12/2022.
//

import UIKit

class MenuTabsVC: UIViewController {
    @IBOutlet private weak var tabscollectionView: UICollectionView! {
        didSet {
            tabscollectionView.register(cellType: TabCell.self)
            tabscollectionView.dataSource = self
            tabscollectionView.delegate = self
            
        }
    }
    @IBOutlet private weak var parentView: UIView!
    
    var tabsTitle = ["First", "Second", "Third"]
    var tabsVC = [SceneContainer.getVerification(),
                  SceneContainer.getHomeScreen(),
                  SceneContainer.getVerification()]
    var selectedIndex = 0 {
        didSet {
            if oldValue != selectedIndex {
                selectedIndexPath = IndexPath(item: selectedIndex, section: 0)
                tabscollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
                embedVC()
            }
        }
    }
    var selectedIndexPath = IndexPath(item: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedVC()
        tabscollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .left)
        addGestureRecognizer()
        
        // Do any additional setup after loading the view.
    }
    
    func embedVC() {
        parentView.removeAllSubViews()
        tabsVC[selectedIndex].embedVC(parentVC: self, parentView: parentView)
    }
    
    func addGestureRecognizer() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:  #selector(swipeAction))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc
    func swipeAction(sender: UISwipeGestureRecognizer){
        print(sender.direction)
        if sender.direction == .left {
            if selectedIndex < tabsVC.count - 1{
                selectedIndex += 1
            }
            
         
        } else if sender.direction == .right {
            if selectedIndex > 0 {
                selectedIndex -= 1
            }
        }
        
    }
}

extension MenuTabsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tabsTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: TabCell.self, for: indexPath)
        cell.setup(text: tabsTitle[indexPath.item])
        return cell
    }
}
extension MenuTabsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
    }
}

extension MenuTabsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / CGFloat(tabsTitle.count)
        return CGSize(width: width, height: collectionView.bounds.height)
    }
    
}

