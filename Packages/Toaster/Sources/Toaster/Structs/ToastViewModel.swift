//
//  ToastViewModel.swift
//  Toast
//
//  Created by Luke Geiger on 11/10/22.
//

import Foundation
import UIKit

//MARK: ToastViewModel

/*
 ToastViewModel is the root view model that contains information that will be displayed in a toast. We could add more customization options to this in the future.
 */
public struct ToastViewModel {
    
    //MARK: Properties

    /// Optionally add an a accessabilityMessage describing the message property.
    let accessabilityMessageLabel: String?
    
    /// The required prompt to display in a toast that displays below the title.
    let message: String
    
    /// An optional icon to display on the left side of the toast.
    let icon: UIImage?
    
    /// Optionally add an a accessabilityMessage describing the icon property.
    let accesabilityIconLabel:String?
    
    /// The title of the host that is displayed above the message.
    let title: String?
    
    /// Optionally add an a accessabilityTitle describing the title property.
    let accesabilityTitleLabel:String?
    
    /// If there is to be a button attached to this Toast provide a buttonViewModel.
    let buttonViewModel: ButtonToastViewModel?
    
    /// A optional callback for when the toast is swiped.
    let onSwipe: ((_ sender: ToastView) -> Void?)?

    //MARK: Inits

    /**
     Initializes a ToastViewModel
     
     - Parameter message: The required prompt to display in a toast that displays below the title.
     - Parameter accessabilityMessage: Optionally add an a accessabilityMessage describing the message property.
     - Parameter icon: An optional icon to display on the left side of the toast.
     - Parameter accesabilityIconLabel: Optionally add an a accessabilityMessage describing the icon property.
     - Parameter title: The title of the host that is displayed above the message.
     - Parameter accessabilityTitle: Optionally add an a accessabilityTitle describing the title property.
     - Parameter buttonViewModel:  If there is to be a button attached to this Toast provide a buttonViewModel.
     - Parameter onSwipe: A optional callback for when the toast is swiped.     
     */
    public init(message: String,
                accessabilityMessageLabel: String? = nil,
                icon: UIImage? = nil,
                accessibilityIconLabel: String? = nil,
                title: String? = nil,
                accessabilityTitleLabel: String? = nil,
                buttonViewModel: ButtonToastViewModel? = nil,
                onSwipe: ((_ sender: ToastView) -> Void?)? = nil) {
            self.message = message
            self.accessabilityMessageLabel = accessabilityMessageLabel
            self.icon = icon
            self.accesabilityIconLabel = accessibilityIconLabel
            self.title = title
            self.accesabilityTitleLabel = accessabilityTitleLabel
            self.buttonViewModel = buttonViewModel
            self.onSwipe = onSwipe
    }
}
