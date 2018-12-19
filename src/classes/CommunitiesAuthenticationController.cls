public without sharing class CommunitiesAuthenticationController {
    class AuthenticationException extends Exception {}

    // Config variables
    private static String GuidAttributeName;
    // UserName, DisplayName and Email attributes will be fetched per remedy#627044
    private static String UserName;
    private static String DisplayName;
    private static String EmailAddress;
    private static String StandardRedirectUrl;
    private static String PortalRedirectUrl;
    public string staddid;//ICM launch button - stores STADD Contact ID from ICM

    public String guid {get; set;}
    public String uname {get; set;}
    public String dname {get; set;}
    public String email {get; set;}
    public String decodedSamlResponse {get; set;}
    public String error {get; set;}

    public CommunitiesAuthenticationController() {
        // Work performed in evaluateAssertion
    }
   
    public string getURL(){
         loadConfig();
         setStaddID();
         return PortalRedirectUrl+'&RelayState=%2F'+staddid+'     '+StandardRedirectUrl+'&RelayState=%2F'+staddid;
    }
    public PageReference evaluateAssertion() {
        try {
            loadConfig();
            setStaddID();
            List<String> attrValues = new List<String> ();
            Dom.Document response = loadSamlResponse();
            attrValues = findAttributes(response);
            guid = attrValues[0];
            dname = attrValues[1];
            email = attrValues[2];
            uname= attrValues[3];
            User user = loadUserByGuid(guid);
            if (user == null) {
                // Send to self registration
                PageReference pr = Page.CommunitiesSelfReg;
                //PageReference pr = Page.CommunitiesSelfReg_New;
                pr.getParameters().put('guid', guid);
                pr.getParameters().put('dname', dname);
                pr.getParameters().put('email', email);
                pr.getParameters().put('uname', uname);
                pr.setRedirect(true);
                return pr;
            } else {
                // Redirect to correct siteminder
                PageReference pr = redirectToSso(user);
                pr.setRedirect(true);
                return pr;
            }
        } catch (Exception e) {
            error = e.getMessage();
            logException(e, decodedSamlResponse);
        }
        return null;
    }
    //ICM Launch button - get the Contact ID value from cookies and assign to the string variable
    public void setStaddID() {        
        cookie result = ApexPages.currentPage().getCookies().get('StaddID');
        cookie ContactID = new Cookie('StaddID', '', null,-1,false);
        ApexPages.currentPage().setCookies(new Cookie[]{ContactID});
        if (result == null) {
            staddid='';
        } 
        else {
            staddid = result.getValue();
        }
    }
    
    public static void loadConfig() {
        SSO_Redirect_Config__c config = SSO_Redirect_Config__c.getInstance();
        if (config == null) {
            return;
        }
        GuidAttributeName = config.Federation_Identifier_Attribute_Name__c;
        DisplayName=config.Display_Name__c;
        EmailAddress=config.Email_Address__c;
        UserName=config.User_Name__c;
        StandardRedirectUrl = config.Standard_Redirect_Location__c;
        PortalRedirectUrl = config.Portal_Redirect_Location__c;
    }
    
    
    public PageReference redirectToSso(User user) {
        if (user == null) {
            return null;
        }
        if (user.isPortalEnabled) {
           // return new PageReference(PortalRedirectUrl);
            if (staddid!=null || staddid!=''){
                //return new PageReference(PortalRedirectUrl+'&RelayState=%2Fstadd%2F'+staddid);
                return new PageReference(PortalRedirectUrl+'&RelayState=%2F'+staddid); // For prod
            }
            else{
                return new PageReference(PortalRedirectUrl);
            }
        }
        else {
            //ICM Launch button - if the StaddID exist, clear the cookies and redirect to deep link using RelayState
            //if (staddid!=null || staddid!=''){
                return new PageReference(StandardRedirectUrl+'&RelayState=%2F'+staddid);
            //}
            //else{
            //    return new PageReference(StandardRedirectUrl);
            //}
            //return new PageReference(StandardRedirectUrl);
        }
    }
    
    public Dom.Document loadSamlResponse() {
        // Retrieve the base64 encoded SAML response
        String encodedSamlResponse = ApexPages.currentPage().getParameters().get('SAMLResponse');
        if (encodedSamlResponse == null) {
            // No SAML response was found.
            throw new AuthenticationException('No SAML assertion was found');
        }
        Blob decodedSamlResponseBlob = EncodingUtil.base64Decode(encodedSamlResponse);
        if (decodedSamlResponseBlob == null) {
            // There was a problem decoding the SAML response.
            throw new AuthenticationException('An error occurred while decoding the SAML assertion');
        }
        
        decodedSamlResponse = null;
        decodedSamlResponse = decodedSamlResponseBlob.toString();
        
        Dom.Document response = new Dom.Document();
        response.load(decodedSamlResponse);
        return response;
    }
    
    public String[] findAttributes(Dom.Document response) {
        List<String> attr = new List<String> ();
        if (response == null) {
            throw new AuthenticationException('No SAML response was found');
        }
        Dom.XmlNode root = response.getRootElement();
        Dom.XmlNode assertion = getChildElementByName(root, 'Assertion');
        if (assertion == null) {
            throw new AuthenticationException('No SAML assertion was found');
        }
        Dom.XmlNode attributeStatement = getChildElementByName(assertion, 'AttributeStatement');
        if (attributeStatement == null) {
            throw new AuthenticationException('No SAML attribute statement was found');
        }
        Dom.XmlNode guidAttribute = getChildElementByAttribute(attributeStatement, 'Name', GuidAttributeName);
        Dom.XmlNode dnameAttribute = getChildElementByAttribute(attributeStatement, 'Name', DisplayName);
        Dom.XmlNode emailAttribute = getChildElementByAttribute(attributeStatement, 'Name', EmailAddress);
        Dom.XmlNode unameAttribute = getChildElementByAttribute(attributeStatement, 'Name', UserName);
        if ((guidAttribute == null)  || (dnameAttribute == null) || (emailAttribute == null) || (unameAttribute == null)) {
            throw new AuthenticationException('SAML Identifier attribute or DisplayName attribute or Email attribute or UserName attribute not found');
        }
        Dom.XmlNode guidAttributeValue = getChildElementByName(guidAttribute, 'AttributeValue');
        Dom.XmlNode dnameAttributeValue = getChildElementByName(dnameAttribute, 'AttributeValue');
        Dom.XmlNode emailAttributeValue = getChildElementByName(emailAttribute, 'AttributeValue');
        Dom.XmlNode unameAttributeValue = getChildElementByName(unameAttribute, 'AttributeValue');
        if (guidAttributeValue == null) {
            throw new AuthenticationException('No SAML Identifier value was found');
        }
        attr.add(guidAttributeValue.getText());
     	attr.add(dnameAttributeValue.getText());
        attr.add(emailAttributeValue.getText());
        attr.add(unameAttributeValue.getText());
        return attr;
    }
    
    private Dom.XmlNode getChildElementByName(Dom.XmlNode parent, String name) {
        for (Dom.XmlNode node : parent.getChildElements()) {
            if (node.getName() == name) {
                return node;
            }
        }
        return null;
    }
    
    private Dom.XmlNode getChildElementByAttribute(Dom.XmlNode parent, String attribute, String value) {
        for (Dom.XmlNode node : parent.getChildElements()) {
            String attributeValue = node.getAttributeValue(attribute, '');
            if (value == null && attributeValue == null) {
                return node;
            }
            if (attributeValue != null && value != null && attributeValue == value) {
                return node;
            }
        }
        return null;
    }
    
    private User loadUserByGuid(String guid) {
        if (guid == null || guid == '' || guid.isWhitespace()) {
            throw new AuthenticationException('The federation identifier was empty');
        }
        User[] users = [Select Id, Username, UserType, IsPortalEnabled From User Where FederationIdentifier = :guid Limit 2];
        if (users.size() > 1) {
            throw new AuthenticationException('Multiple users were found with this federation identifier');
        }
        if (users.size() < 1) {
            return null;
        }
        return users.get(0);
    }
    
    private static void logException(Exception e, String assertion) {
        SAML_Exception__c log = new SAML_Exception__c();
        
        log.Message__c = e.getMessage();
        log.Stack_Trace__c = e.getStackTraceString();
        log.Assertion__c = assertion;
        log.Host_IP__c = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
        
        String headerString = '';
        Map<String, String> headers = ApexPages.currentPage().getHeaders();
        for (String key : headers.keySet()) {
            headerString += key + ': ' + headers.get(key)+'\n';
        }
        log.Headers__c = headerString;
        
        String parametersString = '';
        Map<String, String> parameters = ApexPages.currentPage().getParameters();
        for (String key : parameters.keySet()) {
            parametersString += key + ': ' + parameters.get(key)+'\n';
        }
        log.Parameters__c = parametersString;
        
        String cookieString = '';
        Map<String, System.Cookie> cookies = ApexPages.currentPage().getCookies();
        for (Cookie cookie : cookies.values()) {
            cookieString += cookie.getName() + ': ' + cookie.getValue()+'\n';
        }
        log.Cookies__c = cookieString;
        
        insert log;
    }
}