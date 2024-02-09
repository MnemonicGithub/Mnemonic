//
//  UINavigationMap.swift
//  mainApp
//
//  Created by Andy on 1/22/24.
//

import Foundation
import SwiftUI

public struct PathInfo {
    @EnvironmentObject var dataBox: DataBox
    
    static let landingPageViewValue: Int = 1
    static let landingPageViewFrame = LandingPageView()
    
    static let backupViewValue: Int = 2
    static let backupViewSetMnemonicValue: Int = 21
    static let backupViewSetPasswordValue: Int = 22
    static let backupViewStartBackup: Int = 23
    static let backupViewFrame = BackupView()
    static let backupViewSetMnemonicFrame = bvSetMnemonicView()
    static let backupViewSetPasswordFrame = bvSetPasswordView()
    static let backupViewStartBackFrame = bvStartBackView()
    
    static let cloneViewValue: Int = 3
//    static let cloneViewStartReadValue: Int = 31
//    static let cloneViewStartCloneValue: Int = 32
    static let cloneViewFrame = CloneView()
//    static let cloneViewStartReadFrame = cvStartReadView()
//    static let cloneViewStartCloneFrame = cvStartCloneView()

    
    static let restoreViewValue: Int = 4
//    static let restoreViewStartReadValue: Int = 41
    static let restoreViewShowMnemonicValue: Int = 42
    static let restoreViewFrame = RestoreView()
//    static let restoreViewStartReadFrame = rvStartReadView()
    static let restoreViewShowMnemonicFrame = rvShowMnemonicView()
    
    static func gotoLink(viewValue: Int) -> some View {
        
        switch viewValue {
          
        // Never call LandingPage again.
        //case PathInfo.landingPageViewValue:
        //    return AnyView(PathInfo.landingPageViewFrame)
            
        case PathInfo.backupViewValue:
            return AnyView(PathInfo.backupViewFrame)
        case PathInfo.backupViewSetMnemonicValue:
            return AnyView(PathInfo.backupViewSetMnemonicFrame)
        case PathInfo.backupViewSetPasswordValue:
            return AnyView(PathInfo.backupViewSetPasswordFrame)
        case PathInfo.backupViewStartBackup:
            return AnyView(PathInfo.backupViewStartBackFrame)
            
        case PathInfo.cloneViewValue:
            return AnyView(PathInfo.cloneViewFrame)
//        case PathInfo.cloneViewStartReadValue:
//            return AnyView(PathInfo.cloneViewStartReadFrame)
//        case PathInfo.cloneViewStartCloneValue:
//            return AnyView(PathInfo.cloneViewStartCloneFrame)
            
        case PathInfo.restoreViewValue:
            return AnyView(PathInfo.restoreViewFrame)
//        case PathInfo.restoreViewStartReadValue:
//            return AnyView(PathInfo.restoreViewStartReadFrame)
        case PathInfo.restoreViewShowMnemonicValue:
            return AnyView(PathInfo.restoreViewShowMnemonicFrame)
            
        default:
            return AnyView(EmptyView())
        }
    }
}

// MARK: - Fix Hide navigation bar button without losing swipe back gesture in SwiftUI

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
