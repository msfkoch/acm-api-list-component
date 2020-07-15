public with sharing class AcmApiListController {
    public AcmApiListController() {

    }

    @AuraEnabled
    public static List<AcmApi> getApis() {
        System.debug('<getApis> starting...');
        
        Map<String, AcmApi> apiMap = new Map<String, AcmApi>();

        // fetch Exchange APIs through OData bridge
        final List<acm_pkg__CommunityApi__c> apis = getExchangeApis();
        final List<acm_pkg__AnypointApiCategories__x> categories = getAllCategories();

        for (acm_pkg__CommunityApi__c version : apis) {
            AcmApi api = new AcmApi(version);
            api.categories = AcmApiCategory.fromList(api, categories);
            apiMap.put(version.Id, api);
        }

        return apiMap.values();
    }

    @AuraEnabled
    public static List<acm_pkg__CommunityApi__c> getExchangeApis() {
        final ConnectApi.Community community = AcmApiListController.getCommunity();

        return AcmApiListController.getExchangeApisFor(community.id);
    }

    @AuraEnabled
    public static List<acm_pkg__CommunityApi__c> getExchangeApisFor(final String communityId) {
        // CommunityApi api = new CommunitApi();
        
        return [
            SELECT Id, acm_pkg__Account__c,acm_pkg__Account__r.Name,
            	acm_pkg__AnypointApiVersionId__c,
            	acm_pkg__ApiId__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__AcmStatus__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__ApiId__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__AssetType__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__AssetVersion__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__CategoryFilter__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__Description__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__Documentation__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__DocumentationPages__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__Icon__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__Id__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__Name__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__OrganizationId__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__OrganizationName__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__Status__c,acm_pkg__AnypointApiVersionId__r.acm_pkg__Version__c,acm_pkg__AnypointApiVersionId__r.DisplayUrl,acm_pkg__AnypointApiVersionId__r.ExternalId,
            	acm_pkg__AssetType__c,
            	acm_pkg__AssetVersion__c,
            	acm_pkg__CommunityId__c,
            	acm_pkg__CommunityName__c,
            	CreatedById,
            	acm_pkg__Description__c,acm_pkg__Icon__c,acm_pkg__Key__c,acm_pkg__LastModified__c,LastModifiedById,acm_pkg__Name__c,acm_pkg__NavigateUrl__c,OwnerId,acm_pkg__VersionGroup__c, acm_pkg__Visibility__c
            FROM acm_pkg__CommunityApi__c
            WHERE acm_pkg__CommunityId__c = :communityId
        ];
    }

    @AuraEnabled
    public static List<acm_pkg__AnypointApiCategories__x> getAllCategories() {
        return [SELECT acm_pkg__Id__c, acm_pkg__ApiVersionId__c, acm_pkg__Name__c, acm_pkg__Values__c FROM acm_pkg__AnypointApiCategories__x];
    }

    @AuraEnabled
    public static string getCommunityId() {
        return Network.getNetworkId();
    }

    @AuraEnabled
    public static ConnectApi.Community getCommunity() {
        String communityId = Network.getNetworkId();
        return ConnectApi.Communities.getCommunity(communityId);
    }

    @AuraEnabled
    public static List<ConnectApi.Community> getCommunities() {
        return ConnectApi.Communities.getCommunities().communities;
    }

    // private stuff
    public static Set<String> toScapeSet(List<String> valuesToScape) {
        final Set<String> values = new Set<String>();
        for (String value : valuesToScape) {
            if (value != null) values.add(String.escapeSingleQuotes(value));
        }
        return values;
    }

}