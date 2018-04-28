# TB-Mobile-iOS

  &nbsp;&nbsp;You can find the document at [gitbook](https://www.gitbook.com/book/xudongliu/tb-mobile-development/welcome)
 
# Requirements

  - iOS 9.0+
  - Swift 3.0+ / Swift 4.0+
  
# Installation with CocoaPods
-----------------------------
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

    end
   ```
### Podfile

  Open a terminal installation the Podfile,Then, run the following command:
  
  ```
    $ pod install
  ```
# How To Get Started
--------------------
  Before the user through a username and password to log in，He/She must be set up on the app. Start the project，He/She will see the login screen, then, Click the picture to configuration the APP URL, for example: http://YOUR_HOST.
  Ok, congratulations ！ The completion of setting.


# License
---------
  TB-Mobile-iOS is licensed under the Apache License 2.0.
  
  
  
