//
//  Toast.swift
//  Toast
//
//  Created by Luke Geiger on 11/10/22.
//

import Foundation
import UIKit

//MARK: Toaster

/**
    Welcome to the Toaster! To display and or hide a toast please see the Public Implementation mark.
 */
public class Toaster {

    //MARK: Toaster Animation Consts
    static private let ToasterFullWidthPadding = (UIScreen.main.bounds.size.width - 40)
    static private let ToasterPresentationAnimationTime = 0.50
    static private let ToasterDismissalAnimationTime = 1.0
    static private let ToasterAnimationDelay = 0.0
    static private let ToasterAnimationSpringDamping = 0.60
    static private let ToasterAnimationVelocity = 1.0
}

//MARK: Toaster Public Implementation

extension Toaster {
    
    /**
     Displays a toast in the view. The toast will present its self based on the configuration of presentationBehavior and optionally auto dismiss itself based on the properties on of the autoDismiss tuple. If you don't choose to auto dismiss, you can take advantage of the disrecardableResult, which will be an instance of ToastView. From there you can have more control over the dismissal by firing dismiss
     
     - Parameter toastViewModel: The ToastView UI will be populated from the properties on this model.
     - Parameter presentationBehavior: Describes how you want to the toast to appear
     - Parameter in: The view in which you want to display the toast
     - Parameter autoDismiss: A tuple containing secondsToDismiss which tells the system to how many seconds after presented to dismiss the toast. The second parameter is   dismissalBehavior which lets the dismiss animation know which direction to dismiss the toast.
     
     - Returns: A reference to the instance of the toast that was presented. Note this is a @discardableResult.

     */
     @discardableResult public static func toast(toastViewModel: ToastViewModel,
                                                 presentationBehavior: PresentationBehavior,
                                                 in view: UIView,
                                                 autoDismiss: (secondsToDismiss: DispatchTime, dismissalBehavior: DismissalBehavior)? = nil) -> ToastView {
        
        let toastView = createToastView(with: toastViewModel,
                                       in: view)
        
        setupConstraints(for: toastView,
                         with: presentationBehavior,
                         in: view)
        
         animate(toastView: toastView,
                 direction: .bottom,
                 in: view,
                 duration: ToasterPresentationAnimationTime,
                 type: .present) {
             if let autoDismiss = autoDismiss {
                 queueDismissal(of: toastView,
                                withDismissalBehavior: autoDismiss.dismissalBehavior,
                                afterSeconds: autoDismiss.secondsToDismiss,
                                inView: view)
             }
         }
                 
        return toastView
    }
    
    /**
     Dismisses the instance of a ToastView.
     
     - Parameter toastView: The ToastView to dismiss
     - Parameter in: The view in which you want to dismiss from
     - Parameter withDismissal: Lets the animation know how you would like the toast to dismiss
     */
    public static func dismiss(toastView: ToastView,
                               in view: UIView,
                               withDismissalBehavior: DismissalBehavior) {
        
        animate(toastView: toastView,
                direction: .bottom,
                in: view,
                duration: ToasterDismissalAnimationTime,
                type: .dismiss,
                onCompletion: nil)
    }
}

// MARK: Toaster Private Implementation

extension Toaster {
    
    /**
     Sets the constraints for the provided toastView. Currently toasts can be displayed in two ways, either full screen or natural width. If natural width, the toast will be sized just enough to fit the content of the toastView plus the hardcoded minimum padding on the edges (See ToastView internals). If full width, the toast will be sized to fit the width of the screen with the minimum padding from ToasterFullWidthPadding.
     
     - Parameter toastView: The toast view to set constraints for.
     - Parameter presentationBehavior: Select full width to have your toast fit the width of the screen, otherwise select natural for the toast to fit its content.
     - Parameter view: The view in which to constrain this view to.
     */
    private static func setupConstraints(for toastView: ToastView,
                                         with presentationBehavior: PresentationBehavior,
                                         in view :UIView) {
        
        let toastSize = toastView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize) // gets min size needed.
        let toastCenterXConstraint = toastView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let toastTopConstraint = toastView.topAnchor.constraint(equalTo: view.bottomAnchor,
                                                                constant: toastSize.height)
                
