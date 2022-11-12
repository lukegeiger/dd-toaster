//
//  PresentationBehavior.swift
//  Toast
//
//  Created by Luke Geiger on 11/10/22.
//

import Foundation

//MARK: PresentationBehavior

/*
 PresentationBehavior is an abstraction that will allow the consumer of this API to control how a presentation works of a Toast. In the future, this could contain properties about the animation, etc.
 */
public struct PresentationBehavior {
    
    //MARK: Properties

    /// The direction an animation for a toast should go begin.
    let presentationDirection: AnitmationDirection
    
    /// The way a toast should size itself
    let style: PresentationStyle
    
    //MARK: Inits

    /**
     Initializes a PresentationBehavior
     
     - Parameter presentationDirection: The direction an animation for a toast should go begin.
     - Parameter style: The way a toast should size itself
     */
    public init(presentationDirection: AnitmationDirection = .bottom, style: PresentationStyle) {
        self.presentationDirection = presentationDirection
        self.style = style
    }
}
