CLASS lhc_Language DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validateRating FOR VALIDATION Language~validateRating
      IMPORTING keys FOR Language.

ENDCLASS.

CLASS lhc_Language IMPLEMENTATION.

  METHOD validateRating.

    READ ENTITY ZI_Languages_M_06\\language FROM VALUE #(
        FOR <root_key> IN keys ( %key = <root_key>
        %control = VALUE #( id = if_abap_behv=>mk-on ) ) )
        RESULT DATA(lt_language).

    DATA lt_languages TYPE SORTED TABLE OF zlanguages_06 WITH UNIQUE KEY id.

    " Optimization of DB select: extract distinct non-initial customer IDs
    lt_languages = CORRESPONDING #( lt_language DISCARDING DUPLICATES MAPPING id = id EXCEPT * ).
    DELETE lt_languages WHERE publishing_year IS INITIAL.
    "DELETE lt_languages WHERE rating = 3.
    CHECK lt_languages IS NOT INITIAL.

  ENDMETHOD.

ENDCLASS.
