//
//  ToasterTests.swift
//  ToasterTests
//
//  Created by Luke Geiger on 11/10/22.
//

import XCTest
@testable import Toaster

final class ToasterTests: XCTestCase {

    /*
     Tests to see if a toast is added to a view.
     */
    func testToast() {
        
        let buttonToastViewModel = ButtonToastViewModel(buttonText: "button") {_ in
            
        }
        
        let mockToastViewModel = ToastViewModel(message: "message",
                                                icon: nil,
                                                title: "title",
                                                buttonViewModel: buttonToastViewModel)
        
        let mockPresentationBehavior = PresentationBehavior(presentationDirection: .bottom, style: .fitScreen)
        
        let mockView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                        
        XCTAssertTrue(mockView.subviews.count == 0)
        
        Toaster.toast(toastViewModel: mockToastViewModel,
                      presentationBehavior: mockPresentationBehavior,
                      in: mockView)
        
        XCTAssertTrue(mockView.subviews.count == 1)
    }
    
    /*
     Tests to see if a toast when added to a view, properly removes it.
     */
    func testHideToast() {
        
        let mockToastViewModel = ToastViewModel(message: "message",
                                                icon: nil,
                                                title: "title",
                                                buttonViewModel: nil)
        
        let mockPresentationBehavior = PresentationBehavior(presentationDirection: .bottom, style: .fitScreen)
        
        let mockView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                                
        let myToastView = Toaster.toast(toastViewModel: mockToastViewModel,
                                        presentationBehavior: mockPresentationBehavior,
                                        in: mockView)
        
        let mockDismissalBehavior = DismissalBehavior(dismissalDirection: .bottom)
        
        Toaster.dismiss(toastView: myToastView, in: mockView, withDismissalBehavior: mockDismissalBehavior)
                
        let timeInSeconds = 3.0 // time you need for other tasks to be finished
        let expectation = XCTestExpectation(description: "ToasterRemoveFromSuperWaitException")
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeInSeconds + 1.0)
        
        XCTAssertTrue(myToastView.superview == nil)
        XCTAssertTrue(mockView.subviews.count == 0)
    }
    
    /*
     Tests to see if a toast will auto dissmiss and be removed propery.
     */
    func testToastAutoDismiss() {
        
        let mockToastViewModel = ToastViewModel(message: "message",
                                                icon: nil,
                                                title: nil,
                                                buttonViewModel: nil)
        
        let mockPresentationBehavior = PresentationBehavior(presentationDirection: .bottom, style: .fitScreen)
        let mockView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let mockDismissalBehavior = DismissalBehavior(dismissalDirection: .bottom)
        let dispatchTime = DispatchTime.now() + .seconds(1)
        let autoDismissTuple = (dispatchTime, mockDismissalBehavior)
        let mockToastView = Toaster.toast(toastViewModel: mockToastViewModel,
                                          presentationBehavior: mockPresentationBehavior,
                                          in: mockView,
                                          autoDismiss: autoDismissTuple)
        XCTAssertTrue(mockView.subviews.count == 1)
        let timeInSeconds = 3.0 // time you need for other tasks to be finished
        let expectation = XCTestExpectation(description: "ToasterRemoveFromSuperWaitException")
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: timeInSeconds + 1.0)
        
        XCTAssertTrue(mockToastView.superview == nil)
        XCTAssertTrue(mockView.subviews.count == 0)
    }
    
    /*
     Tests constraints of a toast when fitting to screen
     */
    func testConstraintsWhenPresentedToFitScreen() {
        
        let buttonToastViewModel = ButtonToastViewModel(buttonText: "button") {_ in 
            
        }
        
        let mockToastViewModel = ToastViewModel(message: "message",
                                                icon: nil,
                                                title: "title",
                                                buttonViewModel: buttonToastViewModel)
        
        let mockPresentationBehavior = PresentationBehavior(presentationDirection: .bottom, style: .fitScreen)
        
        let mockView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        let displayedToast = Toaster.toast(toastViewModel: mockToastViewModel, presentationBehavior: mockPresentationBehavior, in: mockView)
        
        let size = displayedToast.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        XCTAssertTrue(size.width == 390.0)
        XCTAssertTrue(size.height == 58.0)
    }
    
    /*
     Tests constraints of a toast when natural
     */
    func testConstraintsWhenPresentedToFitNaturally() {
        
        let buttonToastViewModel = ButtonToastViewModel(buttonText: "button") {_ in 
            
        }
        
        let mockToastViewModel = ToastViewModel(message: "message",
                                                icon: nil,
                                                title: "title",
                                                buttonViewModel: buttonToastViewModel)
        
        let mockPresentationBehavior = PresentationBehavior(presentationDirection: .bottom, style: .natural)
        
        let mockView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        
        let displayedToast = Toaster.toast(toastViewModel: mockToastViewModel, presentationBehavior: mockPresentationBehavior, in: mockView)
        
        let size = displayedToast.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        
        XCTAssertTrue(size.width < UIScreen.main.bounds.width)
        XCTAssertTrue(size.height > 0)
    }
}
