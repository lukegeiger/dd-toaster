//
//  ToastViewTests.swift
//  ToastTests
//
//  Created by Luke Geiger on 11/11/22.
//


import XCTest
@testable import Toaster

final class ToastViewTests: XCTestCase {

    /*
     Tests to see if constraints are set up correctly with expected input.
     */
    func testToastViewConstraintsExpectedInputs() throws {

        let buttonToastViewModel = ButtonToastViewModel(buttonText: "button") {_ in 
            
        }
        
        let mockToastViewModel = ToastViewModel(message: "message",
                                                icon: nil,
                                                title: "title",
                                                buttonViewModel: buttonToastViewModel)
        
        let toastView = ToastView(toastViewModel: mockToastViewModel)
        
        let size = toastView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        XCTAssertTrue(size.width > 0)
        XCTAssertTrue(size.height > 0)
    }
    
    /*
     Tests to see if constraints are set up correctly with no title.
     */
    func testToastViewConstraintsNoTitle() throws {

        let buttonToastViewModel = ButtonToastViewModel(buttonText: "button") {_ in 
            
        }
        
        let mockToastViewModel = ToastViewModel(message: "message",
                                                icon: nil,
                                                title: nil,
                                                buttonViewModel: buttonToastViewModel)
        
        let toastView = ToastView(toastViewModel: mockToastViewModel)
        
        let size = toastView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        XCTAssertTrue(size.width > 0)
        XCTAssertTrue(size.height > 0)
    }
    
    /*
     Tests to see if constraints are set up correctly with no image.
     */
    func testToastViewConstraintsNoImage() throws {

        let buttonToastViewModel = ButtonToastViewModel(buttonText: "button") {_ in 
            
        }
        
        let mockToastViewModel = ToastViewModel(message: "message",
                                                icon: nil,
                                                title: "title",
                                                buttonViewModel: buttonToastViewModel)
        
        let toastView = ToastView(toastViewModel: mockToastViewModel)
        
        let size = toastView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        XCTAssertTrue(size.width > 0)
        XCTAssertTrue(size.height > 0)
    }
    
    /*
     Tests to see if constraints are set up correctly with no button.
     */
    func testToastViewConstraintsNoButton() throws {
        
        let mockToastViewModel = ToastViewModel(message: "message",
                                                icon: nil,
                                                title: "title",
                                                buttonViewModel: nil)
        
        let toastView = ToastView(toastViewModel: mockToastViewModel)
        
        let size = toastView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        XCTAssertTrue(size.width > 0)
        XCTAssertTrue(size.height > 0)
    }
    
    /*
     Tests to see if constraints are set up correctly with message only.
     */
    func testToastViewConstraintsMessageOnly() throws {
        
        let mockToastViewModel = ToastViewModel(message: "message",
                                                icon: nil,
                                                title: nil,
                                                buttonViewModel: nil)
        
        let toastView = ToastView(toastViewModel: mockToastViewModel)
        
        let size = toastView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        XCTAssertTrue(size.width > 0)
        XCTAssertTrue(size.height > 0)
    }
}
