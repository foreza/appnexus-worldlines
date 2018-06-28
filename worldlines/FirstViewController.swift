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
    var banner : ANBannerAdView?;

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenRect = UIScreen.main.bounds
        let centerX = screenRect.size.width/2
        let centerY = screenRect.size.height/2
        let rect = CGRect(x: CGFloat(centerX), y: CGFloat(centerY), width: CGFloat(300.0), height: CGFloat(250.0));
        let size = CGSize(width: 300.0, height: 250.0)
        
        let banner = ANBannerAdView (frame: rect, placementId:"1281482", adSize:size);

    
        // Create the banner ad view and add it as a subview.
        banner?.rootViewController = self;
        banner?.autoRefreshInterval = 30   // Set to 0 to disable auto-refresh.
        self.view.addSubview(banner!)
        
        // Load an ad!
        banner?.loadAd()
        
        print(logger + " loadAd called")

        
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

