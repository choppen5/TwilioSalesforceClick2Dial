# Setup

Install: <https://na15.salesforce.com/packaging/installPackage.apexp?p0=04ti0000000TMRk>

If you have an environment that **does not** already have the TwilioSalesforce library installed, you can run the package install. 


This package contains

* All of the TwilioSalesforce library
* Apex Class "TwilioClientController"
* VisualForce pages
  - ClickToDial.vf
  - Dial.vf
  - Respond.vf
* CallCenter definition file
* Develop > Custom Settings > Twilio Config (AccountSid, ApplicationSid, AuthToken, CallerId)


To install this in your Salesforce environment, just select the link above, confrim the defaults, and it will be installed in the Salesforce Environment you log into.  You need Salesforce Admin privileges to install.  

![sfdcinstall](http://uploadir.com/u/gghpenq7)



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


***In Salesforce***


1. Go to Develop > Custom Settings > TwilioConfig.  Press the "Manage"" link then > "New"" to set new variables
![config](http://uploadir.com/u/n6p22ssu)
![new](http://uploadir.com/u/ln6wpcbm) 
Add the (AccountSid, AuthToken, ApplicationSid, CallerId) parameters created from the Twilio steps 
![newconfig](http://uploadir.com/u/gfofpi7v)


2. Locate the VisualForce pages that were imported from the package (From Develop > Pages)
*TwilioClick2Dial*


4.  Click on the visual force page to find the VisualForce instance full path.  For example: https://c.na15.visual.force.com/apex/TwilioClick2Dial - The Salesforce instance address will vary depending on you specific Salesforce login.

5. Add this VisualForce page to you CallCenter configuration.  Navigate to Setup > Create > Click2Dial call center.  Edit the call center, and set the CTI Adapter URL to the visual force page from step 5.

6. Press the Manage Users button in the Call Center, add your user to this Call Center.  This will enable showing the Open CTI toolbar.

***Setting up a VisualForce Site***

7. Go to SalesForce Setup -> Develop -> Sites 
8. Create a new Site or use make sure **Dial** and **Respond** Visual Force pages are included
 or modify an existing site to include **TwilioClick2Dial**, **Dial**, and **Respond** VisualForce Pages. For example, if you created a new site in a Developer org , the url to Dial might be this: 
 http://twilioctidemo-developer-edition.na15.force.com/dial

***Back in Twilio***

1. After your Force.com Site is created, you can point your TWIML app at it.  Navigate to Dev Tools > Twiml Apps > "SalesforceClick2Dial"
2. Set the Request URL to your Site address, for example: http://twilioctidemo-developer-edition.na15.force.com/dial
3. To route Incoming Calls to one or more of your Twilio Phone Numbers into your Salesforce Call Center Softphone, go to your Twilio Phone Number, and set the "Voice Request Url"  to be `<YourSiteBaseUrl>/respond`, e.g. http://twilioctidemo-developer-edition.na15.force.com/respond



***Done!***

Test this by navigating to any regular Contact record (or other places where the Call Center is deployed). You should see a very bare looking CTI Panel.  You can also add a phoen number to dial, or create a new contact and click on the phone number to determine if the call is being dialed.


## Non package install:

If you have TwilioSalesforce library already installed, it will error.  In that case:
- Create a new ApexClass "TwilioClientController"
- Create  VisualForce page
- Download the CallCenter CAllCenter definitions specific to 

