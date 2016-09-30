//
//  AttractionDetailView.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/28.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class AttractionDetailView: UIScrollView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let topSpace: CGFloat = 10
    let leftSpace: CGFloat = 10
    
    var itemModel: AttractionItemModel!
    var tagArr: NSMutableArray!
    var block: ((detail: GEBaseVC) -> Void)?
    //第一部分
    var headerImage: UIImageView!
    var photoCount: UILabel!
    var cnL: UILabel!
    var nameL: UILabel!
    var starsBG: UIImageView!
    var starsFG: UIImageView!
    var scoreL: UILabel!
    var dimensionView: UICollectionView!
    var tags: UICollectionView!
    
    //第二部分
    var secView: UIView!
    
    var infoCnL: UILabel!
    var infoBtn: UIButton!
    var addressTTL: UILabel!
    var addressCTT: UILabel!
    var trafficTTL: UILabel!
    var trafficCTT: UILabel!
    var ticketTTL: UILabel!
    var ticketCTT: UILabel!
    var phoneTTL: UILabel!
    var phoneCTT: UILabel!
    var openTimeTTL: UILabel!
    var openTimeCTT: UILabel!
    var duractionTTL: UILabel!
    var duractionCTT: UILabel!
    var tagCnTTL: UILabel!
    var tagCnCTT: UILabel!
    var tipTTL: UILabel!
    var tipCTT: UILabel!
    
    //第三部分 精选评论
    var tableView: UILabel!
    
    init(frame: CGRect, itemModel: AttractionItemModel, tagArr: NSMutableArray) {
        super.init(frame: frame)
    self.itemModel = itemModel
        self.tagArr = tagArr
        
        //MARK: 第一部分
        headerImage = UIImageView.init(frame: CGRectMake(0, 0, self.mj_w, self.mj_w * 2 / 3))
        headerImage.sd_setImageWithURL(NSURL.init(string: itemModel.cover))
        self.addSubview(headerImage)
        headerImage.userInteractionEnabled = true
        headerImage.addGestureRecognizer({
            return UITapGestureRecognizer.init(target: self, action: #selector(self.tapClick(_:)))
            }())
        
        photoCount = UILabel.init(frame: CGRectMake(SCREEN_W - leftSpace - 50, headerImage.mj_h - 50, 50, 20))
        photoCount.text = itemModel.photoCount + "张"
        photoCount.textColor = WHITECOLOR
        photoCount.textAlignment = .Center
        photoCount.font = UIFont.boldSystemFontOfSize(13)
        headerImage.addSubview(photoCount)
        let cnW = widthFor(strLength: itemModel.nameCn, height: 21, font: 16) + 5
        cnL = UILabel.init(frame: CGRectMake(0, headerImage.mj_h + topSpace, cnW, 21))
        cnL.center.x = self.center.x
        cnL.text = itemModel.nameCn
        cnL.textAlignment = .Center
        self.addSubview(cnL)
        let nameW = widthFor(strLength: itemModel.name, height: 21, font: 16) + 5
        nameL = UILabel.init(frame: CGRectMake(0, cnL.mj_y + cnL.mj_h + topSpace, nameW, 21))
        nameL.center.x = cnL.center.x
        nameL.text = itemModel.name
        nameL.textColor = hexColor(hexStr: "909090")
        nameL.font = UIFont.systemFontOfSize(16)
        nameL.textAlignment = .Center
        self.addSubview(nameL)
        starsBG = UIImageView.init(image: UIImage.init(named: "stars_bgs"))
        starsBG.frame = CGRectMake(nameL.center.x - 80 - 2, nameL.mj_y + nameL.mj_h + topSpace, 80, 20)
        self.addSubview(starsBG)
        starsFG = UIImageView.init(image: UIImage.init(named: "stars_fg"))
        starsFG.frame = starsBG.frame
        starsFG.contentMode = .Left
        starsFG.clipsToBounds = true
        let score = Float(itemModel.score)!
        starsFG.mj_w = CGFloat(score / 10) * starsFG.mj_w
        self.addSubview(starsFG)
        let scoreStr = itemModel.score + "分/" + itemModel.reviewCount + "点评 》"
        let sw = widthFor(strLength: scoreStr, height: 20, font: 12) + 5
        scoreL = UILabel.init(frame: CGRectMake(nameL.center.x + 2, starsFG.mj_y, sw, 20))
        scoreL.text = scoreStr
        scoreL.textColor = hexColor(hexStr: "909090")
        scoreL.font = UIFont.systemFontOfSize(12)
        scoreL.addGestureRecognizer({
            return UITapGestureRecognizer.init(target: self, action: #selector(self.reviewBtnClik(_:)))
            }())
        scoreL.userInteractionEnabled = true
        self.addSubview(scoreL)
        
        let dimLayout = UICollectionViewFlowLayout()
        dimLayout.scrollDirection = .Horizontal
        dimLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 11 * leftSpace, bottom: 0, right: 0)
        //dimLayout.minimumInteritemSpacing = (SCREEN_W - 4 * leftSpace - 3 * 80 ) / 2 - 10
        dimensionView = UICollectionView.init(frame: CGRectMake(0, starsFG.mj_y + starsFG.mj_h + 2 * topSpace, SCREEN_W, 100), collectionViewLayout: dimLayout)
        dimensionView.showsHorizontalScrollIndicator = false
        self.addSubview(dimensionView)
        dimensionView.registerNib(UINib.init(nibName: "AttractionTagsCell", bundle: nil), forCellWithReuseIdentifier: "DimensionCell")
        dimensionView.delegate = self
        dimensionView.dataSource = self
        dimensionView.backgroundColor = WHITECOLOR
        
        
        let tagLayout = UICollectionViewFlowLayout()
        tagLayout.sectionInset = UIEdgeInsets.init(top: 5, left: leftSpace, bottom: 5, right: leftSpace)
        tagLayout.minimumLineSpacing = 5
        tagLayout.scrollDirection = .Vertical
        tags = UICollectionView.init(frame: CGRectMake(0, dimensionView.mj_y + dimensionView.mj_h, self.mj_w, 180), collectionViewLayout: tagLayout)
        tags.showsVerticalScrollIndicator = false
        tags.bounces = false
        tags.scrollEnabled = false
        tags.backgroundColor = WHITECOLOR
        tags.registerNib(UINib.init(nibName: "TagsCell", bundle: nil), forCellWithReuseIdentifier: "TagsCell")
        tags.delegate = self
        tags.dataSource = self
        self.addSubview(tags)
        
        
        
        //MARK:第二部分
        secView = UIView.init(frame: CGRectMake(0, tags.mj_y + tags.mj_h, SCREEN_W, 1000))
        self.addSubview(secView)
        infoCnL = UILabel.init(frame: CGRectMake(0, 50,50, 30))
        infoCnL.center.x = self.center.x
        infoCnL.numberOfLines = 0
        infoCnL.text = "简介"
        infoCnL.textAlignment = .Center
        secView.addSubview(infoCnL)
        let infoL = UILabel.init(frame: CGRectMake(leftSpace, infoCnL.mj_y + infoCnL.mj_h + leftSpace, SCREEN_W - 2 * leftSpace, 60))
        infoL.text = itemModel.infoCn
        infoL.font = UIFont.systemFontOfSize(12)
        infoL.numberOfLines = 4
        secView.addSubview(infoL)
        infoBtn = UIButton.init(frame: CGRectMake(0, infoL.mj_y + infoL.mj_h + leftSpace, 100, 30))
        infoBtn.center.x = self.center.x
        infoBtn.setTitle("查看更多", forState: .Normal)
        infoBtn.setTitle("查看更多", forState: .Highlighted)
        infoBtn.setTitleColor(hexColor(hexStr: "04f0a1"), forState: .Normal)
        infoBtn.setTitleColor(hexColor(hexStr: "04f0a1"), forState: .Highlighted)
        infoBtn.addTarget(self, action: #selector(self.infoBtnClick(_:)), forControlEvents: .TouchUpInside)
        secView.addSubview(infoBtn)
        infoBtn.layer.cornerRadius = 5
        infoBtn.layer.borderColor = hexColor(hexStr: "04f0a1").CGColor
        infoBtn.layer.borderWidth = 2
        infoBtn.backgroundColor = UIColor.clearColor()
        
        addressTTL = UILabel.init(frame: CGRectMake(leftSpace, infoBtn.mj_y + infoBtn.mj_h + topSpace, 30, 20))
        addressTTL.text = "地址"
        addressTTL.textColor = TEXTGRAYCOLOR
        addressTTL.font = UIFont.systemFontOfSize(12)
        secView.addSubview(addressTTL)
        addressCTT = UILabel.init(frame: CGRectMake(leftSpace, addressTTL.mj_y + addressTTL.mj_h + topSpace, SCREEN_W - 2 * leftSpace, 20))
        addressCTT.text = itemModel.address
        addressCTT.font = UIFont.systemFontOfSize(14)
        secView.addSubview(addressCTT)
        
        trafficTTL = UILabel.init(frame: CGRectMake(leftSpace, addressCTT.mj_y + addressCTT.mj_h + topSpace, 30, 20))
        trafficTTL.text = "交通"
        trafficTTL.textColor = TEXTGRAYCOLOR
        trafficTTL.font = UIFont.systemFontOfSize(12)
        secView.addSubview(trafficTTL)
        let traH = heightFor(strLength: itemModel.traffic, width: SCREEN_W - 2 * leftSpace, font: 14) + 5
        trafficCTT = UILabel.init(frame: CGRectMake(leftSpace, trafficTTL.mj_y + trafficTTL.mj_w + topSpace, SCREEN_W - 2 * leftSpace, traH))
        trafficCTT.text = itemModel.traffic
        trafficCTT.numberOfLines = 0
        trafficCTT.font = UIFont.systemFontOfSize(14)
        secView.addSubview(trafficCTT)
        
        ticketTTL = UILabel.init(frame: CGRectMake(leftSpace, trafficCTT.mj_y + trafficCTT.mj_h + topSpace, 30, 20))
        ticketTTL.text = "门票"
        ticketTTL.textColor = TEXTGRAYCOLOR
        ticketTTL.font = UIFont.systemFontOfSize(12)
        secView.addSubview(ticketTTL)
        ticketCTT = UILabel.init(frame: CGRectMake(leftSpace, ticketTTL.mj_y + ticketTTL.mj_h + topSpace, SCREEN_W - 2 * leftSpace, 20))
        ticketCTT.text = "¥" + itemModel.price
        ticketCTT.font = UIFont.systemFontOfSize(14)
        secView.addSubview(ticketCTT)
        
        phoneTTL = UILabel.init(frame: CGRectMake(leftSpace, ticketCTT.mj_y + ticketCTT.mj_h + topSpace, 30, 20))
        phoneTTL.text = "电话"
        phoneTTL.textColor = TEXTGRAYCOLOR
        phoneTTL.font = UIFont.systemFontOfSize(12)
        secView.addSubview(phoneTTL)
        phoneCTT = UILabel.init(frame: CGRectMake(leftSpace, phoneTTL.mj_y + phoneTTL.mj_h + topSpace, SCREEN_W - 2 * leftSpace, 20))
        phoneCTT.text = itemModel.contact
        phoneCTT.font = UIFont.systemFontOfSize(14)
        secView.addSubview(phoneCTT)
        
        openTimeTTL = UILabel.init(frame: CGRectMake(leftSpace, phoneCTT.mj_y + phoneCTT.mj_h + topSpace, 130, 20))
        openTimeTTL.text = "开放时间"
        openTimeTTL.textColor = TEXTGRAYCOLOR
        openTimeTTL.font = UIFont.systemFontOfSize(12)
        secView.addSubview(openTimeTTL)
        let opeH = heightFor(strLength: itemModel.openingTimeCn, width: SCREEN_W - 2 * leftSpace, font: 14) + 5
        openTimeCTT = UILabel.init(frame: CGRectMake(leftSpace, openTimeTTL.mj_y + openTimeTTL.mj_h + topSpace, SCREEN_W - 2 * leftSpace, opeH))
        openTimeCTT.text = itemModel.openingTimeCn
        openTimeCTT.numberOfLines = 0
        openTimeCTT.font = UIFont.systemFontOfSize(14)
        secView.addSubview(openTimeCTT)
        
        duractionTTL = UILabel.init(frame: CGRectMake(leftSpace, openTimeCTT.mj_y + openTimeCTT.mj_h + topSpace, 130, 20))
        duractionTTL.text = "游玩时间"
        duractionTTL.textColor = TEXTGRAYCOLOR
        duractionTTL.font = UIFont.systemFontOfSize(12)
        secView.addSubview(duractionTTL)
        duractionCTT = UILabel.init(frame: CGRectMake(leftSpace, duractionTTL.mj_y + duractionTTL.mj_h + topSpace, SCREEN_W - 2 * leftSpace, 20))
        duractionCTT.text = itemModel.contact
        duractionCTT.font = UIFont.systemFontOfSize(14)
        secView.addSubview(duractionCTT)
        
        tagCnTTL = UILabel.init(frame: CGRectMake(leftSpace, duractionCTT.mj_y + duractionCTT.mj_h + topSpace, 130, 20))
        tagCnTTL.text = "分类标签"
        tagCnTTL.textColor = TEXTGRAYCOLOR
        tagCnTTL.font = UIFont.systemFontOfSize(12)
        secView.addSubview(tagCnTTL)
        tagCnCTT = UILabel.init(frame: CGRectMake(leftSpace, tagCnTTL.mj_y + tagCnTTL.mj_h + topSpace, SCREEN_W - 2 * leftSpace, 20))
        tagCnCTT.text = itemModel.tagCn
        tagCnCTT.font = UIFont.systemFontOfSize(14)
        secView.addSubview(tagCnCTT)
        
        tipTTL = UILabel.init(frame: CGRectMake(leftSpace, tagCnCTT.mj_y + tagCnCTT.mj_h + topSpace, 120, 20))
        tipTTL.text = "小帖士"
        tipTTL.textColor = TEXTGRAYCOLOR
        tipTTL.font = UIFont.systemFontOfSize(12)
        secView.addSubview(tipTTL)
        let tipH = heightFor(strLength: itemModel.tip, width: SCREEN_W - 2 * leftSpace, font: 14) + 5
        tipCTT = UILabel.init(frame: CGRectMake(leftSpace, tipTTL.mj_y + tipTTL.mj_h + topSpace, SCREEN_W - 2 * leftSpace, tipH))
        tipCTT.text = itemModel.tip
        tipCTT.font = UIFont.systemFontOfSize(14)
        tipCTT.numberOfLines = 0
        secView.addSubview(tipCTT)
        
        tableView = UILabel.init(frame: CGRectMake(0, tipCTT.mj_y + tipCTT.mj_h + topSpace, 120, 20))
        tableView.center.x = self.center.x
        tableView.text = "精选评价"
        tableView.textAlignment = .Center
        tableView.font = UIFont.systemFontOfSize(15)
        secView.addSubview(tableView)
        var i = 0
        for review in itemModel.reviews{
            
            let originY = (tableView.mj_y + tableView.mj_h + topSpace) + CGFloat(i) * 105
            
            let view = review as! ReviewsModel
            let icon = UIImageView.init(frame: CGRectMake(leftSpace, originY, 25, 25))
            icon.sd_setImageWithURL(NSURL.init(string: view.userface))
            secView.addSubview(icon)
            icon.layer.cornerRadius = icon.mj_h / 2
            icon.layer.masksToBounds = true
            
            let width = widthFor(strLength: view.author, height: 18, font: 13) + 5
            let name = UILabel.init(frame: CGRectMake(leftSpace + icon.mj_x + icon.mj_w, originY, width, 18))
            name.text = view.author
            name.font = UIFont.systemFontOfSize(13)
            secView.addSubview(name)
            
            let starBG = UIImageView.init(frame: CGRectMake(name.mj_x + width + leftSpace, originY, 80, 20))
            starBG.image = UIImage.init(named: "stars_bgs")
            secView.addSubview(starBG)
            
            let starFG = UIImageView.init(frame: CGRectMake(name.mj_x + width + leftSpace, originY, 80, 20))
            secView.addSubview(starFG)
            starFG.image = UIImage.init(named: "stars_fg")
            starFG.contentMode = .Left   //左不动
            starFG.clipsToBounds = true
            let s = Float(view.score)!
            starFG.mj_w = CGFloat(s / 10) * 80
            
            
            let content = UILabel.init(frame: CGRectMake(name.mj_x, name.mj_y + name.mj_h + topSpace, SCREEN_W - name.mj_x - leftSpace, 30))
            content.text = view.comment
            content.numberOfLines = 2
            content.font = UIFont.systemFontOfSize(12)
            secView.addSubview(content)
            
            let time = UILabel.init(frame: CGRectMake(SCREEN_W - 80 - 2 * leftSpace, content.mj_y + content.mj_h + topSpace, 80, 20))
            
//            let df = NSDateFormatter()
//            df.dateFormat = "yyyy-MM-dd hh-mm-ss"
//            let date = df.dateFromString(view.time)!
            let str = NSMutableString.init(string: view.time)
            time.text = str.substringToIndex(10)
            time.textColor = TEXTGRAYCOLOR
            time.font = UIFont.systemFontOfSize(12)
            secView.addSubview(time)
            
            
            
            if i == itemModel.reviews.count - 1{
                let btn = UIButton.init(frame: CGRectMake(0, time.mj_y + time.mj_h + topSpace, 240, 30))
                btn.center.x = self.center.x
                btn.setTitle("查看全部\(itemModel.reviewCount)条评论", forState: .Normal)
                btn.setTitle("查看全部\(itemModel.reviewCount)条评论", forState: .Highlighted)
                btn.setTitleColor(hexColor(hexStr: "04f0a1"), forState: .Normal)
                btn.setTitleColor(hexColor(hexStr: "04f0a1"), forState: .Highlighted)
                btn.addTarget(self, action: #selector(self.reviewBtnClik(_:)), forControlEvents: .TouchUpInside)
                secView.addSubview(btn)
                btn.layer.cornerRadius = 5
                btn.layer.borderColor = hexColor(hexStr: "04f0a1").CGColor
                btn.layer.borderWidth = 2
                btn.backgroundColor = UIColor.clearColor()
            }
            i += 1
        }
        secView.mj_h = tableView.mj_y + tableView.mj_h + 365
        self.contentSize = CGSizeMake(secView.mj_w, secView.mj_y + secView.mj_h + topSpace)
        
        
    }
    //MARK: - 照片、简介、评论的点击事件
    func tapClick(tap: UITapGestureRecognizer){
        
        let photoList = PhotoListVC()
        photoList.recordId = itemModel.id
        self.block!(detail: photoList)
    }
    func infoBtnClick(sender: UIButton){
        let detail = CityGuideDetailVC()
        detail.content = itemModel.infoCn
        detail.navigationItem.title = "简介"
        self.block!(detail: detail)
    }
    func reviewBtnClik(sender: UIButton){
        let comment = CommentVC()
        comment.recordId = itemModel.id
        comment.navigationItem.title = "全部评论"
        self.block!(detail: comment)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - UICollectionView 协议方法
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tags{
            return tagArr.count
        }
        return itemModel.dimensionScores.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if collectionView == dimensionView{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DimensionCell", forIndexPath: indexPath) as! AttractionTagsCell
            let model = itemModel.dimensionScores[indexPath.item] as! DimensionModel
            cell.tagL.text = model.name
            cell.count.text = String.init(format: "%0.1f", Float(model.score)!)
            
            return cell

        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TagsCell", forIndexPath: indexPath) as! TagsCell
        let model = tagArr[indexPath.item] as! AttractionTagsModel
        cell.tagsL.text = model.tag + " " + model.num
       // cell.lineL.backgroundColor = hexColor(hexStr: "04a0f1")
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == dimensionView{
            return CGSizeMake(60, 80)
        }
        return CGSizeMake((SCREEN_W - 4 * leftSpace) / 3 - 20, 28)
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return (SCREEN_W - 4 * leftSpace - 3 * 80 ) / 2 - 2
//    }
    

}
