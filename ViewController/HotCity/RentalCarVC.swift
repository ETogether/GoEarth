//
//  RentalCarVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/9/26.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit

class RentalCarVC: NavBaseVC, UITableViewDataSource, UITableViewDelegate {
    
    var placeId = ""
    var dataArr = NSMutableArray()
    var supperliersDic = NSDictionary()
    var vehicleType = NSDictionary()
    
    lazy var rentalCar: UITableView = {
        let rc = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H - 64))
        rc.registerNib(UINib.init(nibName: "VehiclesCell", bundle: nil), forCellReuseIdentifier: "VehiclesCell")
        rc.delegate = self
        rc.dataSource = self
        rc.showsVerticalScrollIndicator = false
        
        self.view.addSubview(rc)
        return rc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createRightButton()
        self.loadData()
    }
    func createRightButton(){
        let image = UIImage.init(named: "nav_message")?.imageWithRenderingMode(.AlwaysOriginal)
        let btn = UIButton.init(type: .System)
        btn.frame = CGRectMake(0, 0, 25, 25)
        btn.setBackgroundImage(image, forState: .Normal)
        btn.setBackgroundImage(image, forState: .Highlighted)
        btn.addTarget(self, action: #selector(self.rightButtonClick(_:)), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: btn)
    }
    func rightButtonClick(sender: UIButton){
        let company = CompanyCompare()
        company.placeId = placeId
        company.navigationItem.title = "供应商口碑"
        self.navigationController?.pushViewController(company, animated: true)
    }
    
    func loadData(){
        HDManager.startLoading()
        VehiclesModel.requestVehiclesData(placeId) { (vehiclesArr, suppliersDic, vehicleType, err) in
            if err == nil{
                self.dataArr.addObjectsFromArray(vehiclesArr!)
                self.supperliersDic = suppliersDic!
                self.vehicleType = vehicleType!
                self.rentalCar.reloadData()
                
            }else{
                print(err)
                AlertTwoSeconds(self, title: "网络连接请求失败！")
            }
            
        }

        HDManager.stopLoading()
    }
    
    
    //MARK: - rentalCar(UITableView) 协议方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VehiclesCell", forIndexPath: indexPath) as! VehiclesCell
        let models = dataArr[indexPath.row] as! VehiclesModel
        let model = models.vehicleInfo
        
        cell.imageCar.sd_setImageWithURL(NSURL.init(string: model.imagePath))
        cell.nameL.text = model.vehicleName
        let type = (vehicleType[model.vehicleTypeId] as! NSDictionary)["vehicleName"] as! String

        cell.desL.text = type + " | " + model.transmission + " | " + model.seat + "座"
        cell.createIcons(models.supplierQuotes, dic: self.supperliersDic)
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = dataArr[indexPath.row] as! VehiclesModel
        let count = model.supplierQuotes.count
        let height = 21 + 41 + 8 + CGFloat(count) * 30 + CGFloat(count - 1) * 5 + 8 + 20
        if height > 120{
            return height
        }
        return 120
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }

}
