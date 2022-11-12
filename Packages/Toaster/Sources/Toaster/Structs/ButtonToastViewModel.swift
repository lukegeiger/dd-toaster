//
//  ButtonToastViewModel.swift
//  Toast
//
//  Created by Luke Geiger on 11/10/22.
//

import Foundation

//MARK: ButtonToastViewModel

/*
 A View model that describes how a button should look and perform inside of a ToastView
 */
public struct ButtonToastViewModel {
    
    //MARK: Properties

    /// Optionally add an a accessabilityMessage describing the button property.
    let accessabilityButtonText: String?
    
    /// The text to be displayed in the toast button
    let buttonText: String
    
    /// A callback to get for when a toasts button was tapped
    let onTap: (_ sender: ToastView) -> Void
    
    //MARK: Inits

    /**
     Initializes a ButtonToastViewModel
     
     - Parameter accessabilityButtonText: Optionally add an a accessabilityMessage describing the button property.
     - Parameter buttonText: The text to be displayed in the toast button
     - Parameter onTap: A callback to get for when a toasts button was tapped
     */
    public init(accessabilityButtonText: String? = nil ,
                buttonText: String,
                onTap: @escaping (_: ToastView) -> Void) {
        self.accessabilityButtonText = accessabilityButtonText
        self.buttonText = buttonText
        self.onTap = onTap
    }
}
