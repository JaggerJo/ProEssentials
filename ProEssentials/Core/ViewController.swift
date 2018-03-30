//
//  ViewController.swift
//  ProEssentials
//
//  Created by Josua Jaeger on 18.03.18.
//  Copyright © 2018 Josua Jaeger. All rights reserved.
//

import Cocoa
import macOSThemeKit

class ViewController: NSViewController {
    var segmentedControlCurrentIndex: Int = 0
    var segmentedControlViewControllerNames = [
        "GeneralViewController",
        "IndicatorsViewController"
    ]
    
    @IBOutlet var mainVisualEffectView: NSVisualEffectView!
    @IBOutlet var mainContainerView: NSView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        view.window?.isOpaque = false
        setupTabs()
        
        for childViewController in childViewControllers {
            childViewController.view.frame = mainContainerView.bounds
            childViewController.viewDidLayout()
        }
    }
    
    func applyTheme() {
        let generalSettings = SettingsManager().loadOrFallback(type: GeneralSettings.self)
        
        switch generalSettings.theme {
            case .dark:
                mainVisualEffectView.material = .dark
                mainVisualEffectView.appearance = NSAppearance(named: .vibrantDark)
                break
            case .light:
                mainVisualEffectView.material = .light
                mainVisualEffectView.appearance = NSAppearance(named: .vibrantLight)
                break
            case .system:
                switch ThemeManager.systemTheme.isDarkTheme {
                    case true:
                        mainVisualEffectView.material = .dark
                        mainVisualEffectView.appearance = NSAppearance(named: .vibrantDark)
                        break
                    case false:
                        mainVisualEffectView.material = .light
                        mainVisualEffectView.appearance = NSAppearance(named: .vibrantLight)
                        break
                }
                break
        }
        
        mainVisualEffectView.state = generalSettings.transcluent
            ? .active
            : .inactive
    }
    
    func setupTabs() {
        if let window = view.window {
            let toolbarItem = window.toolbar?.items.item(at: 1)
            let segmentedControl = toolbarItem?.view! as! NSSegmentedControl
            
            segmentedControl.action = #selector(self.segmentedViewAction)
        }
        
        showTab(withIndex: 0)
    }
    
    @objc
    func segmentedViewAction() {
        print("triggered")
        
        let toolbarItem = view.window?.toolbar?.items.item(at: 1)
        let segmentedControl = toolbarItem?.view! as! NSSegmentedControl
        
        if segmentedControl.selectedSegment != self.segmentedControlCurrentIndex {
            self.segmentedControlCurrentIndex = segmentedControl.selectedSegment
            self.showTab(withIndex: self.segmentedControlCurrentIndex)
        }
    }
    
    func showTab(withIndex index: Int) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let name = segmentedControlViewControllerNames.item(at: index)
        
        print("navigating to '\(name)'")
        
        let sceneIdentifier = NSStoryboard.SceneIdentifier(rawValue: name)
        let viewController = storyboard.instantiateController(withIdentifier: sceneIdentifier) as! NSViewController
        
        addChildViewController(viewController)
        
        var windowFrame = view.window?.frame
        windowFrame?.size.width = viewController.view.frame.width
        windowFrame?.size.height = viewController.view.frame.height
        
        
        self.view.window?.setFrame(windowFrame!, display: true)
        //viewController.view.frame = mainContainerView.bounds
        mainContainerView.subviews.removeAll()
        mainContainerView.addSubview(viewController.view)
    }
}
