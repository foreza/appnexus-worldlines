//
//  FirstViewController.swift
//  worldlines
//
//  Created by Jason C on 6/28/18.
//  Copyright © 2018 Jason C. All rights reserved.
//

import UIKit
import AppNexusSDK

class FirstViewController: UIViewController, ANAdDelegate  {
    
    var logger : String = "[WURLLDLINES]"
    var banner : ANBannerAdView?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let screenRect = UIScreen.main.bounds
        let centerX = (screenRect.size.width-320)/2
        let centerY = screenRect.size.height/2
        let rect = CGRect(x: CGFloat(centerX), y: CGFloat(centerY), width: CGFloat(320.0), height: CGFloat(50.0));
        let size = CGSize(width: 320.0, height: 50.0)
        
        let banner = ANBannerAdView (frame: rect, placementId:"10686310", adSize:size);

    
        // Create the banner ad view and add it as a subview.
        banner?.rootViewController = self;
        banner?.autoRefreshInterval = 10   // Set to 0 to disable auto-refresh.
        banner?.addCustomKeyword(withKey: "FC0", value: "bar")
        banner?.addCustomKeyword(withKey: "WO1 ", value: "bad")
        self.view.addSubview(banner!)
        
        // Load an ad!
        banner?.loadAd()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: Figure out the other ANAdDelegate methods and implement them
    func adDidReceiveAd(_ id: ANAdProtocol!) {
        print(logger + " did received ad")
    }
    

}

