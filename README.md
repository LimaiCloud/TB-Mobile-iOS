# TB-Mobile-iOS
  
  TB - Mobile - iOS is tailored for industrial products. It makes the factory original become more light and quick operation.
  
  You can find the document at [gitbook](https://www.gitbook.com/book/xudongliu/tb-mobile-development/welcome)
 
# Requirements

  - iOS 9.0+
  - Swift 3.0+ / Swift 4.0+
  
# Installation with CocoaPods

  [CocoaPods](https://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AFNetworking in your projects.You can install it with the following command:
  
  ```
    $ gem install cocoapods
  ```
  
### What is a Podfile?

  The Podfile is a specification that describes the dependencies of the targets of one or more Xcode projects. The file should simply be named Podfile.
  
### How to use Podfile?

  To integrate framework into your Xcode project using CocoaPods, specify it in your Podfile:
  
  ```
    target 'TB-Mobile-iOS' do
  
    pod 'AFNetworking'
    pod 'MBProgressHUD'
    pod 'MJRefresh'
    pod 'SDCycleScrollView'
    pod 'Bugly'

    use_frameworks!
    pod 'JWTDecode'
    pod 'Starscream'
    pod 'Charts','3.1.1'
    
    end

   ```
### Podfile

  Open a terminal installation the Podfile,Then, run the following command:
  
  ```
    $ pod install
  ```
# How To Get Started

  Before the user through a username and password to log in，He/She must be set up on the app. Start the project，He/She will see the login screen, then, Click the picture to configuration the APP URL, for example: http://YOUR_HOST.
  Ok, congratulations ！ The completion of setting.

  ![image](https://github.com/MMing0310/TB-Mobile-iOS/blob/master/TB-Mobile-iOS/TB-Mobile-iOS/Resources/images/login.png)

# License

  TB-Mobile-iOS is licensed under the Apache License 2.0.
  
  
  
