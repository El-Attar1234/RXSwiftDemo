//
//  StrectchyHeaderVC.swift
//  RXSwiftDemo
//
//  Created by Ibtikar on 04/01/2023.
//

import UIKit
import GSKStretchyHeaderView
import ParallaxHeader
import TwitterProfile
class StrectchyHeaderVC: UIViewController, TPDataSource, TPProgressDelegate{
    var headerVC: VerificationVC?
    func headerViewController() -> UIViewController {
       headerVC = VerificationVC()
        return headerVC!
    }
    
    func bottomViewController() -> UIViewController & TwitterProfile.PagerAwareProtocol {
        HomeVC()
    }
    
    func minHeaderHeight() -> CGFloat {
        10
    }
    
    func tp_scrollView(_ scrollView: UIScrollView, didUpdate progress: CGFloat) {
      //  headerVC?.update(with: progress, minHeaderHeight: minHeaderHeight())
        print("tp_scrollView(_ scrollView: UIScrollView, didUpdate progress: CGFloat)")
    }
    
    func tp_scrollViewDidLoad(_ scrollView: UIScrollView) {
        print("tp_scrollViewDidLoad(_ scrollView: UIScrollView)")
    }
    
    @IBOutlet weak var myTableView: UITableView!{
        didSet{
            myTableView.dataSource = self
            myTableView.delegate = self
            myTableView.register(cellType: ItemCell.self)
            myTableView.register(cellType: StretchyHeader.self)
        }
    }
    
    var stretchyHeader: GSKStretchyHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addTwitter()

    }
    func addTwitter() {
        self.tp_configure(with: self, delegate: self)
  
    }
    func addOneImage(){
        let imageView = UIImageView()
         imageView.image = UIImage(named: "header")
         imageView.contentMode = .scaleAspectFill
     //  imageView.contentInsetAdjustmentBehavior = .never
        //setup blur vibrant view
        imageView.blurView.setup(style: UIBlurEffect.Style.dark, alpha: 1).enable()
      //  headerImageView = imageView
        myTableView.parallaxHeader.view = imageView
        myTableView.parallaxHeader.height = 200
        myTableView.parallaxHeader.minimumHeight = 0
        myTableView.parallaxHeader.mode = .centerFill
        myTableView.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
            //update alpha of blur view on top of image view
            parallaxHeader.view.blurView.alpha = 1 - parallaxHeader.progress
        }
    }
    func addStretchy1() {
        let headerSize = CGSize(width: self.myTableView.frame.size.width,
                                    height: 200) // 200 will be the default height
            self.stretchyHeader = GSKStretchyHeaderView(frame: CGRect(x: 0, y: 0,
                                                                              width: headerSize.width,
                                                                              height: headerSize.height))
        stretchyHeader.backgroundColor = .red
           // self.stretchyHeader.delegate = self // this is completely optional
        stretchyHeader.expansionMode = .topOnly
      //  stretchyHeader.minimumContentHeight = 1 // you can replace the navigation bar with a stretchy header view
        stretchyHeader.maximumContentHeight = 200
        stretchyHeader.contentAnchor = .bottom
            self.myTableView.addSubview(self.stretchyHeader)
    }


}

extension StrectchyHeaderVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ItemCell.self, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      //  let headerView = UIView()
        let headerCell = tableView.dequeueReusableHeader(with: StretchyHeader.self)
      //  headerView.addSubview(headerCell)
     //   headerCell.setup(title: "Header")
        return headerCell
    }
}

extension StrectchyHeaderVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }
}
