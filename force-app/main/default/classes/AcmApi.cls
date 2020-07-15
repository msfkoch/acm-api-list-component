public with sharing class AcmApi {

    @AuraEnabled
    public String name;
    @AuraEnabled
    public String id;
    @AuraEnabled
    public String versionId;
    @AuraEnabled
    public String icon;
    @AuraEnabled
    public String description;
    @AuraEnabled
    public String visibility;
    @AuraEnabled
    public String navigateUrl;
    @AuraEnabled
    public String assetType;
    @AuraEnabled
    public String assetVersion;
    @AuraEnabled
    public String communityId;
    @AuraEnabled
    public String communityName;
    @AuraEnabled
    public String contentDocumentId;
    @AuraEnabled
    public String contentVersionId;
    @AuraEnabled
    public String account;
    @AuraEnabled
    public String apiId;
    @AuraEnabled
    public String version;

    @AuraEnabled
    public List<AcmApiCategory> categories = new List<AcmApiCategory>();

    public AcmApi(acm_pkg__CommunityApi__c apiversion) {

        this.id = apiversion.Id;
        this.name = apiversion.acm_pkg__Name__c;
        this.description = apiversion.acm_pkg__Description__c;
        this.visibility = apiversion.acm_pkg__Visibility__c;
        this.navigateUrl = apiversion.acm_pkg__NavigateUrl__c;
        this.versionId = apiversion.acm_pkg__AnypointApiVersionId__c;
        this.icon = apiversion.acm_pkg__Icon__c;
        this.assetType = apiversion.acm_pkg__AssetType__c;
        this.assetVersion = apiversion.acm_pkg__AssetVersion__c;
        this.communityId = apiversion.acm_pkg__CommunityId__c;
        this.communityName = apiversion.acm_pkg__CommunityName__c;
        this.account = apiversion.acm_pkg__Account__c;
        this.apiId = apiversion.acm_pkg__ApiId__c;
        this.version = apiVersion.acm_pkg__VersionGroup__c;
    }

    public AcmApi(String id, String name, String description, String navigateUrl) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.navigateUrl = navigateUrl;
    }

    public AcmApi() {}

    public static  List<acm_pkg__CommunityApi__c> getCommunityApi(String apiRecordId) {
        return [SELECT acm_pkg__Name__c, Id, acm_pkg__AnypointApiVersionId__c FROM acm_pkg__CommunityApi__c WHERE Id = :String.escapeSingleQuotes(apiRecordId)];
    }

}