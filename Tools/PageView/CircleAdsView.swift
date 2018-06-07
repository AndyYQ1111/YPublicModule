//
//  CircleAdsView.swift
//  YPublicModuleDemo
//
//  Created by YueAndy on 2018/6/7.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit
import Kingfisher

class CircleAdsView: CustomView {

    @IBOutlet weak var cv_circle: UICollectionView!
    @IBOutlet weak var pagecontrol: UIPageControl!
    
    
    let cellId = "cellId"
    
    
    private var circleTimer:Timer?
    
    var adsArr: Array<String>? {
        didSet{
            let indexpath = NSIndexPath(row: (adsArr?.count)! * 40, section: 0)
            
            cv_circle.scrollToItem(at: indexpath as IndexPath, at: .left, animated: false)
            
            cv_circle.reloadData()
            
            pagecontrol.numberOfPages = (adsArr?.count)!
            
            removeTimer()
            addTimer()
        }
    }
    
    override func setupUI() {
        cv_circle.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        cv_circle.reloadData()
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

extension CircleAdsView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let imageV = UIImageView(frame: cell.bounds)
        imageV.kf.setImage(with: URL(string: adsArr![indexPath.row % 4]), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        cell.addSubview(imageV)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height:collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
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
