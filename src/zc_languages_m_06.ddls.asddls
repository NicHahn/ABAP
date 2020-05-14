@EndUserText.label: 'Language projection view - Processor'
@AccessControl.authorizationCheck: #CHECK

@Search.searchable: true

@UI.headerInfo: {
        typeName: 'Programming Language',
        typeNamePlural: 'Programming Languages',
        title: { type: #STANDARD, value: 'Name' }
    }

@UI.chart: [{
                title: 'Programming Languages',
                description: 'Line-chart displaying the gross amount by customer',
                chartType: #LINE,
                dimensions: [ 'Name' ], -- Reference to one element
                measures: [ 'Rating' ] -- Reference to one or more elements
        }]

define root view entity ZC_Languages_M_06
  as projection on ZI_languages_M_06
{
      @UI.facet: [ { id:              'Language',
                      purpose:         #STANDARD,
                      type:            #IDENTIFICATION_REFERENCE,
                      label:           'Information',
                      position:        10 },
                     { id:'idHeader',
                       type:  #DATAPOINT_REFERENCE,
                       position: 9,
                       purpose: #HEADER,
                       targetQualifier: 'Rating'
                      }]

      @UI.hidden: true
  key id              as Language_ID,


      @UI: {
          lineItem:       [ { position: 20, importance: #HIGH } ],
          identification: [ { position: 1, label: 'Programming Language' } ] ,
          dataPoint: { title: 'Programming Language'}}
      @Search.defaultSearchElement: true
      name            as Name,

      @UI: {
          lineItem:       [ { position: 30, importance: #HIGH, label: 'Publishing Year' } ],
          identification: [ { position: 30, label: 'Publishing year' } ] }
      publishing_year as Publishing_Year,

      @UI: {
          lineItem:       [ { position: 40, importance: #HIGH, type: #WITH_URL, url: 'Website_URL', label: 'Website' } ],
          identification: [ { position: 40, type: #WITH_URL, url: 'Website_URL', label: 'Website' } ] }
      website_url     as Website_URL,

      @UI: {
        lineItem:       [ { position: 50, importance: #HIGH, type: #AS_DATAPOINT, label: 'Rating in %' } ],
        identification: [ { position: 50, label: 'Rating [1-100]'} ],
        dataPoint: {  title: 'Rating', visualization: #PROGRESS, targetValue: 100 } }
      rating          as Rating,

      @UI: {
             lineItem: [ { position: 45, importance: #HIGH },
             { type: #FOR_ACTION, dataAction: 'setFavourite', label: 'Mark as favourite' },
             { type: #FOR_ACTION, dataAction: 'detachFavourite', label: 'Remove favourite' } ],
            identification: [ { position: 45, label: 'Status [(Favourite)]' } ] }
      favourite       as Favourite



}
