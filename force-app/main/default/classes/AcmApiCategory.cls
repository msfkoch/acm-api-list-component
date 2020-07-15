public with sharing class AcmApiCategory {
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String id;
    @AuraEnabled
    public String apiVersionId;
    @AuraEnabled
    public String value;
    
    public AcmApiCategory() {

    }
    
    public AcmApiCategory(acm_pkg__AnypointApiCategories__x source) {
        this.id = source.acm_pkg__Id__c;
        this.apiVersionId = source.acm_pkg__ApiVersionId__c;
        this.name = source.acm_pkg__Name__c;
        this.value = source.acm_pkg__Values__c;
    }
    
    public static  List<AcmApiCategory> fromList(AcmApi api, List<acm_pkg__AnypointApiCategories__x> sources) {
        List<AcmApiCategory> result = new List<AcmApiCategory>();
        
        for (acm_pkg__AnypointApiCategories__x source : sources) {
            final string sourceId = source.acm_pkg__ApiVersionId__c;
            if (sourceId.equals(api.versionId)) {
                System.debug('Found api ' + sourceId + ' in category ' + source);
                result.add(new AcmApiCategory(source));
            }
        }
        
        return result;
    }}