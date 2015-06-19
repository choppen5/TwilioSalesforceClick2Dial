##How to get Click to Dial working in Salesforce with Twilio##

This is a step by step guide to get click2 dial and basic inbound routing working in Salesforce OpenCTI by using Twilio.

Why would you want to do this? This app should appeal to you if you want the simplest, lowest overhead solution to getting calls going out of Salesforce to call a user. It doesn't require any vendors (except Salesforce account and a Twilio account) or software - it lives in the browser. 

Because both Twilio and Salesforce speak the language of the web, you can get this going by following the steps in this article, and be making calls right out of your browser, instead of being dependent on phones. 

Another advantage is that since you implement all the code your self, you have full control - you can take this code as a starting point and build upon it, or just use the basic version.

Check out a video presentation, or jump into the setup steps below: https://www.youtube.com/watch?v=RFJcNOCqVuU

# Setup


1. You need the Twilio-SFDC package installed in your environennt. If you don't have it, you can find it here: https://github.com/twilio/twilio-salesforce. 

 Once you have Twilio SFDC installed in your org, you can do these steps:
2. Create a new Custom Setting in Develop > Custom Settings > Twilio Config - the CallerId setting might be missing, create that if so.  You will add a Twilio phone number in the callerid field in the steps above. 

3. Download and create the APEX class TwilioCientController https://github.com/choppen5/TwilioSalesforceClick2Dial/blob/master/TwilioClientController.apex

4. Download and create the VisualForce page: https://github.com/choppen5/TwilioSalesforceClick2Dial/blob/master/TwilioClick2Dial.vf

5. Download and create the Dial page: https://github.com/choppen5/TwilioSalesforceClick2Dial/blob/master/Dial.vf

6. Download and create the Respond page: https://github.com/choppen5/TwilioSalesforceClick2Dial/blob/master/Respond.vf

7. Create a new Call Center in Customize > Call Center > Call Centers by Import(ing) https://github.com/choppen5/TwilioSalesforceClick2Dial/blob/master/DemoAdapterTwilio.xml


After that, all the setup instructions below apply - you have to set the Autentication tokens, caller id, Twilio steps etc.


## Configuration - after package Install

After setup, you need to do the following steps

***In Twilio***

1. Create a Twilio.com account if you don't have one, obtain your AuthToken and Secret.
![TwimlApp](http://uploadir.com/u/ecsgu7jl)

2. In Twilio, go to Dev Tools > Twimil  Apps > Create. Give the name of the App SalesforceClick2Dial,  note the ApplicationSid.  
![TwilioAuthToken](http://uploadir.com/u/vfv1enbb)

3. We will later go into this Application, and add a Voice URL to it, once we create the URL in Salesforce in later steps. For now, note the Application Id created
![TwimlAppWithoutURL](http://uploadir.com/u/u7lpiwhv)

4. "Buy"" at least one phone number in Twilio, you will need at least one phone number for CallerId, note the phone number.  We can also modify the VoiceURL to include a Salesforce URL, to allow inbound routing to this number as well as outbound click2dial.
![BuyphoneNumber](http://uploadir.com/u/5mu93v1n)


###In Salesforce###

1. Go to Develop > Custom Settings > TwilioConfig.  Press the "Manage"" link then > "New"" to set new variables
![config](http://uploadir.com/u/n6p22ssu)
![new](http://uploadir.com/u/ln6wpcbm) 

Add the (AccountSid, AuthToken, ApplicationSid, CallerId) parameters created from the Twilio steps 
![newconfig](http://uploadir.com/u/q7eppa04)


##Setting up a VisualForce Site##

2. Go to SalesForce Setup -> Develop -> Sites 
Create a new Site or use make sure **Dial**  Visual Force page that is included:  **TwilioClick2Dial**, **Dial** VisualForce Pages. You need to click on the label for the site to find the settings:
![settings](http://uploadir.com/u/lf4kunkx)

![newsite](http://uploadir.com/u/8hor44dt)

and settings:
![sitesettings](http://uploadir.com/u/o363ocpo)


On the settings page, you can choose which exact page is included.  You are making sure the Dial page is included.  
![pagesadded](http://uploadir.com/u/xr4yf9b5)

When that page is included, you are enablinig a salesforce site page to produce XML.  We will add this URL to the Twilio Twiml app we created.  
For example, if you created a new site in a Developer org , the url to Dial might be this: 
 http://twilioctidemo-developer-edition.na15.force.com/dial
 
 

***Adding VisualForce /dial page back in Twilio  Twiml app***

1. After your Force.com Site is created, you can point your Twiml app at it.  Navigate to Dev Tools > Twiml Apps > "SalesforceClick2Dial"
2. Set the Request URL to your Site address, for example: http://twilioctidemo-developer-edition.na15.force.com/dial
![addingforcesitetotwiml](http://uploadir.com/u/2vwdscay)



###Setting up Salesforce Call Center###

Addendum to steps 1-3: The Call Center > CTI Adapter URL can simply be set to "/apex/TwilioClick2Dial", DemoAdapterTwilio.xml has been updated accordingly.

1. Locate the VisualForce pages that supports the softphone that was imported from the package (From Develop > Pages) *TwilioClick2Dial*
Make sure to click on the preview page, not just the source code
![PreviewVF](http://uploadir.com/u/mtginq7w)

2.  Click on the visual force page to find the VisualForce instance full path.  For example: https://c.na15.visual.force.com/apex/TwilioClick2Dial - The Salesforce instance address will vary depending on your specific Salesforce login.
![apexaddress](http://uploadir.com/u/cx6axmqc)

3. Add this VisualForce page to you CallCenter configuration.  Navigate to Setup > Create > Call Centers > Click2Dial call center.  Edit the call center, and set the CTI Adapter URL to the visual force page address from the previous step.
![callcenterurl](http://uploadir.com/u/lyhysp3e)


4. Press the Manage Users button in the Call Center, add your user to this Call Center.  This is the last step!  Now, when you navigate to a CTI compatible view in Salesforce, it will enable showing the Open CTI toolbar.  Since the demo click2call code has no styling,  the view is very basic. 
![openctienabled](http://uploadir.com/u/do78g14m)

You will know everything is setup correctly if you can:
- See the Open CTI toolbar (If the toolbar fails to render, check that your browser is not blocking 3rd party cookies, or add an exception to allow cookies from the frame source e.g.  **c.**your salesforce domain**.visual.force.com**)
- See that phone numbers are clickable
- When clicking a number, or entering a number to call, the call should be connected
- Addendum March 2015: works most reliably using Chrome browser


***Done!***

Test this by navigating to any regular Contact record (or other places where the Call Center is deployed). You should see a very bare looking CTI Panel.  You can also add a phoen number to dial, or create a new contact and click on the phone number to determine if the call is being dialed.

##Inbound routing ##

To route Incoming Calls to one or more of your Twilio Phone Numbers into your Salesforce Call Center Softphone, go to your Twilio Phone Number, and set the "Voice Request Url"  to be `<YourSiteBaseUrl>/respond`, e.g. http://twilioctidemo-developer-edition.na15.force.com/respond

You also have to make sure the /respond page is included in your security settings as we did for the /dial page.  The respond page has very simple routing.. it will just route the call to the first availible agent.



