//
//  MyPositionVC.swift
//  GoEarth
//
//  Created by qianfeng on 16/10/7.
//  Copyright © 2016年 u. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MyPositionVC: NavBaseVC, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var mapView:MKMapView!
    var locationManager: CLLocationManager!
    var location: CLLocation!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
    }

    func createUI(){
        
        self.createMapView()
        
        let back = UIButton.init(frame: CGRectMake(15, 32, 20, 20))
        back.setImage(UIImage.init(named: "nav_back"), forState: .Normal)
        back.addTarget(self, action: #selector(self.backButtonAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(back)
        
    }
    func createMapView(){
        mapView = MKMapView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H))
        mapView.delegate = self
        mapView.zoomEnabled = true
        mapView.showsUserLocation = true
        mapView.scrollEnabled = true
        self.view.addSubview(mapView)
        self.view.sendSubviewToBack(mapView)
        let version = UIDevice.currentDevice().systemVersion
        if version > "8.0"{
            self.getUserLocation()
        }
        
        
        //添加长按手势 长按添加大头针
        let lpgr = UILongPressGestureRecognizer.init(target: self, action: #selector(self.lpgrAction(_:)))
        mapView.addGestureRecognizer(lpgr)
    }
    //长按添加大头针事件
    func lpgrAction(lp: UILongPressGestureRecognizer){
        //判断只在长按的起始点下落大头针
        if lp.state == UIGestureRecognizerState.Began{
            //首先获取点
            let point = lp.locationInView(mapView)
            let center = mapView!.convertPoint(point, toCoordinateFromView: mapView)
            let pinAnnotation = MKPointAnnotation.init()
            pinAnnotation.coordinate = center
            pinAnnotation.title = "长按"
            mapView!.addAnnotation(pinAnnotation)
        }
    }
    
    func getUserLocation(){
        locationManager = CLLocationManager.init()
        locationManager.delegate = self
        //kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 50.0
        let version = UIDevice.currentDevice().systemVersion
        if version > "8.0"{
            locationManager.requestAlwaysAuthorization()
        }
        //更新位置
        locationManager.startUpdatingLocation()
        
//        kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//        locationManager.distanceFilter = 50.0f;
//        if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0))
//        {
//            [locationManager requestAlwaysAuthorization];
//        }
//        //更新位置
//        [locationManager startUpdatingLocation]
        
        
    }
    
    
    
    func backButtonAction(){
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBarHidden = true
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    
    //MARK: -mapView协议代理
    
    
    //MARK: -CLLocationManagerDelegate 位置更新后的回调
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //停止位置更新
        manager.stopUpdatingLocation()
        
        let lcs = locations.first!
        //位置更新后的经纬度
        let coordinate = CLLocationCoordinate2D.init(latitude: lcs.coordinate.latitude, longitude: lcs.coordinate.longitude)
        //设置显示范围
        let span = MKCoordinateSpan.init(latitudeDelta: 1, longitudeDelta: 1)
        //设置地图显示中心及范围
        let region = MKCoordinateRegion.init(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        location = locations.last!
        

        let geocoder = CLGeocoder.init()
        geocoder.reverseGeocodeLocation(self.location, completionHandler: { (array, error) in
            
            if array?.count > 0{
                let placemark = array!.first!
                //将获得的所有信息显示到label上
                
                //获取城市
                var city = placemark.administrativeArea
                //如果city为空，则可知为直辖市
                if city != nil{
                    //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获取
                    city = placemark.administrativeArea!
                }
               
                //设置地图显示的类型及根据范围进行显示 安放大头针
                let pinAnnotation = MKPointAnnotation.init()
                pinAnnotation.coordinate = coordinate
                pinAnnotation.title = city
               // self.mapView!.addAnnotation(pinAnnotation)
                
            }else if error == nil && array?.count == 0{
                AlertTwoSeconds(self, title: "获取不到位置")
            }else if error != nil{
                AlertTwoSeconds(self, title: "\(error)")
            }
            
        })
        
    }
    
    //每次添加大头针都会调用此方法 可以设置大头针的样式
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        //判断大头针位置是否在原点，如果是则不加大头针
        if annotation .isKindOfClass(MKUserLocation){
            return nil
        }
        let identify = "annotation"
        var anno = mapView.dequeueReusableAnnotationViewWithIdentifier(identify) as? MKPinAnnotationView
        if anno == nil{
            anno = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: identify)
        }
        anno?.animatesDrop = true
        // 显示详细信息
        anno?.canShowCallout = true
        //    anView.leftCalloutAccessoryView   可以设置左视图
        //    anView.rightCalloutAccessoryView   可以设置右视图
        return anno!
    }
    
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    func locationManager(manager: CLLocationManager, didFinishDeferredUpdatesWithError error: NSError?) {
        print(error)
    }
    
    
    

}
