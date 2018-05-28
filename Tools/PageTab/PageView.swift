//
//  PageView.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/21.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit


class PageView: UIView{
    
    //MARK:定义常量
    
    var normalColor: UIColor = UIColor(r: 103, g: 103, b: 103)
    var selectColor: UIColor = UIColor.orange
    
    //btn对应的图片
    var imageNames:[String] = []
    //标题数组
    var titles:[String] = []
    //子控制器
    var childrenVC:[UIViewController] = []
    
    var maxShow: CGFloat = 3.5
    
    
    let kScrollLineH :CGFloat = 2
    
    let cellID = "kCollectionCellID"
    
    private var startOffsetX: CGFloat = 0
    
    private var isForbidScroll = false
    
    
    private var targetTag : Int = 0
    
    
    //根据标题数组生成的按钮数组
    private var titleBtns:[UIButton] = [UIButton]()
    //显示的最多的btn
    
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = selectColor
        return scrollLine  
    }()
    
    /*** 下面的几个方法都是为了让这个自定义类能将xib里的view加载进来。这个是通用的，我们不需修改。 ****/
    private var contentView:UIView!
    
    @IBOutlet weak var sv_head: UIScrollView!
    @IBOutlet weak var cv_content: UICollectionView!
    
    //初始化时将xib中的view添加进来
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        contentView.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
        addSubview(contentView)
    }
    
    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        contentView.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
        addSubview(contentView)
        //初始化属性配置
    }
    

    private func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}

extension PageView {
    
    func setupUI() {
        //注册cell
        cv_content.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        cv_content.reloadData()
        setupBtns()
        setupBottomLine()
    }
    
    //标签按钮
    private func setupBtns() {
        var btnW: CGFloat
        if titles.count > Int(maxShow) {
            btnW = KScreenW / CGFloat(maxShow)
        }else{
            btnW = KScreenW / CGFloat(titles.count)
        }
        sv_head.contentSize = CGSize(width: btnW * CGFloat(titles.count), height: sv_head.frame.height)
        
        let btnH = sv_head.frame.height - kScrollLineH;
        
        for (index,title) in titles.enumerated() {
            let btn = UIButton(type: .system)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.tag = index
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(normalColor, for: .normal)
            
            if imageNames.count > 0 {
                btn.setImage(UIImage.init(named: imageNames[index]), for: .normal)
                btn.tintColor = normalColor
                btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            }
            
            if btn.tag == 0 {
                btn.setTitleColor(selectColor, for: .normal)
                btn.tintColor = selectColor
            }
            
            let btnX = btnW * CGFloat(index)
            
            btn.frame = CGRect(x: btnX, y: 0, width: btnW, height: btnH)
            
            btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
            
            sv_head.addSubview(btn)
            titleBtns.append(btn)
        }
    }
    
    //底部线条
    private func setupBottomLine() {
        let bottomLine = UIView()
        bottomLine.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        bottomLine.backgroundColor = selectColor
        sv_head.addSubview(bottomLine)
        
        let firstBtn = titleBtns[0]
        sv_head.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstBtn.frame.origin.x, y: sv_head.frame.height - kScrollLineH, width: firstBtn.frame.width, height: kScrollLineH)
    }
    
    //点击事件
    @objc private func btnClick(btn: UIButton) {
        let sourceBtn = titleBtns[targetTag]
        sourceBtn.setTitleColor(normalColor, for: .normal)
        sourceBtn.tintColor = normalColor
        
        btn.setTitleColor(selectColor, for: .normal)
        btn.tintColor = selectColor
        targetTag = btn.tag
        
        let scrollLineX = CGFloat(targetTag) * scrollLine.frame.size.width;
        scrollLine.frame = CGRect(x: scrollLineX, y: sv_head.frame.height - kScrollLineH, width: scrollLine.frame.width, height: kScrollLineH)
        changeScrollLine(scrollLineX: scrollLineX)
        
        isForbidScroll = true;
        let x = CGFloat(targetTag) * cv_content.bounds.size.width;
        cv_content.setContentOffset(CGPoint.init(x: x, y: 0), animated: true)
    }
    
    //选中线条位置变化
    private func changeScrollLine(scrollLineX: CGFloat) {
        let scrollW = sv_head.frame.width
        let scrollCW = sv_head.contentSize.width
        let scrollLineW = scrollLine.frame.width
        
        if(scrollCW > scrollW){
            var moveX: CGFloat
            //需要移的条件
            if(scrollLineX + scrollLineW/2 > scrollW/2){
                if(scrollCW - (scrollLineX + scrollLineW/2 - scrollW/2) >= scrollW){
                    moveX = scrollLineX + scrollLineW/2 - scrollW/2;
                }else{
                    moveX = scrollCW - scrollW;
                }
            }else{
                moveX = 0;
            }
            sv_head.setContentOffset(CGPoint.init(x: moveX, y: 0), animated: true)
        }
    }
}

