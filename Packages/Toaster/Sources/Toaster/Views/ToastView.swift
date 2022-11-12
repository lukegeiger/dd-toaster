//
//  ToastView.swift
//  Toast
//
//  Created by Luke Geiger on 11/10/22.
//

import Foundation
import UIKit

// MARK: ToastViewDelegate

/**
 ToastViewDelegate is responsible for handling callbacks on ToastViews .
 */
public protocol ToastViewDelegate: AnyObject {
    
    /**
     Will be called with the button on ToastView button is tapped.
     
     - Parameter sender: The toast that was tapped.
     */
    func toastViewTappedButton(sender: ToastView)
    
    /**
     Will be called if the ToastView detects a swipe.
     
     - Parameter sender: The toast that was swiped.
     */
    func toastViewDetectedSwipe(sender: ToastView)
}

// MARK: ToastView


public final class ToastView: UIView {
        
    // MARK: Public
    
    public let toastViewModel: ToastViewModel
    public var delegate: ToastViewDelegate?
    
    // MARK: Private

    private let titleLabel = UILabel(frame: .zero)
    private let messageLabel = UILabel(frame: .zero)
    private let button = UIButton(type: .custom)
    private let iconImageView = UIImageView(frame: .zero)
    private let rootContainerStack = UIStackView(frame: .zero)
    private let messageTitleLabelStack = UIStackView(frame: .zero)
    private var swipeGesture: UISwipeGestureRecognizer?
    
    // MARK: Consts

    private static let toastViewPadding: CGFloat = 12.0
    
    // MARK: Inits

    /**
     Configures the ToastView's UI based on the data provided in the toastViewModel.
     
     - Parameter toastViewModel: The view model containing data to assign to UI elements.
     */
    init(toastViewModel: ToastViewModel) {

        self.toastViewModel = toastViewModel
        
        super.init(frame: .zero)
            
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private Implementation

extension ToastView {

    private func setupView() {
                
        backgroundColor = .label
        clipsToBounds = true
        isUserInteractionEnabled = true
                
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .vertical)
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentHuggingPriority(.required, for: .vertical)
        button.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
        button.isHidden = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.accessibilityLabel = toastViewModel.buttonViewModel?.accessabilityButtonText
        button.setTitle(toastViewModel.buttonViewModel?.buttonText, for: .normal)
        button.isHidden = (toastViewModel.buttonViewModel == nil)
        button.setTitleColor(.systemBackground, for: .normal)
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.setContentHuggingPriority(.required, for: .horizontal)
        iconImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        iconImageView.setContentCompressionResistancePriority(.required, for: .vertical)
        iconImageView.image = toastViewModel.icon
        iconImageView.isHidden = (toastViewModel.icon == nil)
        iconImageView.accessibilityLabel = toastViewModel.accesabilityIconLabel
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = .systemBackground
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.text = toastViewModel.title
        titleLabel.accessibilityLabel = toastViewModel.accesabilityTitleLabel
        titleLabel.isHidden = (toastViewModel.title == nil)
        
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = .systemBackground

        messageLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        messageLabel.text = toastViewModel.message
        messageLabel.accessibilityLabel = toastViewModel.accessabilityMessageLabel

        messageTitleLabelStack.axis = .vertical
        messageTitleLabelStack.addArrangedSubview(titleLabel)
        messageTitleLabelStack.addArrangedSubview(messageLabel)
        
        rootContainerStack.axis = .horizontal
        rootContainerStack.spacing = 10.0
        rootContainerStack.alignment = .center
        rootContainerStack.addArrangedSubview(iconImageView)
        rootContainerStack.addArrangedSubview(messageTitleLabelStack)
        rootContainerStack.addArrangedSubview(button)
        addSubview(rootContainerStack)
        
        if toastViewModel.onSwipe != nil {
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetected))
            swipeGesture?.direction = .down
            addGestureRecognizer(swipeGesture!)
        }
    }
    
    private func setupConstraints() {
        
        rootContainerStack.translatesAutoresizingMaskIntoConstraints = false
        let labelConstraints = [rootContainerStack.topAnchor.constraint(equalTo: topAnchor,
                                                                        constant: ToastView.toastViewPadding),
                                rootContainerStack.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                           constant: -ToastView.toastViewPadding),
                                rootContainerStack.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                            constant: ToastView.toastViewPadding),
                                rootContainerStack.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                             constant: -ToastView.toastViewPadding)]
        
        NSLayoutConstraint.activate(labelConstraints)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        let iconImageviewConstraints = [iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)]
        
        NSLayoutConstraint.activate(iconImageviewConstraints)
    }
}

// MARK: Private Actions

extension ToastView {
    
    @objc private func buttonWasTapped() {
        delegate?.toastViewTappedButton(sender: self)
    }
    
    @objc private func swipeDetected() {
        delegate?.toastViewDetectedSwipe(sender: self)
    }
}

// MARK: Public Overrides

extension ToastView {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // dynamically make corner radius to avoid the edge case of when a toast does not have much content which could result in the toasts corners looking too rounded.
        layer.cornerRadius = (bounds.height * 0.70) / 2
    }
}
