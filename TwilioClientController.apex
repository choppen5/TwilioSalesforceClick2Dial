public class TwilioClientController {
       
        private TwilioCapability capability;
        public String uname {get; set;}
        
        //****** Initalizer - Set up Twilio Capability Token - requires ApplicationSid__c to be set
        public TwilioClientController() {
            capability = TwilioAPI.createCapability();
            capability.allowClientOutgoing(
                TwilioAPI.getTwilioConfig().ApplicationSid__c,null);
                capability.allowClientIncoming('salesforce_agent');
        }
        
        //******* {!Token} method returns a string based capability token
        public String getToken() { return capability.generateToken(); }
        
        //******* Pass in a parameter PhoneNumber - and this will Dial the phone number
        public String getDial() {
            String callerid = TwilioAPI.getTwilioConfig().CallerId__c;        
            //phone number will be passed as http query parameter
            String PhoneNumber = System.currentPageReference().getParameters().get('PhoneNumber');
            TwilioTwiML.Response res = new TwilioTwiML.Response();
            
            TwilioTwiML.Dial d = new TwilioTwiML.Dial(PhoneNumber);
            d.setCallerId(callerid);
            res.append(d);
            return res.toXML();
        }
    }