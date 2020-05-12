@EndUserText.label: 'Language projection view - Processor'
@AccessControl.authorizationCheck: #CHECK

@Search.searchable: true

define root view entity ZC_Languages_M_06 as projection on ZI_languages_M_06 {
    
    @UI.facet: [ { id:              'Language',
                     purpose:         #STANDARD,
                     type:            #IDENTIFICATION_REFERENCE,
                     label:           'Language',
                     position:        10,
                     targetQualifier: 'rating' }
                     ]


      @UI.hidden: true
      key id       as Language_ID,


      @UI: {
          lineItem:       [ { position: 20, importance: #HIGH } ],
          identification: [ { position: 20, label: 'Name' } ] }
      @Search.defaultSearchElement: true
      name              as Name,

      @UI: {
          lineItem:       [ { position: 30, importance: #MEDIUM } ],
          identification: [ { position: 30, label: 'Publishing year' } ] }
      publishing_year   as Publishing_Year,

      

      @UI: {
          lineItem:       [ { position: 40, importance: #HIGH } ],
          identification: [ { position: 40, label: 'Website URL' } ] }
      website_url as Website_URL,

      

      @UI: {
        lineItem:       [ { position: 50, importance: #HIGH, type: #AS_DATAPOINT } ],
        identification: [ { position: 50, label: 'Rating [0-5]' } ],
        dataPoint: { title: 'Rating', visualization: #RATING, targetValue: 5 } }
      rating            as Rating,
      
      
     
      @UI: { 
             lineItem: [ { position: 60, importance: #HIGH } ] ,
             //{ type: #FOR_ACTION, dataAction: 'setFavourite', label: 'Accept Travel' } ],
            identification: [ { position: 60, label: 'Status [F(Favourite)]' } ] }
     favourite as Favourite
   

      
    
}
