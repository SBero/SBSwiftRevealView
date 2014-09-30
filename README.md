<h1>SBSwiftRevealView</h1>

<h3>About</h3>

<p>
This is a Swift implementation of a swipeable reveal view for iOS. Currently the
capabilities are limited, but planned to be expanded into a more robust and
module based setup.
</p>

<h3>Usage</h3>

<p>
At a minimum you need to include the following files in your project:<br/>
<br/>
<ul>
    <li><i>RearNavigationViewController.swift</i></li>
    <li><i>RearNavControllerDelegate.swift</i></li>
</ul>
</p>

<p>
Currently, you'll need to make a seperate function for each of the navigation
items you plan on having in the <i>RearNavigationViewController.swift</i> file. Plans
are to abstract this out to not require this, but at this time, that implementation
hasn't been completed.<br/>
<br/>
<u>Example:</u>
<pre>
func loadSettingsView(sender: UIButton){
    let settingsViewCtrl: ViewController = ViewController()
    settingsViewCtrl.rearNavDelegate = self

    self.loadFrontViewWithController(settingsViewCtrl)
}
</pre>
</p>

<p>
<b>AppDelegate.swift</b>
Modifications to the AppDelegate.swift file are also necessary for the reveal
view to work correctly.
<br/>
<br/>
Add the following to your <i>AppDelegate.swift</i> file in your project:<br/>
<br/>
<pre>
self.window = UIWindow(frame: UIScreen.mainScreen().bounds)

let viewController = ViewController()
let navWidth: CGFloat = 220

let rearNavigationViewController = RearNavigationViewController(frontViewCtrl: viewController, navWidth: navWidth);

self.window!.rootViewController = rearNavigationViewController;

self.window!.makeKeyAndVisible()
return true
</pre>

</p>