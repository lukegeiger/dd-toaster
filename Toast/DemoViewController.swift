//
//  ViewController.swift
//  Toast
//
//  Created by Luke Geiger on 11/10/22.
//

import UIKit
import Toaster

//MARK: DemoViewController

/*
 DemoViewController is a sample project showcasing the Toaster framework.
 */
final class DemoViewController: UIViewController {
        
    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // See README.md for more options, and learn about Toaster's flexability!

        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toast",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(showToast))
    }
}

//MARK: Private Implementation

extension DemoViewController {

    @objc private func showToast() {
        
        // Grabbing a random system icon. These are pretty cool?!
        let config = UIImage.SymbolConfiguration(textStyle: .title3)
        let icon = UIImage(systemName: "heart.fill", withConfiguration: config)
        
        // Set up what the button should display, if you do not want a button pass in nil to toastViewModel.
        let buttonToastViewModel = ButtonToastViewModel(buttonText: "Button") { toastView in
            Toaster.dismiss(toastView: toastView, in: self.view, withDismissalBehavior: DismissalBehavior(dismissalDirection: .bottom))
        }
        
        // Set up what the contents of the Toast should be, all params are option except for the message. Taking away the param will disable it from showing.
        let toastViewModel = ToastViewModel(message: "hello", icon: icon, title: "title", buttonViewModel: buttonToastViewModel, onSwipe: { toastView in
            Toaster.dismiss(toastView: toastView, in: self.view, withDismissalBehavior: DismissalBehavior(dismissalDirection: .bottom))
        })
        
        // PresentationBehavior determines if you want the Toast to display edge to edge (fit screen) or lay out to fit its contents (.natural). You can also pass in a direction from where you want the toast to present from (only bottom for now)
        let presentationBehavior = PresentationBehavior(style: .fitScreen)
        
        // DismissalBehavior is an anticapatory abstraction to have a place to control where the toast can show and hide from.
        let dismissalBehavior = DismissalBehavior(dismissalDirection: .bottom)
        
        // I made a decision not to tightly couple the auto dismiss into the framework and rather make it an optional parameter. This way you can have a toast stay on for a dynamic amount of time if you need.
        let autoDismissTime = DispatchTime.now() + .seconds(4)
        let autoDismiss = (autoDismissTime, dismissalBehavior) // optional parameter
        
        // Toasts the toast! This call returns a disrecardableResult of an instance of the toastview in case you need a reference or want to custom dismiss it later.
        Toaster.toast(toastViewModel: toastViewModel,
                      presentationBehavior: presentationBehavior,
                      in: self.view,
                      autoDismiss: autoDismiss)
        
    }
}

