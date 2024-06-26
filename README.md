# **Introduction**

This package allows the Flutter app to integrate the UAE pass.

## **Features**

* Sign-in with UAE Pass 
* Login, Sign-in and logo buttons according to UAE Pass guidelines
* Support for english and arabic language
* Button supports dark mode, disable state and other customizations

## **Flutter Compatibility**

| **Package version** | **Dart version** | **Flutter version** |
|:-------------------:|:----------------:|:-------------------:|
|  0.0.1+1 - 0.0.7+7  |  >=3.2.6 <4.0.0  |      >=1.17.0       |

## **Getting Started**

To integrate the package into your Flutter project, follow these steps:

### **Add Dependency**

Add the following dependency to your pubspec.yaml file:

``` dart
    dependencies:
      ft_uaepass: ^0.0.7+7

```

Then run:

``` dart
    flutter pub get

```

### **Android Setup**

- Update android:launchMode="singleTask" to AndroidManifest.xml file

``` xml
    <activity
       ..... 
       android:launchMode="singleTask"
       .....>
    </activity>
```

- Add Permission and intent filter in AndroidManifest.xml file

``` xml
    <uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" />
    <uses-permission android:name="android.permission.INTERNET" />
```

``` xml
    <intent-filter>
       <action android:name="android.intent.action.VIEW" />
       <category android:name="android.intent.category.DEFAULT"/>
       <category android:name="android.intent.category.BROWSABLE"/>
       <data
           android:host="${redirectUrl without http or https}"
           android:scheme="https" />
    </intent-filter>
```

### **iOS Setup**

- Add CFBundleURLTypes and LSApplicationQueriesSchemes in info.plist file

``` xml
    <key>CFBundleURLTypes</key>
    <array>
    	<dict>
    		<key>CFBundleTypeRole</key>
    		<string>Editor</string>
    		<key>CFBundleURLName</key>
    		<string>com.example</string>
    		<key>CFBundleURLSchemes</key>
    		<array>
    			<string>example</string>
    		</array>
    	</dict>
    </array>
```

``` xml
    <key>LSApplicationQueriesSchemes</key>
    <array>
    	<string>uaepass</string>
    	<string>uaepassstg</string>
    </array>
```

## **Scope**
- For now `urn:uae:digitalid:profile:general` scope is only supported

## **Usage**

#### SignIn (Staging):
``` dart
    await UaePass(
        context: context,
        redirectUrl: ${redirectUrl},
        state: ${State},
        isProduction: false,
      ).signIn();

```
**Note:**
- For Android testing follow below steps
  - Go to App info
  - Tap on the "Set as default"
  - Tap on the "Supported web addresses"
  - Turn on the switch for redirect URL


#### SignIn (Production):
``` dart
    await UaePass(
        context: context,
        clientId: ${clientId},
        clientSecret: ${clientSecret},
        redirectUrl: ${redirectUrl},
        state: ${State},
      ).signIn();

```

#### Buttons

- Login button
``` dart
    LoginWithUaePassButton(
      onPressed: () async {
        UAEPassWebViewResultModel? uaePassWebViewResultModel =
          await UaePass(
          context: context,
          clientId: ${clientId},
          clientSecret: ${clientSecret},
          redirectUrl: ${redirectUrl},
          state: ${State},
        ).signIn();
      },
    )
```

- Sign-in button
``` dart
    SignInWithUaePassButton(
      onPressed: () async {
        UAEPassWebViewResultModel? uaePassWebViewResultModel =
          await UaePass(
          context: context,
          clientId: ${clientId},
          clientSecret: ${clientSecret},
          redirectUrl: ${redirectUrl},
          state: ${State},
        ).signIn();
      },
    )
```

- Logo button
``` dart
    LogoButton(
      onPressed: () async {
        UAEPassWebViewResultModel? uaePassWebViewResultModel =
          await UaePass(
          context: context,
          clientId: ${clientId},
          clientSecret: ${clientSecret},
          redirectUrl: ${redirectUrl},
          state: ${State},
        ).signIn();
      },
    )
```

## Custom Error codes (Status code)
| **Custom Error code** | **Description**              | **Message**                                                    |
|:----------------------|:-----------------------------|:---------------------------------------------------------------|
| 0                     | When any unknown error occur | Something went wrong. Please try again after sometime          |
| -1                    | When user is SOP1            | Your account is unverified, please visit the nearest UAE PASS  |
| -2                    | When user cancel the request | Request canceled by user                                       |

## Properties:
- Login and Sign-in Button properties

| **Property**       | **Type**               | **Default value**                                                                   | **Other Values**                                                                           |
|:-------------------|:-----------------------|:------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------|
| onPressed          | VoidCallback           | Null                                                                                | VoidCallback Function                                                                      |
| buttonShape        | ButtonShape            | ButtonShape.defaultCornerRadius                                                     | ButtonShape.minCornerRadius<br/> ButtonShape.maxCornerRadius<br/> ButtonShape.customRadius |
| customBorderRadius | double                 | 4                                                                                   | double - Any double value                                                                  |
| isDarkMode         | bool                   | false                                                                               | true                                                                                       |
| isDisable          | bool                   | false                                                                               | true                                                                                       |
| isBorder           | bool                   | true                                                                                | false                                                                                      |
| isButtonMaxWidth   | bool                   | false                                                                               | true                                                                                       |
| padding            | EdgeInsetsDirectional  | EdgeInsetsDirectional.symmetric(<br/> horizontal: 30.0, <br/>vertical: 10.0, <br/>) | true                                                                                       |

- Logo Button properties

| **Property**       | **Type**               | **Default value**                                                                   | **Other Values**                                                                           |
|:-------------------|:-----------------------|:------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------|
| onPressed          | VoidCallback           | Null                                                                                | VoidCallback Function                                                                      |
| buttonShape        | ButtonShape            | ButtonShape.defaultCornerRadius                                                     | ButtonShape.minCornerRadius<br/> ButtonShape.maxCornerRadius<br/> ButtonShape.customRadius |
| customBorderRadius | double                 | 4                                                                                   | double - Any double value                                                                  |
| isDarkMode         | bool                   | false                                                                               | true                                                                                       |
| isDisable          | bool                   | false                                                                               | true                                                                                       |
| isBorder           | bool                   | true                                                                                | false                                                                                      |
| padding            | EdgeInsetsDirectional  | EdgeInsetsDirectional.symmetric(<br/> horizontal: 30.0, <br/>vertical: 10.0, <br/>) | true                                                                                       |

## Example App demo:
- Android</br></br></br>
  <a href="https://raw.githubusercontent.com/Jarvis-Technolabs/uae_pass/assets/Android.gif"><img src="https://raw.githubusercontent.com/Jarvis-Technolabs/uae_pass/assets/Android.gif" alt="Android" height="400"/></a>

- iOS</br></br></br>
  <a href="https://raw.githubusercontent.com/Jarvis-Technolabs/uae_pass/assets/iOS.gif"><img src="https://raw.githubusercontent.com/Jarvis-Technolabs/uae_pass/assets/iOS.gif" alt="iOS" height="400"/></a>

## UAE Pass References: 
- [Documentation](https://docs.uaepass.ae/overview)
- [Staging Apps](https://docs.uaepass.ae/resources/staging-apps)