        switch presentationBehavior.style {
        case .fitScreen:
            // if we are fitting screen, there is a width constraint with horizontal padding
            let toastWidthConstraint = toastView.widthAnchor.constraint(equalToConstant: Toaster.ToasterFullWidthPadding)
            NSLayoutConstraint.activate([toastTopConstraint, toastCenterXConstraint, toastWidthConstraint])
        case .natural:
            // if we are going natural, there is no need for a width constraint. Warning, if content is too big, the view will not fit on screen! TODO add a min width?
            NSLayoutConstraint.activate([toastTopConstraint, toastCenterXConstraint])
        }
    }
    
    /**
     Creates an instance of a ToastView that is populated with the data provided in toastViewModel.
     
     - Parameter toastViewModel: The ToastView UI will be populated from the properties on this model.
     - Parameter view: The view in which to place the toast.
     
     - Returns: A configured ToastView
     */
    private static func createToastView(with toastViewModel: ToastViewModel,
                                        in view:UIView) -> ToastView {
        let toastView = ToastView(toastViewModel: toastViewModel)
        toastView.delegate = ToasterToastViewDelegateImpl()
        toastView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toastView)
        return toastView
    }
    
    /**
     Dismisses the toast view in the way described from dismissalBehavior & removes it from screen. Note this dismiss queues a main thread animation after the dismissalTime from dismissalBehavior.
     
     - Parameter toastView: The ToastView to dismiss.
     - Parameter dismissalBehavior: Describes how the dismissal should take place.
     - Parameter afterSeconds: Describes how many seconds to go by before the dismissal.
     - Parameter view: The view in which the hide will take place.
     */
    static private func queueDismissal(of toastView: ToastView,
                                       withDismissalBehavior dismissalBehavior: DismissalBehavior,
                                       afterSeconds dispatchTime:DispatchTime,
                                       inView view:UIView) {
        // Wait dispatchTime in seconds, then perform the animation on the main thread.
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            
            Toaster.dismiss(toastView: toastView,
                            in: view,
                            withDismissalBehavior: dismissalBehavior)
     
        }
    }
}

// MARK: Toaster FilePrivate Implementation

extension Toaster {
        
    /**
     Animates ToastView inside the view provided. Note, you can use this function to animate in our out. Note this function is not responsible for adding or removing the toastView parameter  to screen.
     
     - Parameter toastView: The person being greeted.
     - Parameter direction: The direction to animate.
     - Parameter view: The person being greeted.
     - Parameter duration: The person being greeted.
     - Parameter type: The person being greeted.
     - Parameter onCompletion: A completion block for when the operation is completed.
     */
    private static func animate(toastView: ToastView,
                                direction: AnitmationDirection,
                                in view: UIView,
                                duration: TimeInterval,
                                type: AnimationType,
                                onCompletion:(()  -> Void)?) {
        guard let animationTuple = constraintToAnimate(goingInDirection: direction,
                                                       type: type,
                                                       toastView: toastView) else {
            return
        }
        
        view.layoutIfNeeded()
        UIView.animate(withDuration: duration,
                       delay: Toaster.ToasterAnimationDelay,
                       usingSpringWithDamping: Toaster.ToasterAnimationSpringDamping,
                       initialSpringVelocity: Toaster.ToasterAnimationVelocity,
                       options: .curveEaseInOut,
                       animations: {
            animationTuple.constraint.constant =  animationTuple.constant
            view.layoutIfNeeded()
        }) { _ in
            if type == .dismiss {
                toastView.removeFromSuperview()
            }
            if let onCompletion = onCompletion {
                onCompletion()
            }
        }
    }
    
    /**
     Finds the appropriate constraint to animate on the toast and determines where it should animate to.
     
     - Parameter goingInDirection: The direction the animation is going to go.
     - Parameter type: The type of animation this is.
     - Parameter toastView: The view to perform the animation on.
     
     - Returns: A tuple of information containing what constraint to animate, what to animate it to, based on the type of animation and direction.
     */
    private static func constraintToAnimate(goingInDirection direction: AnitmationDirection,
                                            type: AnimationType,
                                            toastView: ToastView) -> (constraint: NSLayoutConstraint, constant: CGFloat)? {
        let toastSize = toastView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        guard let topConstraint = toastView.findConstraint(layoutAttribute: .top) else {
            return nil
        }

        switch (type, direction) {
        case (.dismiss, .bottom):
            let endingVal = toastSize.height
            return (topConstraint, endingVal)
        case (.present, .bottom):
            let endingVal = -toastSize.height * 2
            return (topConstraint, endingVal)
        }
    }
}

// MARK: ToasterToastViewDelegateImpl

/*
 ToasterToastViewDelegateImpl is a concrete implementation of ToastViewDelegate it is used by being attached to a ToastView instance when being toasted and animating into a view.
 */
private class ToasterToastViewDelegateImpl: ToastViewDelegate {
    
    fileprivate func toastViewTappedButton(sender: ToastView) {
        if let toastButtonAction = sender.toastViewModel.buttonViewModel?.onTap {
            toastButtonAction(sender)
        }
    }
    
    fileprivate func toastViewDetectedSwipe(sender: ToastView) {
        if let toastSwipeAction = sender.toastViewModel.onSwipe {
            toastSwipeAction(sender)
        }
    }
}

// MARK: View Helpers

extension UIView {
    fileprivate func findConstraint(layoutAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
                return constraint
            }
        }
        return nil
    }

    fileprivate func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        let firstItemMatch = constraint.firstItem as? UIView == self && constraint.firstAttribute == layoutAttribute
        let secondItemMatch = constraint.secondItem as? UIView == self && constraint.secondAttribute == layoutAttribute
        return firstItemMatch || secondItemMatch
    }
}
