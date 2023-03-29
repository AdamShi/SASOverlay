//
//  Overlay.swift
//  RightBTC
//
//  Created by Haiping Wu on 2021/1/21.
//  Copyright © 2021 LYX. All rights reserved.
//

import Foundation
import SwiftEntryKit;

public class Overlay : NSObject {
//    @objc var name = "abc"
//    @objc static func action() -> Int {
//        return 101
//    }

//    public typealias DismissCompletionHandler = () -> Void
   
    // MARK: Entry
    // 显示在屏幕中间, 点周围无效果 且 视图不消失, 选择后手动消失
    // 后来的会隐藏前面的
    @objc public static func entryAlert(_ view: UIView)
    {
        var attributes = EKAttributes()
        //attributes.windowLevel = .statusBar
        attributes.position = .center
        //attributes.precedence = .override(priority: .normal, dropEnqueuedEntries: false)
        attributes.displayDuration = .infinity
        attributes.positionConstraints.size =
            EKAttributes.PositionConstraints.Size(width: .ratio(value: 1.0), height: .intrinsic)
        attributes.screenInteraction = .absorbTouches
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .disabled
        attributes.screenBackground = .color(color: EKColor(red: 0, green: 0, blue: 0).with(alpha: 0.5))
        //attributes.hapticFeedbackType = .none
        //attributes.displayMode = .inferred
        //attributes.entryBackground = .clear
        //attributes.screenBackground = .clear
        //attributes.shadow = .none
        //attributes.roundCorners = .none
        //attributes.border = .none
        //attributes.statusBar = .inferred
        //attributes.popBehavior = .overridden

        let spring = EKAttributes.Animation.Spring(damping: 1, initialVelocity: 0)
        let translate = EKAttributes.Animation.Translate(duration: 0, spring: spring)
        let animation = EKAttributes.Animation(translate: translate)
      
        attributes.entranceAnimation = animation
        attributes.exitAnimation = animation

        SwiftEntryKit.display(entry: view, using: attributes, presentInsideKeyWindow: true, rollbackWindow: .main)
    }
    // 显示在屏幕下边, 点周围无效果 可以 视图不动/消失, 选择后手动消失
    // 后来的会隐藏前面的
    @objc public static func entrySheet(_ view: UIView,
                                 top: Bool = true,
                                 offset: CGFloat = 0.0,
                                 round: CGFloat = 0.0,
                                 bgcolor: Int = 0xffffff,
                                 dismiss: Bool = true,
                                 cancelled: EKAttributes.UserInteraction.Action? = nil)
    {
        for window in UIApplication.shared.windows {
            window.endEditing(true)
        }

        var attributes = EKAttributes()
        //attributes.windowLevel = .statusBar
        if top {
            attributes.position = .top
        } else {
            attributes.position = .bottom
        }

        //attributes.precedence = .override(priority: .normal, dropEnqueuedEntries: false)
        attributes.displayDuration = .infinity
        attributes.positionConstraints.size =
            EKAttributes.PositionConstraints.Size(width: .ratio(value: 1.0), height: .intrinsic)
        attributes.positionConstraints.verticalOffset = offset
        attributes.positionConstraints.safeArea = .overridden
        if dismiss {
            attributes.screenInteraction = .dismiss
        } else {
            attributes.screenInteraction = .absorbTouches
        }
        if let cancelled = cancelled {
            attributes.screenInteraction.customTapActions.append(cancelled)
        }
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .disabled
       
        //attributes.hapticFeedbackType = .none
        //attributes.displayMode = .inferred
        //attributes.entryBackground = .clear
        //attributes.screenBackground = .clear
        //attributes.shadow = .none
        //attributes.roundCorners = .none
        //attributes.border = .none
        //attributes.statusBar = .inferred
        //attributes.popBehavior = .overridden
        attributes.screenBackground = .color(color: EKColor(red: 0, green: 0, blue: 0).with(alpha: 0.5))
        attributes.entryBackground = .color(color: EKColor(red: bgcolor>>16 & 0xff, green: bgcolor>>8 & 0xff, blue: bgcolor & 0xff))
        if round > 0 {
            if top {
                attributes.roundCorners = .bottom(radius: round)
            } else {
                attributes.roundCorners = .top(radius: round)
            }
        }

        let spring = EKAttributes.Animation.Spring(damping: 1, initialVelocity: 0)
        let translate = EKAttributes.Animation.Translate(duration: 0.25, spring: spring)
        let animation = EKAttributes.Animation(translate: translate)
        attributes.entranceAnimation = animation
        attributes.exitAnimation = animation

        SwiftEntryKit.display(entry: view, using: attributes, presentInsideKeyWindow: false, rollbackWindow: .main)
    }
    
