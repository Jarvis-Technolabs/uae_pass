# **Introduction**

This package allows flutter app to integrate UAE pass.

## **Features**

* Sign-in with UAE Pass 
* Login, Sign-in and logo buttons according to UAE Pass guidelines
* Support for english and arabic language
* Button supports dark mode, disable state and other customizations


## **Flutter Compatibility**

| **Package version** | **Dart version** |    **Flutter version**     |
|:-------------------:|:----------------:|:--------------------------:|
|        0.0.1        |      3.2.6       |      3.16.0 - 3.19.3       |


## **Getting Started**

To integrate the package into your Flutter project, follow these steps:

### **Add Dependency**

Add the following dependency to your pubspec.yaml file:

``` dart
    dependencies:
      uae_pass: ^0.0.1

```

Then run:

``` dart
    flutter pub get

```

## **Android Setup**

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

## **iOS Setup**

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
    	<string>googlechromes</string>
    	<string>uaepass</string>
    	<string>uaepassstg</string>
    	<string>http</string>
    	<string>https</string>
    </array>
```

## **Scope**
- For now urn:uae:digitalid:profile:general scope is only supported

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