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

  lt_languages = value #( ( id = 1 name = 'Java' publishing_year = '1995' website_url = 'https://www.java.com/en/' rating = '19' )
                        ( id = 2 name = 'C' publishing_year = '1972' website_url = 'https://www.cprogramming.com/' rating = '4' )
                        ( id = 3 name = 'C++' publishing_year = '1985' website_url = 'http://www.cplusplus.com/' rating = '3' )
                        ( id = 4 name = 'Javascript' publishing_year = '1995' website_url = 'https://www.javascript.com/' rating = '8' )
                        ( id = 5 name = 'C#' publishing_year = '2001' website_url = 'https://dotnet.microsoft.com' rating = '7' )
                        ( id = 6 name = 'Python' publishing_year = '1990' website_url = 'https://www.python.org/' rating = '29' )
                        ( id = 7 name = 'Kotlin' publishing_year = '2011' website_url = 'https://kotlinlang.org/' rating = '1' )
                        ( id = 8 name = 'Swift' publishing_year = '2014' website_url = 'https://swift.org/' rating = '5')
                        ( id = 9 name = 'PHP' publishing_year = '1995' website_url = 'https://www.php.net/' rating = '6' )
                        ( id = 10 name = 'R' publishing_year = '1993' website_url = 'https://www.r-project.org/' rating = '3' ) ).

* delete existing entries in the database table
DELETE FROM zlanguages_06.

sort lt_languages by rating DESCENDING.

* insert the new table entries
INSERT zlanguages_06 FROM TABLE @lt_languages.

* check the result
SELECT * FROM zlanguages_06 INTO TABLE @lt_languages.
out->write( sy-dbcnt ).
out->write( lt_languages ).
out->write( 'Language data inserted successfully!').

ENDMETHOD.
ENDCLASS.


