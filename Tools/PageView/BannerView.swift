//
//  CircleAD.swift
//  Medical-swift
//  广告无限轮播
//  Created by YueAndy on 2018/1/23.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit
import Kingfisher

let kAdCellID = "kAdCellID"

class BannerView: UIView {
    
    @IBOutlet weak var pagecontrol: UIPageControl!
    @IBOutlet weak var cv_circle: UICollectionView!
    
    private var circleTimer:Timer?
    
    var layout:UICollectionViewFlowLayout?
    
    var adsArr: NSMutableArray? {
        didSet{
            let indexpath = NSIndexPath(row: (adsArr?.count)! * 40, section: 0)
            
            cv_circle.scrollToItem(at: indexpath as IndexPath, at: .left, animated: false)
            
            cv_circle.reloadData()
            
            pagecontrol.numberOfPages = (adsArr?.count)!
            
            removeTimer()
            addTimer()
        }
    }
    
    
    class func circleAd(rect:CGRect) -> BannerView {
        let  cad = Bundle.main.loadNibNamed("CircleAD", owner: nil, options: nil)?.last as! BannerView
        cad.frame = rect
        cad.layout?.itemSize = rect.size
        return cad
    }
    
    override func awakeFromNib() {
        cv_circle.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kAdCellID)
        layout = cv_circle.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumLineSpacing = 0
        layout?.minimumInteritemSpacing = 0
        layout?.scrollDirection = .horizontal
        cv_circle.showsHorizontalScrollIndicator = false
        cv_circle.delegate = self
        cv_circle.dataSource = self
    }
    
    @objc func scrollTonext() {
        //1.获取滚动的偏移量
        let currentOffX = cv_circle.contentOffset.x;
        let offsetX = currentOffX + cv_circle.bounds.size.width;
        //2.滚动的位置
        cv_circle.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    func addTimer() {
        circleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollTonext), userInfo: nil, repeats: true)
        RunLoop.main.add(circleTimer!, forMode: .commonModes)
    }
    
    func removeTimer() {
        circleTimer?.invalidate()
    }
}

extension BannerView : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAdCellID, for: indexPath)
        let imageV = UIImageView(frame: cell.bounds)
        imageV.kf.setImage(with: URL(string: ""), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        cell.addSubview(imageV)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + self.bounds.size.width / 2;
        //2.计算pageControll 的currentIndex
        let index = Int(offsetX / self.bounds.size.width);
        pagecontrol.currentPage = index % (adsArr?.count)!;
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
}
