CLASS lhc_Language DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validateRating FOR VALIDATION Language~validateRating
      IMPORTING keys FOR Language.

   METHODS validateName FOR VALIDATION Language~validateName
      IMPORTING keys FOR Language.

    METHODS validateYear FOR VALIDATION Language~validateYear
      IMPORTING keys FOR Language.

    METHODS setFavourite FOR MODIFY IMPORTING keys FOR ACTION Language~setFavourite RESULT result.
    METHODS get_features FOR FEATURES IMPORTING keys REQUEST    requested_features FOR Language    RESULT result.


    METHODS detachFavourite FOR MODIFY IMPORTING keys FOR ACTION Language~detachFavourite RESULT result.

ENDCLASS.

CLASS lhc_Language IMPLEMENTATION.

**********************************************************************
*
* Check name is not empty
*
**********************************************************************


  METHOD validateName.

    READ ENTITY ZI_Languages_M_06\\Language FROM VALUE #(
        FOR <root_key> IN keys ( %key = <root_key>
                                %control = VALUE #( name = if_abap_behv=>mk-on ) ) )
        RESULT DATA(lt_language).


    " Raise msg for non existing name
    LOOP AT lt_language INTO DATA(ls_language).
      IF ls_language-name is INITIAL.
        APPEND VALUE #(  %key = ls_language-%key
                            id = ls_language-id ) TO failed.
        APPEND VALUE #( %key = ls_language-%key
                  %msg  = new_message(
                    id   = 'ZHSKA06' "Message Class
                    number = '001' "Number
                    severity = if_abap_behv_message=>severity-error )
                  %element-id = if_abap_behv=>mk-on ) TO reported.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

**********************************************************************
*
* Check validity of rating
*
**********************************************************************

Method validateRating.

READ ENTITY ZI_Languages_M_06\\Language FROM VALUE #(
        FOR <root_key> IN keys ( %key = <root_key>
                                %control = VALUE #( rating = if_abap_behv=>mk-on ) ) )
        RESULT DATA(lt_language).


    " Raise msg for wrong rating
    LOOP AT lt_language INTO DATA(ls_language).
      if ls_language-rating is not INITIAL and ( ls_language-rating not BETWEEN 1 and 100 ).
        APPEND VALUE #(  %key = ls_language-%key
                            id = ls_language-id ) TO failed.
        APPEND VALUE #( %key = ls_language-%key
                  %msg  = new_message(
                    id   = 'ZHSKA06' "Message Class
                    number = '003' "Number
                    severity = if_abap_behv_message=>severity-error )
                  %element-id = if_abap_behv=>mk-on ) TO reported.
      ENDIF.

   ENDLOOP.

ENDMETHOD.

**********************************************************************
*
* Check if publishing_year is not empty
*
**********************************************************************

Method validateYear.

    READ ENTITY ZI_Languages_M_06\\Language FROM VALUE #(
        FOR <root_key> IN keys ( %key = <root_key>
                                %control = VALUE #( publishing_year = if_abap_behv=>mk-on ) ) )
        RESULT DATA(lt_language).


    " Raise msg for non existing year
    LOOP AT lt_language INTO DATA(ls_language).
      IF ls_language-publishing_year is INITIAL or NOT ( ls_language-publishing_year CO '0123456789' ).
        APPEND VALUE #(  %key = ls_language-%key
                            id = ls_language-id ) TO failed.
        APPEND VALUE #( %key = ls_language-%key
                  %msg  = new_message(
                    id   = 'ZHSKA06' "Message Class
                    number = '002' "Number
                    severity = if_abap_behv_message=>severity-error )
                  %element-id = if_abap_behv=>mk-on ) TO reported.
      ENDIF.

    ENDLOOP.

endmethod.

  METHOD setFavourite.
         " Modify in local mode: BO-related updates that are not relevant for authorization checks
    MODIFY ENTITIES OF ZI_Languages_M_06 IN LOCAL MODE
           ENTITY Language
              UPDATE FROM VALUE #( FOR key IN keys ( id = key-id
                                                     favourite = '♥' " Favourite
                                                     %control-favourite = if_abap_behv=>mk-on ) )
           FAILED   failed
           REPORTED reported.

    " Read changed data for action result
    READ ENTITIES OF ZI_Languages_M_06 IN LOCAL MODE
         ENTITY Language
         FROM VALUE #( FOR key IN keys (  id = key-id
                                          %control = VALUE #(
                                            id       = if_abap_behv=>mk-on
                                            publishing_year     = if_abap_behv=>mk-on
                                            website_url      = if_abap_behv=>mk-on
                                            rating        = if_abap_behv=>mk-on
                                            favourite        = if_abap_behv=>mk-on

                                          ) ) )
         RESULT DATA(lt_language).

    result = VALUE #( FOR Language IN lt_language ( id = Language-id
                                                %param    = Language
                                              ) ).

  ENDMETHOD.

  METHOD detachfavourite.

          " Modify in local mode: BO-related updates that are not relevant for authorization checks
    MODIFY ENTITIES OF ZI_Languages_M_06 IN LOCAL MODE
           ENTITY Language
              UPDATE FROM VALUE #( FOR key IN keys ( id = key-id
                                                     favourite = ''
                                                     %control-favourite = if_abap_behv=>mk-on ) )
           FAILED   failed
           REPORTED reported.

    " Read changed data for action result
    READ ENTITIES OF ZI_Languages_M_06 IN LOCAL MODE
         ENTITY Language
         FROM VALUE #( FOR key IN keys (  id = key-id
                                          %control = VALUE #(
                                            id       = if_abap_behv=>mk-on
                                            publishing_year     = if_abap_behv=>mk-on
                                            website_url      = if_abap_behv=>mk-on
                                            rating        = if_abap_behv=>mk-on
                                            favourite        = if_abap_behv=>mk-on

                                          ) ) )
         RESULT DATA(lt_language).

    result = VALUE #( FOR Language IN lt_language ( id = Language-id
                                                %param    = Language
                                              ) ).

  ENDMETHOD.

  METHOD get_features.
     "%control-<fieldname> specifies which fields are read from the entities

    READ ENTITY ZI_Languages_M_06 FROM VALUE #( FOR keyval IN keys
                                                      (  %key                    = keyval-%key
                                                         %control-favourite = if_abap_behv=>mk-on
                                                        ) )
                                RESULT DATA(lt_langauge).


    result = VALUE #( FOR ls_language IN lt_langauge
                       ( %key                           = ls_language-%key
                         %features-%action-setFavourite = COND #( WHEN ls_language-favourite = '♥'
                                                                    THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled   )
                        %features-%action-detachFavourite = COND #( WHEN ls_language-favourite = ''
                                                                    THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled   )
                      )

                      ).


  ENDMETHOD.

ENDCLASS.
