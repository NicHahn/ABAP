CLASS yhska_homework DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS yhska_homework IMPLEMENTATION.

 METHOD if_oo_adt_classrun~main.

 data: lt_languages type TABLE of zlanguages_06.

  lt_languages = value #( ( id = 1 name = 'Java' publishing_year = '1995' website_url = 'https://www.java.com/en/' rating = '5' )
                        ( id = 2 name = 'C' publishing_year = '1972' website_url = 'https://www.cprogramming.com/' rating = '2.5' )
                        ( id = 3 name = 'C++' publishing_year = '1985' website_url = '' rating = '3' )
                        ( id = 4 name = 'Javascript' publishing_year = '1995' website_url = 'https://www.javascript.com/' rating = '4' )
                        ( id = 5 name = 'Go' publishing_year = '2009' website_url = 'https://golang.org/' rating = '4' )
                        ( id = 6 name = 'Python' publishing_year = '1990' website_url = 'https://www.python.org/' rating = '5' )
                         ).

* delete existing entries in the database table
DELETE FROM zlanguages_06.

* insert the new table entries
INSERT zlanguages_06 FROM TABLE @lt_languages.

* check the result
SELECT * FROM zlanguages_06 INTO TABLE @lt_languages.
out->write( sy-dbcnt ).
out->write( lt_languages ).
out->write( 'Language data inserted successfully!').

ENDMETHOD.
ENDCLASS.


