//
//  PresentationStyle.swift
//  Toast
//
//  Created by Luke Geiger on 11/10/22.
//

import Foundation

//MARK: PresentationStyle

/*
 PresentationStyle tells the Toaster to either fit the Toast to fit the width of the screen, or display naturally just enough to fit it;s content.
 */
public enum PresentationStyle {
    case fitScreen /// tells the toast to fit the width of the screen, even if that means if it does not need it.
    case natural /// tells the toast to fit its content no matter how big or small it is.
}
