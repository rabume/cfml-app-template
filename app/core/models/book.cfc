component persistent="true" entityname="Book" table="books" {

    property name="id" fieldtype="id" generator="identity";
    property
        name="title"
        ormtype="string"
        sqltype="varchar"
        length="255"
        notnull="true";
    property
        name="author"
        ormtype="string"
        sqltype="varchar"
        length="255"
        notnull="true";
    property
        name="isbn"
        ormtype="string"
        sqltype="varchar"
        length="255"
        notnull="true";
    property
        name="publisher"
        ormtype="string"
        sqltype="varchar"
        length="255"
        notnull="true";
    property name="pages" ormtype="integer" notnull="true";

    // Constructor
    function init() {
        return this;
    }

}
