@EndUserText.label: 'Language projection view - Processor'
@AccessControl.authorizationCheck: #CHECK

@Search.searchable: true

@UI.headerInfo: {
        typeName: 'Programm Language',
        typeNamePlural: 'Programm Languages'
    }

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
          lineItem:       [ { position: 30, importance: #HIGH, label: 'Publishing Year' } ],
          identification: [ { position: 30, label: 'Publishing year' } ] }
      publishing_year   as Publishing_Year,

      

      @UI: {
          lineItem:       [ { position: 40, importance: #HIGH, type: #WITH_URL, url: 'Website_URL', label: 'Website' } ],
          identification: [ { position: 40, type: #WITH_URL, url: 'Website_URL', label: 'Website' } ] }
      website_url as Website_URL,

      

      @UI: {
        lineItem:       [ { position: 50, importance: #HIGH, type: #AS_DATAPOINT } ],
        identification: [ { position: 50, label: 'Rating [1-100]' } ],
        dataPoint: { title: 'Rating', visualization: #PROGRESS, targetValue: 100 } }
      rating            as Rating,
      
      
     
      @UI: { 
             lineItem: [ { position: 45, importance: #HIGH }, 
             { type: #FOR_ACTION, dataAction: 'setFavourite', label: 'Mark as favourite' },
             { type: #FOR_ACTION, dataAction: 'detachFavourite', label: 'Remove favourite' } ],
            identification: [ { position: 45, label: 'Status [F(Favourite)]' } ] }
     favourite as Favourite

      
    
}
