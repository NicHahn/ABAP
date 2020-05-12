@AbapCatalog.sqlViewName: 'ZVI_LANGUAGES_06'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Languages'
define root view ZI_languages_M_06 as select from zlanguages_06 {

    key id,
    name,
    publishing_year,
    website_url,
    rating,
    favourite
    
    
}