    //显示几秒后消失，周围可以点击
    @objc public static func entrySheetHide(_ view: UIView,
                                 top: Bool = true,
                                 offset: CGFloat = 0.0,
                                 round: CGFloat = 0.0,
                                 bgcolor: Int = 0xffffff,
                                 dismiss: Bool = true,
                                 cancelled: EKAttributes.UserInteraction.Action? = nil)
    {
        for window in UIApplication.shared.windows {
            window.endEditing(true)
        }

        var attributes = EKAttributes()
        if top {
            attributes.position = .top
        } else {
            attributes.position = .bottom
        }
        
        attributes.displayDuration = 4
        attributes.positionConstraints.size =
            EKAttributes.PositionConstraints.Size(width: .ratio(value: 1.0), height: .intrinsic)
        attributes.positionConstraints.verticalOffset = offset
        attributes.positionConstraints.safeArea = .overridden
        if dismiss {
            attributes.screenInteraction = .dismiss
        } else {
            attributes.screenInteraction = .absorbTouches
        }
        if let cancelled = cancelled {
            attributes.screenInteraction.customTapActions.append(cancelled)
        }
        attributes.entryBackground = .color(color: EKColor(red: bgcolor>>16 & 0xff, green: bgcolor>>8 & 0xff, blue: bgcolor & 0xff))
        if round > 0 {
            if top {
                attributes.roundCorners = .bottom(radius: round)
            } else {
                attributes.roundCorners = .top(radius: round)
            }
        }

        let spring = EKAttributes.Animation.Spring(damping: 1, initialVelocity: 0)
        let translate = EKAttributes.Animation.Translate(duration: 0.25, spring: spring)
        let animation = EKAttributes.Animation(translate: translate)
        attributes.entranceAnimation = animation
        attributes.exitAnimation = animation

        SwiftEntryKit.display(entry: view, using: attributes, presentInsideKeyWindow: false, rollbackWindow: .main)
    }
    
    
    @objc public static func entryAlert(_ view: UIView, dismiss: Bool = true)
    {
        for window in UIApplication.shared.windows {
            window.endEditing(true)
        }

        var attributes = EKAttributes()
        attributes.position = .center
        attributes.displayDuration = .infinity
        attributes.positionConstraints.size =
            EKAttributes.PositionConstraints.Size(width: .ratio(value: 1.0), height: .intrinsic)
        if dismiss {
            attributes.screenInteraction = .dismiss
        } else {
            attributes.screenInteraction = .absorbTouches
        }
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .disabled
        attributes.screenBackground = .color(color: EKColor(red: 0, green: 0, blue: 0).with(alpha: 0.5))
        
        let spring = EKAttributes.Animation.Spring(damping: 1, initialVelocity: 0)
        let translate = EKAttributes.Animation.Translate(duration: 0, spring: spring)
        let animation = EKAttributes.Animation(translate: translate)
      
        attributes.entranceAnimation = animation
        attributes.exitAnimation = animation

        SwiftEntryKit.display(entry: view, using: attributes, presentInsideKeyWindow: false, rollbackWindow: .main)
    }
    
    @objc public static func entryHide(_ completion: SwiftEntryKit.DismissCompletionHandler? = nil) {
        SwiftEntryKit.dismiss(.all, with: completion)
    }
    
  
}
