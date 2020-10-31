# BT-OtpView
An off-the-shelf, 4-digit, One-Time-Password View For iOS.

<p align="center">
  <img src="https://media0.giphy.com/media/DYrB7UuMkxJW7wfaoQ/giphy.gif">
</p>

### Quickstart
1- Drag View object from the Object Library into your storyboard.
<p align="center">
  <img src="https://github.com/baianat/BT-OtpView/blob/master/instruction1.png">
</p>

2- Set the view's class to `OtpView` in the Identity Inspector. Set its module property to `BT_OtpView`.

<p align="center">
  <img src="https://github.com/baianat/BT-OtpView/blob/master/instruction2.png">
</p>


3- add `import BT_OtpView` to the header of your view controller.

4- Create an outlet in the corresponding view controller.
  ``` swift
    @IBOutlet weak var otpView: OtpView!
  ```
  
5- Set the delegate of the otpView and implement `OtpViewDelegate`.
  
  ``` swift
     
  override func viewDidLoad() {
        ...
        otpView.delegate = self
  }
  
  
  extension ViewController : OtpViewDelegate {
    
    func shouldReceive(otpCode code: String, at otpView: OtpView) -> Bool {
        // code is the 4-digit code entered
        return true
  }
    
}
  ```
  `shouldReceive(otpCode code: String, at otpView: OtpView)` is invoked automatically once 4-digit code is entered.
  
**Notes**
- `shouldReceive` : this function returns boolean, true to dismiss the keyboard when 4 digits are entered, otherwise false.

- alternatively, you can access the code as follows..
  
  ``` swift
    otpView.verificationCode  
  ```
  
  ### Customization
  You can customize OtpView for the following attributes
  
| Attribute  | Type | Default value |
| ------------- | ------------- |------------- |
|defaultBorderColor| UIColor | `.gray` |
|focusedBorderColor  | UIColor | `.black` |
|cornerRadius  | CGFloat | `16.0` |
|borderWidth  | CGFloat| `1.0` |
|defaultFillColor  | UIColor | `.clear` |
|focusedFillColor  | UIColor | `.clear` |
|hideCursor  | Bool | `true` |
|isSecuredTextEntry  | Bool | `fales` |
|onlyNumbers  | Bool | `true` |
|placeHolder  | String | `""` |
|textColor  | UIColor | `.black` |
|font  | UIFont | `nil` -system default |

All you need to do is to set the `decorator` attribute on `OtpView` as follows..

  ``` swift
        otpView.decorator = OtpViewDecorator(
          defaultBorderColor: .gray,
          focusedBorderColor: .black,
          cornerRadius: 8,
          borderWidth: 1,
          defaultFillColor: .clear,
          focusedFillColor: .clear,
          hideCursor: true,
          isSecuredTextEntry: false,
          onlyNumbers: true,
          placeHolder: "*",
          textColor: .brown,
          font: UIFont.boldSystemFont(ofSize: 24)
        )
  ```
  
### Installation
To install OtpView, simply add the following line to your Podfile:

```ruby
pod 'BT-OtpView'
```


## License

BT-OtpView is available under the MIT license. See the LICENSE file for more info.
