# About this project

We're trying to build a compose screen for the Hushmail email application. ("Hushmail" in the app store.) We have to use a `WKWebView` for the email body's content. In the past we've done this successfully with the (now deprecated) `UIWebView`.

In our compose screen, we want to use native iOS components above and below the `WKWebView`. These will comprise email headers, settings, and attachments.

This project is a framework for experimenting with different possible solutions, trying to meet the requirements.

This is a challenging project for expert programmers. A lot of time has already gone into finding a satisfactory solution. Therefore we are looking for programmers with extensive experience with UIKit and WKWebView to help us solve this.

# Requirements

A good solution will meet the following conditions:

## General requirements

* Use only iOS native components except for editing the email message body. That is, we will not use HTML components for message headers, settings, and attachments.
* Use only iOS native animations and UI behaviour, for example scrolling. Avoid workarounds where we have to implement our own animations.
* Scrolling must behave naturally everywhere.
* Resizing must be correct.
* The onscreen keyboard must appear and disappear as appropriate, and must not mess up resizing or scrolling.

## View layout

* The view controller must be contained within a `UINavigationController`.
* The view controller must support adding and removing additional views above and below the `WKWebView`.
* The view controller must support resizing the additional views above and below the `WKWebView`.
* Some of those additional views will contain other views that support text input (e.g. `UITextField`). The user must be able to easily tap between editable fields.
* Adding and removing views and resizing views must animate.
* The entire view must scroll vertically as a unit using normal gestures.

## Web view 

* The `WKWebView` can be scrolled horizontally
* The `WKWebView` can't be zoomed in or out
* The `WKWebView` must resize automatically as the HTML content changes (user types, pastes, deletes, etc.)
* Must support no content, short content, long content, wide content, narrow content, etc.
* The entire visible HTML content in the `WKWebView` will have the `contenteditable` attribute set to `true`. This can be set on the `body` tag or on an element within the `body` tag.
* Changes to the views above or below the `WKWebView` must not mess up the sizing of the `WKWebView`.

## Compatibility

* Must work on iOS 11.4 and above.

# Tips for testing

* When testing in the Simulator, be sure to present the on screen keyboard. Some of the problems kick in when the keyboard covers the web view.

# Solutions

We've tried several different approaches to making `WKWebView` work as well as `UIWebView`, but none of them have been successful. In this project we will keep the different solutions so that we can compare them to eachother and evolve each of them independently. 

## How to add another solution

### Basic steps

1. Create a new subfolder in Solutions (e.g. `Z`)
2. Create a storyboard with the same name (e.g. `Z.storyboard`) and add an initial view controller
3. Add your storyboard's filename (without the extension) to the `storyboardNames` array in `TableViewController.m` (e.g. `@"Z",`)
4. Build and run

### Next steps

1. Embed your storyboard's view controller in a `UINavigationController` (**Editor** → **Embed In** → **Navigation Controller**).  The `TableViewController` will add a Done button to the navigation bar for you.
2. Create your custom view controller class and any other files (e.g. HTML, CSS, Javascript)

## Solution attempts so far

### Solution A

The main idea in this solution is to use the `webView.scrollView.contentInset` property to create enough space above the HTML content to host the header views.

#### Good

* Scrolling is very smooth.
* Tapping between editable fields is very smooth.
* Horizontal scrolling works.

#### Bad or unknown or incomplete

* The `webView` isn't sized correctly vertically. I haven't proven this but I suspect the extra vertical space is exactly equal to the height of the header view.
* So far the top view is just a single `UITextField`, instead of an expandable/collapsable/resizable/hideable set of views.
* The vertical scrollbar gets hidden behind the header views (probably easily solved by reducing the width of the header views).

### Solution B

This solution uses a table view, with a `WKWebView` in a `UITableViewCell`. The Javascript in `B.html` reports its content's height back to `BTableViewController` every time the content changes, and the view controller then attempts to resize the `UITableViewCell`. It uses `touch-action` CSS property to control scrolling (I can't remember exactly why). 

#### Good

We haven't gone far enough with this one to discover any good news.

#### Bad or unknown or incomplete

* The initial content size is incorrect (the cell or the web view is too tall)
* At first it appears to work. It resizes vertically when you type lines of text into the `WKWebView`. It even appears to scroll up and down properly. But, not if the keyboard is covering part of the `WKWebView`. At this point it stops scrolling, and a horizontal scrollbar appears above the keyboard when you try to scroll down. Sometimes directly above, sometimes higher. It even appears around the middle of the screen when you're not using a hardware keyboard (Simulator).

### Solution C

At first, this one appears to work better, but after a bit of scrolling it breaks in the same way as Solution B. I don't remember the thinking behind this approach, or why it uses a `WKWebView` subclass (`CWKWebView`).

#### Good

* The initial size of the `WKWebView` looks good.

#### Bad or unknown or incomplete

* It animates the content into its initial size, which looks weird.
* It has the same major problem as Solution B – scrolling breaks.

### Solution D

Solution D does not use Javascript. Instead, it attempts to listen for changes in the `WKWebView`'s content size. I don't think we went very far with this one at all. 

#### Good

* The initial size of the `WKWebView` looks good.

#### Bad or unknown or incomplete

* Like every other `UITableView` solution, scrolling breaks after the keyboard comes on the screen.

### Solution E

This was going to be an attempt to build on Solution A, where the single top view becomes a stack view. The idea here was to figure out if we'll be able to do the expanding/collapsing etc. with this type of solution.

#### Good

* Can tap between editable fields

#### Bad or unknown or incomplete

* Can scroll too far down
* Horizontal scrolling isn't disabled
* The plus button, which is meant to add another view into the top stack view, isn't finished. It doesn't resize/relayout the rest of the view. So this part is quite broken.

### Solution F

This one is the beginning of an attempt to do everything within a `UIStackView`.  Didn't get far with this at all!


# Misc notes/things to try later

Keeping a list here of things that might be worth further investigation, possbily with their own solution.

* Disable scrolling entirely on our WKWebView's UIScrollView (`self.webView.scrollView.scrollEnabled = false`), annd put the web view within a horizontally scrolling UIScrollView?
* What can be done with the CSS property: `touch-action: pan-x;`? Is it useful? 
* I don't know what layout guides are but I came across this article recently and wondered if there might be some tips in it for sizing https://www.netguru.com/codestories/introduction-to-missing-keyboard-layout-guide (the article's not directly related to what we're doing here, just wanted to make a note of it to review later)
