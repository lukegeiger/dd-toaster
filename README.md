# Toaster

Hi Welcome to Toaster!


# Getting Started

```
import Toaster
```

Toaster is a SPM Package that is located under Packages/Toaster... Hope you enjoy!

# Use Case 1 - Simple Toast No Auto Dismiss

```
let toastViewModel = ToastViewModel(message: "This is a message")
let presentationBehavior = PresentationBehavior(style: .natural)
Toaster.toast(toastViewModel: toastViewModel, presentationBehavior: presentationBehavior, in: view)
```

# Use Case 2 - Simple Toast Custom Dismissal

```
let toastViewModel = ToastViewModel(message: "This is a message")
let presentationBehavior = PresentationBehavior(style: .natural)
let myToast = Toaster.toast(toastViewModel: toastViewModel, presentationBehavior: presentationBehavior, in: view)
        
let dismissalBehavior = DismissalBehavior(dismissalDirection: .bottom)
Toaster.dismiss(toastView: myToast, in: view, withDismissalBehavior: dismissalBehavior)

```

# Use Case 3 - Full Toast Use Case & Auto Dismiss

```
let config = UIImage.SymbolConfiguration(textStyle: .title3)
let icon = UIImage(systemName: "heart.fill", withConfiguration: config)
        
let buttonToastViewModel = ButtonToastViewModel(buttonText: "View") { toastView in
        Toaster.dismiss(toastView: toastView, in: self.view, withDismissalBehavior: DismissalBehavior(dismissalDirection: .bottom))
}
        
let toastViewModel = ToastViewModel(message: "Title", icon: icon, title: "title", buttonViewModel: buttonToastViewModel, onSwipe: { toastView in
        Toaster.dismiss(toastView: toastView, in: self.view, withDismissalBehavior: DismissalBehavior(dismissalDirection: .bottom))
})
        
let presentationBehavior = PresentationBehavior(style: .fitScreen) // can either be fitScreen or natural
        
let dismissalBehavior = DismissalBehavior(dismissalDirection: .bottom)
let autoDismissTime = DispatchTime.now() + .seconds(4)
let autoDismiss = (autoDismissTime, dismissalBehavior) // optional parameter
        
Toaster.toast(toastViewModel: toastViewModel,
                      presentationBehavior: presentationBehavior,
                      in: self.view,
                      autoDismiss: autoDismiss)
```

# Use Case 4 - Toast, No Button or Swipe Enabled

```
let config = UIImage.SymbolConfiguration(textStyle: .title3)
let icon = UIImage(systemName: "heart.fill", withConfiguration: config)
                
let toastViewModel = ToastViewModel(message: "Title", icon: icon, title: "title")
        
let presentationBehavior = PresentationBehavior(style: .natural) // can either be fitScreen or natural
                
Toaster.toast(toastViewModel: toastViewModel,
              presentationBehavior: presentationBehavior,
              in: self.view)
```

# Sizing

Note that toasts have the option of either fitting their content naturally or fitting to the width of the screen. Please see `PresentationBehavior`, specifically `PresentationStyle`

# Unit tests

Please see /Tests/ToasterTests for the test suite

# Accessibility

Note the ToastViewModel has room for Accessibility labels. These strings get assigned to their respective views in ToasterView

# Dark Mode

Note the ToastViewModel has room for Accessibility labels. These strings get assigned to their respective views in ToasterView

# Demo

Please see `DemoViewController.swift`
