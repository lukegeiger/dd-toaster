//
//  DismissalBehavior.swift
//  Toast
//
//  Created by Luke Geiger on 11/10/22.
//

import Foundation

//MARK: DismissalBehavior

/*
 DismissalBehavior is an abstraction that will allow the consumer of this API to control how a dismissal works of a Toast. In the future, this could contain properties about the animation, etc.
 */
public struct DismissalBehavior {
    
    //MARK: Properties

    /// The direction an animation for a toast should end with.
    let dismissalDirection: AnitmationDirection
    
    //MARK: Inits

    /**
     Initializes a DismissalBehavior
     
     - Parameter dismissalDirection: The direction an animation for a toast should end with.
     */
    public init(dismissalDirection: AnitmationDirection = .bottom) {
        self.dismissalDirection = dismissalDirection
    }
}

