//
//  HomeVC.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 26/12/2022.
//

import UIKit
import TwitterProfile

class HomeVC: UIViewController {
    @IBOutlet weak var myCollectionView: UICollectionView! {
        didSet {
            print("Life DidSet")
            myCollectionView.register(cellType: DemoCell.self)
            myCollectionView.registerHeader(cellType: HeaderView.self)
            myCollectionView.dataSource = self
        }
    }
 //   weak var pageDelegate: BottomPageDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("Life init(nibName nibNameOrNil")
    }
     init() {
         super.init(nibName: nil, bundle: nil)
         print("Life custom init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  D().eat()
        print("Life DidLoad")
       myCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Life viewWillAppear")
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("Life viewWillLayoutSubviews")
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Life viewDidLayoutSubviews")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("Life viewDidAppear")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            if (self.navigationController?.viewControllers ?? []).count == 1 {
             //   let vc = HomeVC()
               // self.navigationController?.pushViewController(vc, animated: true)
            }
           
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Life viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Life viewDidDisappear")
        
    }
//    override func loadView() {
//        super.loadView()
//        print("Life loadView")
//    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout{ [weak self] index, environmeent -> NSCollectionLayoutSection? in
            self?.createSetionFor(index: index, environment: environmeent)
        }
        return layout
    }
    
    func createSetionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch index {
        case 0:
            return  createFirstSectionLayout()
        case 1:
            return  createSecondSectionLayout()
        case 2:
            return  createThirdSectionLayout()
        default:
            return  createFirstSectionLayout()
        }
 
    }
    
    func createFirstSectionLayout() -> NSCollectionLayoutSection{
        let inset: CGFloat = 2.5
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                     leading: inset,
                                                     bottom: inset,
                                                     trailing: inset)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: "header",alignment: .bottom)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    func createSecondSectionLayout() -> NSCollectionLayoutSection{
        let inset: CGFloat = 2.5
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                     leading: inset,
                                                     bottom: inset,
                                                     trailing: inset)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45),
                                               heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: "header",alignment: .bottom)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    func createThirdSectionLayout() -> NSCollectionLayoutSection{
        let inset: CGFloat = 2.5
        // items
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(0.5))
        let largeitemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                   heightDimension: .fractionalHeight(1))
        
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                     leading: inset,
                                                     bottom: inset,
                                                     trailing: inset)
        
        let largeItem = NSCollectionLayoutItem(layoutSize: largeitemSize)
        largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset,
                                                     leading: inset,
                                                     bottom: inset,
                                                     trailing: inset)
        
        // group
        let smallGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                               heightDimension: .fractionalHeight(1))
        let smallGroup = NSCollectionLayoutGroup.vertical(layoutSize: smallGroupSize, subitems: [smallItem])
        
        let largeGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: largeGroupSize, subitems: [largeItem, smallGroup, smallGroup])
        
        // header
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: "header",alignment: .bottom)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}


extension HomeVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: DemoCell.self, for: indexPath)
        cell.setup(title: "Title section \(indexPath.section) item \(indexPath.item)")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableHeaderCell(with: HeaderView.self, for: indexPath, kind: "header")
        
        return header
    }
    
}

extension HomeVC: PagerAwareProtocol{
    var pageDelegate: TwitterProfile.BottomPageDelegate? {
        get {
            nil
        }
        set(newValue) {
            
        }
    }
    
    var currentViewController: UIViewController? {
        nil
    }
    
    var pagerTabHeight: CGFloat? {
        10
    }
    
    
}
