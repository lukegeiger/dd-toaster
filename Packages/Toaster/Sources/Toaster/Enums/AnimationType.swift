//
//  PresentationType.swift
//  Toast
//
//  Created by Luke Geiger on 11/11/22.
//

import Foundation


//MARK: AnimationType

/*
Toaster supports two types of animations, either presenting the toast, or dismissing the toast.
 */
public enum AnimationType {
    case present /// tells the animation of a toast that it is presenting.
    case dismiss /// tells the animation of a toast that it is dismissing.
}
