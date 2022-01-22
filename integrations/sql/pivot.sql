CREATE TABLE Persons (
    PersonID int,
    SurName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

SELECT [Sydney], [Melbourne], [Canberra], [Hobart]
FROM
    (SELECT City from Persons)
    PIVOT  
        (COUNT(Cite)
            FOR City IN ([Sydney], [Melbourne], [Canberra], [Hobart])  
        ) ;