extension PageView: UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.isEqual(cv_content) {
            isForbidScroll = false
            startOffsetX = scrollView.contentOffset.x
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(cv_content) {
            if (isForbidScroll) {
                return;
            }
            
            var progress : CGFloat = 0
            var sourceIndex : Int = 0
            var targetIndex : Int = 0
            
            let currentOffsetX = scrollView.contentOffset.x
            let collectionViewW = cv_content.frame.width
            
            if(currentOffsetX > startOffsetX){//左滑
                progress = currentOffsetX / collectionViewW - floor(currentOffsetX / collectionViewW)
                sourceIndex = Int(currentOffsetX / collectionViewW)
                
                targetIndex = sourceIndex + 1
                
                if (targetIndex >= titles.count){
                    targetIndex = titles.count - 1
                }
                
                if currentOffsetX - startOffsetX == collectionViewW {
                    progress = 1
                    targetIndex = sourceIndex
                }
                
            }else { // 右滑
                progress = 1 - (currentOffsetX / collectionViewW - floor(currentOffsetX / collectionViewW))
                
                targetIndex = Int(currentOffsetX / collectionViewW)
                
                sourceIndex = targetIndex + 1
                
                if (sourceIndex >= titles.count){
                    sourceIndex = titles.count - 1
                }
            }
            
            
            //1.取出sourceLabel和targetLabel
            let sourceBtn = titleBtns[sourceIndex]
            let targetBtn = titleBtns[targetIndex]
            
            //2.scrollLine 滑动逻辑
            let totalX = targetBtn.frame.origin.x - sourceBtn.frame.origin.x
            let moveX  = totalX * progress
            scrollLine.frame.origin.x = sourceBtn.frame.origin.x + moveX
            
            let scrollLineX = sourceBtn.frame.origin.x + moveX;
            self .changeScrollLine(scrollLineX: scrollLineX)
            
            //3.label的颜色渐变
            //3.1颜色变化的范围
            let colorScope = (selectColor.r - normalColor.r, selectColor.g - normalColor.g, selectColor.b - normalColor.b)
            
            //3.2sourceLabel的颜色改变
            let sourceColor  = UIColor(red: selectColor.r - colorScope.0 * progress, green: selectColor.g - colorScope.1 * progress, blue: selectColor.b - colorScope.2 * progress, alpha: 1)
            
            sourceBtn.tintColor = sourceColor
            sourceBtn.setTitleColor(sourceColor, for: .normal)
            
            let targetColor = UIColor(red: normalColor.r + colorScope.0 * progress, green: normalColor.g + colorScope.1 * progress, blue: normalColor.b + colorScope.2 * progress, alpha: 1)
            targetBtn.tintColor = targetColor
            targetBtn.setTitleColor(targetColor, for: .normal)
            
            
            //保存当前的index
            targetTag = targetIndex
        }
    }
}

extension PageView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        guard let childView = childrenVC[indexPath.row].view else{
            return cell;
        }
        
        childView.frame = cell.bounds
        cell.addSubview(childView)
        childView.backgroundColor = indexPath.row%2 == 0 ? UIColor.brown : UIColor.purple
        return cell
    }
}

extension PageView: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cv_content.frame.width, height: cv_content.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

