---
layout: post
title: "Introducing the Jenesis Data Store"
tags: [jenesis,data,store,database,db,mysql,postgres,sqlite,code,java]
disqus_identifier: jenesis_data_store
---
So, I was working on a project and frequently got frustrated whenever I had to update my database design. This was a by-product of rapidly altering my programs workflows and thus class definitions. I realised that I needed a more effective way to make changes to my backend in order to improve turnaround times.

As someone who was only familiar with relational databases (sorry, NoSQL) I decided to investigate the use of Object Relational Models(ORMS). However, I am really, REALLY, lazy. I couldn’t bring myself to read official documentation nor to fully understand how they worked. Furthermore, conventional ORMS seemed to require mapping classes to defined Schemas in the backend, what I wanted to avoid in the first place.

Given all that I decided to create a library that would allow me to easily create classes and persist data in a relational schema without requiring me to design each relation or worry about modifying their structures.
 
# The solution, introducing the Jenesis Data Store
Jenesis Data Store (JDS) was created to help developers persist their classes to relational databases in a fast and reliable manner, without requiring them to design elaborate relational schemas. The aim of JDS is to allow for the rapid creation and modification of java classes in order to facilitate rapid prototyping and quick development.

The library eliminates the need to modify schemas once a class has been altered. It also eliminates all concerns regarding "breaking changes" in regards to fields and their values. Fields, Objects and Array Types can be added, modified or removed at will. Beyond that the libraries data is structured in a way to promote fast and efficient Data Mining queries that can be used to support the application in question or to feed into specialised analytic software.

Put simply, JDS is useful for any developer that requires a flexible schema running on top of a traditional Relational Database. Some use-cases include:
- Rapid prototyping
- Academic projects
- Single or Multi-user applications
- Self hosted REST/SOAP services

JDS is licensed under the [3-Clause BSD License](https://opensource.org/licenses/BSD-3-Clause)

## Features
- Transparent persistence for Plain Old Java Objects (POJOs) 
- Easily integrates with new or existing databases
- Supports MySQL, T-SQL, PostgreSQL and SQLite
- Underlying database implemented using the Star Schema
- Save, Updates and Deletes cascade to child objects and collections
- Eager Loading is applied to embedded objects as well as on collections

## Design
The concept behind JDS is quite simple. Extend a base "Entity" class, define "Fields" of a particular datatype and lastly "Map" the said fields to a Java property. Done.

A detailed tutorial on how to use the library follows below.

# Latest Version
Currently the latest version is [![Maven Central](https://maven-badges.herokuapp.com/maven-central/io.github.subiyacryolite/jds/badge.svg)](https://maven-badges.herokuapp.com/maven-central/io.github.subiyacryolite/jds)

# Using the library
The library is hosted on Maven Central and you can import it into your project using your dependency manager. Examples for Maven and Gradle are listed below.

## Maven
```xml
<dependency>
    <groupId>io.github.subiyacryolite</groupId>
    <artifactId>jds</artifactId>
    <version>1.1704014</version>
</dependency>
```
## Gradle
```json
    compile 'io.github.subiyacryolite:jds:1704014'
```

# Dependencies
The library depends on Java 8. Both 64 and 32 bit variants should suffice. Both the Development Kit and Runtime can be downloaded from [here](http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html).

# Supported Databases
The API currently supports the following Relational Databases, each of which has their own dependencies, versions and licensing requirements. Please consult the official sites for specifics.

|Database|Version Tested Against|Official Site|JDBC Driver Tested Against
|-------|-----------|-----------|-----------|
| PostgreSQL            | 9.5         | [Official Site](https://www.postgresql.org/)        | [org.postgresql](https://mvnrepository.com/artifact/org.postgresql/postgresql)|
| MySQL            |5.7.14         | [Official Site](https://www.mysql.com/downloads/)        | [com.mysql.cj.jdbc.Driver](https://mvnrepository.com/artifact/mysql/mysql-connector-java)|
| Microsoft SQL Server | 2008 R2     | [Official Site](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)        | [com.microsoft.sqlserver](https://mvnrepository.com/artifact/com.microsoft.sqlserver/sqljdbc4)|
| SQLite            | 3.16.1   | [Official Site](https://www.sqlite.org/)    | [org.sqlite.JDBC](https://mvnrepository.com/artifact/org.xerial/sqlite-jdbc)|


# 1 How it works

## 1.1 Creating Classes
Classes that use JDS need to extend JdsEntity.
```java
public class Customer extends JdsEntity
```
Following that the following steps need to be taken.

### 1.1.1 Annotating Classes
Every class that extends JdsEntity must have its own unique Entity Id as well as Entity Name. This is done by annotating the class in the following manner
```java
@JdsEntityAnnotation(entityId = 5, entityName = "Customer")
public class Customer extends JdsEntity
```
Entity IDs MUST be unique in your application, any value of type long is valid. Entity Names do not enforce unique constraints but its best to use a unique name regardless. These values can be referenced to mine data.

### 1.1.2 Defining Fields
JdsFields are big part of the JDS framework. Each field MUST have a unique Field Id. Field Names do not enforce unique constraints but its best to use a unique name regardless. These values can be referenced to mine data. Every field that you define can be one of the following types.

|JDS Field Type|Java Type|Description|
|-----|-----|-----|
|BOOLEAN|boolean|Boolean values|
|FLOAT|float|Numeric float values|
|INT|int|Numeric integer values|
|DOUBLE|double|Numeric double values|
|LONG|long|Numeric long values|
|TEXT|String|String values with no max limit|
|DATE_TIME|LocalDateTime|DateTime instances based on the host machines local timezone|
|ZONED_DATE_TIME|ZonedDateTime|Zoned DateTime instances|
|TIME|LocalTime|Local time instances|
|DATE|LocalDate|Local date instances|
|ARRAY_FLOAT|List\<Float\>|Lists of type Float|
|ARRAY_INT|List\<Integer\>|Lists of type Integer|
|ARRAY_DOUBLE|List\<Double\>|Lists of type Double|
|ARRAY_LONG|List\<Long\>|Lists of type Long|
|ARRAY_TEXT|List\<String\>|Lists of type String|
|ARRAY_DATE_TIME|List\<LocalDateTime\>|Lists of type LocalDateTime|
|ENUM_TEXT|List\<String\>|Lists of type String|

I recommend defining your fields as static constants

```java
import io.github.subiyacryolite.jds.JdsField;
import io.github.subiyacryolite.jds.enums.JdsFieldType;

public class NewTestFields {
    public static final JdsField STRING_FIELD = new JdsField(1000, "STRING_FIELD", JdsFieldType.TEXT);
    public static final JdsField TIME_FIELD = new JdsField(1009, "TIME_FIELD", JdsFieldType.TIME);
    public static final JdsField DATE_FIELD = new JdsField(1001, "DATE_FIELD", JdsFieldType.DATE);
    public static final JdsField DATE_TIME_FIELD = new JdsField(1002, "DATE_TIME_FIELD", JdsFieldType.DATE_TIME);
    public static final JdsField ZONED_DATE_TIME_FIELD = new JdsField(1003, "ZONED_DATE_TIME_FIELD", JdsFieldType.ZONED_DATE_TIME);
    public static final JdsField LONG_FIELD = new JdsField(1004, "LONG_FIELD", JdsFieldType.LONG);
    public static final JdsField INT_FIELD = new JdsField(1005, "INT_FIELD", JdsFieldType.INT);
    public static final JdsField DOUBLE_FIELD = new JdsField(1006, "DOUBLE_FIELD", JdsFieldType.DOUBLE);
    public static final JdsField FLOAT_FIELD = new JdsField(1007, "FLOAT_FIELD", JdsFieldType.FLOAT);
    public static final JdsField BOOLEAN_FIELD = new JdsField(1008, "BOOLEAN_FIELD", JdsFieldType.BOOLEAN);
}

```

### 1.1.3 Defining Enums
JdsEnums are an extension of fields. However, they are designed for cases where one or more constant values are required. Usually these values would be represented by CheckBoxes or RadioButtons in a UI. In this example, we will define Sex as an enumerated value with the following options (Male, Female, Other).
First of all, we'd have to define a standard field of type ENUM_TEXT.
```java
public class NewTestFields
{
    //---
    //---
    public static final JdsField SEX_ENUM = new JdsField(6, "sex_enum", JdsFieldType.ENUM_TEXT);
}
```
Then, we can define our actual enum in the following manner.
```java
public class NewTestEnums
{
    public final static JdsFieldEnum SEX_ENUMS = new JdsFieldEnum(NewTestFields.SEX_ENUM, "Male", "Female", "Other");
}
```
Behind the scenes these enums will be stored as an Integer Array. However, you'd be presented with a List\<String\> in-memory containing one or more of the defined values.

### 1.1.4 Binding Properties
Depending on the type of field, JDS will require that you set you objects properties to one of the following container types.

|JDS Field Type|Java Property Type|
|-----|-----|
|BOOLEAN|[SimpleBooleanProperty](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleBooleanProperty.html)|
|FLOAT|[SimpleFloatProperty](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleFloatProperty.html)|
|INT|[SimpleIntegerProperty](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleIntegerProperty.html)|
|DOUBLE|[SimpleDoubleProperty](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleDoubleProperty.html)|
|LONG|[SimpleLongProperty](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleLongProperty.html)|
|TEXT|[SimpleStringProperty](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleStringProperty.html)|
|DATE_TIME|[SimpleObjectProperty\<LocalDateTime\>](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDateTime.html)|
|ZONED_DATE_TIME|[SimpleObjectProperty\<ZonedDateTime\>](https://docs.oracle.com/javase/8/docs/api/java/time/ZonedDateTime.html)|
|TIME|[SimpleObjectProperty\<LocalTime\>](https://docs.oracle.com/javase/8/docs/api/java/time/LocalTime.html)|
|DATE|[SimpleObjectProperty\<LocalDate\>](https://docs.oracle.com/javase/8/docs/api/java/time/LocalDate.html)|
|ARRAY_FLOAT|[SimpleListProperty\<Float\>](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleListProperty.html)|
|ARRAY_INT|[SimpleListProperty\<Integer\>](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleListProperty.html)|
|ARRAY_DOUBLE|[SimpleListProperty\<Double\>](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleListProperty.html)|
|ARRAY_LONG|[SimpleListProperty\<Long\>](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleListProperty.html)|
|ARRAY_TEXT|[SimpleListProperty\<String\>](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleListProperty.html)|
|ARRAY_DATE_TIME|[SimpleListProperty\<LocalDateTime\>](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleListProperty.html)|
|ENUM_TEXT|[SimpleListProperty\<String\>](https://docs.oracle.com/javafx/2/api/javafx/beans/property/SimpleListProperty.html)|

 After your class and its properties have been defined you must map the property to its corresponding field using the **map()** method. I recommend doing this in your constructor. 
 
 The example below shows a class definition with valid properties and bindings. With this your class can be persisted.

```java
import io.github.subiyacryolite.jds.JdsEntity;
import io.github.subiyacryolite.jds.annotations.JdsEntityAnnotation;
import javafx.beans.property.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZonedDateTime;

@JdsEntityAnnotation(entityId = 3, entityName = "Type Class")
public class TypeClass extends JdsEntity {
    private final SimpleStringProperty stringField;
    private final SimpleObjectProperty<LocalTime> timeField;
    private final SimpleObjectProperty<LocalDate> dateField;
    private final SimpleObjectProperty<LocalDateTime> dateTimeField;
    private final SimpleObjectProperty<ZonedDateTime> zonedDateTimeField;
    private final SimpleLongProperty longField;
    private final SimpleIntegerProperty intField;
    private final SimpleDoubleProperty doubleField;
    private final SimpleFloatProperty floatField;
    private final SimpleBooleanProperty booleanField;

    public TypeClass() {
        stringField = new SimpleStringProperty("");
        timeField = new SimpleObjectProperty<LocalTime>(LocalTime.now());
        dateField = new SimpleObjectProperty<LocalDate>(LocalDate.now());
        dateTimeField = new SimpleObjectProperty<LocalDateTime>(LocalDateTime.now());
        zonedDateTimeField = new SimpleObjectProperty<ZonedDateTime>(ZonedDateTime.now());
        longField = new SimpleLongProperty(0);
        intField = new SimpleIntegerProperty(0);
        doubleField = new SimpleDoubleProperty(0);
        floatField = new SimpleFloatProperty(0);
        booleanField = new SimpleBooleanProperty(false);
        //map
        map(NewTestFields.STRING_FIELD, stringField);
        map(NewTestFields.DATE_FIELD, dateField);
        map(NewTestFields.TIME_FIELD, timeField);
        map(NewTestFields.DATE_TIME_FIELD, dateTimeField);
        map(NewTestFields.ZONED_DATE_TIME_FIELD, zonedDateTimeField);
        map(NewTestFields.LONG_FIELD, longField);
        map(NewTestFields.INT_FIELD, intField);
        map(NewTestFields.DOUBLE_FIELD, doubleField);
        map(NewTestFields.FLOAT_FIELD, floatField);
        map(NewTestFields.BOOLEAN_FIELD, booleanField);
    }

    public TypeClass(String str, 
                     LocalTime timeField, 
                     LocalDate localDate, 
                     LocalDateTime localDateTime, 
                     ZonedDateTime zonedDateTime, 
                     long l, 
                     int i, 
                     double d, 
                     float f, 
                     boolean b) {
        this();
        setStringField(str);
        setTimeField(timeField);
        setDateField(localDate);
        setDateTimeField(localDateTime);
        setZonedDateTimeField(zonedDateTime);
        setLongField(l);
        setIntField(i);
        setDoubleField(d);
        setFloatField(f);
        setBooleanField(b);
    }

    public String getStringField() {
        return stringField.get();
    }

    public void setStringField(String stringField) {
        this.stringField.set(stringField);
    }

    public LocalTime getTimeField() {
        return timeField.get();
    }

    public void setTimeField(LocalTime dateField) {
        this.timeField.set(dateField);
    }

    public LocalDate getDateField() {
        return dateField.get();
    }

    public void setDateField(LocalDate dateField) {
        this.dateField.set(dateField);
    }

    public LocalDateTime getDateTimeField() {
        return dateTimeField.get();
    }

    public void setDateTimeField(LocalDateTime dateTimeField) {
        this.dateTimeField.set(dateTimeField);
    }

    public ZonedDateTime getZonedDateTimeField() {
        return zonedDateTimeField.get();
    }

    public void setZonedDateTimeField(ZonedDateTime zonedDateTimeField) {
        this.zonedDateTimeField.set(zonedDateTimeField);
    }

    public long getLongField() {
        return longField.get();
    }

    public void setLongField(long longField) {
        this.longField.set(longField);
    }

    public int getIntField() {
        return intField.get();
    }

    public void setIntField(int intField) {
        this.intField.set(intField);
    }

    public double getDoubleField() {
        return doubleField.get();
    }

    public void setDoubleField(double doubleField) {
        this.doubleField.set(doubleField);
    }

    public float getFloatField() {
        return floatField.get();
    }

    public void setFloatField(float floatField) {
        this.floatField.set(floatField);
    }

    public boolean getBooleanField() {
        return booleanField.get();
    }

    public void setBooleanField(boolean booleanField) {
        this.booleanField.set(booleanField);
    }

    @Override
    public String toString() {
        return "TypeClass{" +
                "stringField = " + getStringField() +
                ", timeField = " + getTimeField() +
                ", dateField = " + getDateField() +
                ", dateTimeField = " + getDateTimeField() +
                ", zonedDateTimeField = " + getZonedDateTimeField() +
                ", longField = " + getLongField() +
                ", intField = " + getIntField() +
                ", doubleField = " + getDoubleField() +
                ", floatField = " + getFloatField() +
                ", booleanField = " + getBooleanField() +
                '}';
    }
}
```
### 1.1.5 Binding Objects and Object Arrays
Beyond saving numeric, string and date values JDS can also persist embedded objects and object arrays. All that's required is a valid JdsEntity subclass to be mapped based on the embedded objects annotations.

The class below shows how you can achieve this.

```java
import javafx.beans.property.SimpleListProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import io.github.subiyacryolite.jds.JdsEntity;
import io.github.subiyacryolite.jds.annotations.JdsEntityAnnotation;

import java.util.List;

@JdsEntityAnnotation(entityId = 2, entityName = "Simple Address Book")
public class SimpleAddressBook extends JdsEntity {
    private final SimpleListProperty<SimpleAddress> addresses = new SimpleListProperty<>(FXCollections.observableArrayList());

    public SimpleAddressBook() {
        map(SimpleAddress.class, addresses);
    }

    public List<SimpleAddress> getAddresses() {
        return this.addresses.get();
    }

    public void setAddresses(List<SimpleAddress> value) {
        this.addresses.set((ObservableList<SimpleAddress>) value);
    }

    @Override
    public String toString() {
        return "SimpleAddressBook{" +
                "addresses = " + getAddresses() +
                '}';
    }
}
```

## 1.2 CRUD Operations
### 1.2.1 Initialising the database
In order to use JDS you will need an instance of JdsDataBase. The instance you create will depend on your underlying backend. Beyond that your project must have the correct JDBC driver in its class path. The drivers that were used during development are listed under [Supported Databases](#supported-databases) above.
#### Postgres example
```java
String dbDriverName = "org.postgresql.Driver";
String dbConnectionString = "jdbc:postgresql://127.0.0.1:5432/PROJECT_DATABASE";
String dbUser = "DATABASE_USER";
String dbPassword = "DATABASE_PASSWORD";
JdsDataBase jdsDataBase = JdsDataBase.getImplementation(JdsImplementation.POSTGRES);
jdsDataBase.setConnectionProperties(dbDriverName, dbConnectionString, dbUser, dbPassword);
jdsDataBase.init();
```
#### MySQL Example
```java
String dbDriverName = "com.mysql.cj.jdbc.Driver";
String dbConnectionString = "jdbc:mysql://localhost:3306/jds?autoReconnect=true&useSSL=false";
String dbUser = "root";
String dbPassword = "";
JdsDataBase jdsDataBase = JdsDataBase.getImplementation(JdsImplementation.MYSQL);
jdsDataBase.setConnectionProperties(dbDriverName, dbConnectionString, dbUser, dbPassword);
jdsDataBase.init();
```
#### Microsoft SQL Server Example
```java
String dbDriverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
String dbConnectionString = "jdbc:sqlserver://127.0.0.1\\DATABASE_INSTANCE;databaseName=PROJECT_DATABASE";
String dbUser = "DATABASE_USER";
String dbPassword = "DATABASE_PASSWORD";
JdsDataBase jdsDataBase = JdsDataBase.getImplementation(JdsImplementation.TSQL);
jdsDataBase.setConnectionProperties(dbDriverName, dbConnectionString, dbUser, dbPassword);
jdsDataBase.init();
```
#### Sqlite Example
```java
String databaseLocation = "jdbc:sqlite:" + getDatabaseFileLocation();
SQLiteConfig sqLiteConfig = new SQLiteConfig();
sqLiteConfig.enforceForeignKeys(true); //You must enable foreign keys in SQLite
jdsDataBase.setConnectionProperties(databaseLocation, sqLiteConfig.toProperties());
jdsDataBase.init(); //prepareDatabaseComponent() in 1.170402
```
With this you should have a valid connection to your database and JDS will setup its tables and procedures automatically. Furthermore, you can use the **getConnection()** method from your JdsDataBase instance in order to return a standard **java.sql.Connection** in your application. 

### 1.2.2 Initialising JDS
Once you have initialised your database you can go ahead and initialise all your JDS classes. You can achieve this by mapping ALL your JDS classes in the following manner.
```java
public void initialiseJdsClasses()
{
    JdsEntityClasses.map(TypeClass.class);
    JdsEntityClasses.map(SimpleAddress.class);
    JdsEntityClasses.map(SimpleAddressBook.class);
}
```
You only have to do this once at start-up but it is vital that you do so. Without this you will face problems when loading or saving records

### 1.2.3 Creating objects
Once you have defined your class you can initialise them. A dynamic **Entity Guid** is created for every jdsEntity by default, this value is used to uniquely identify an object and it data in the database. You can set your own values if you wish.
```java
private List<TypeClass> getCollection() {
    List<TypeClass> collection = new ArrayList<>();
    
    TypeClass instance1 = new TypeClass();
    instance1.setEntityGuid("instance1");
    instance1.setStringField("One");
    
    TypeClass instance2 = new TypeClass();
    instance2.setStringField("tWO");
    instance2.setTimeField(LocalTime.of(15, 24));
    instance2.setDateField(LocalDate.of(2012, 8, 26));
    instance2.setDateTimeField(LocalDateTime.of(1991, 07, 01, 8, 33, 12));
    instance2.setZonedDateTimeField(ZonedDateTime.of(LocalDateTime.now().minusMonths(3), ZoneId.systemDefault()));
    instance2.setIntField(99);
    instance2.setLongField(888);
    instance2.setDoubleField(777.666);
    instance2.setFloatField(5555.4444f);
    instance2.setBooleanField(false);
    instance2.setEntityGuid("instance2");
    
    TypeClass instance3 = new TypeClass();
    instance3.setStringField("Three");
    instance3.setTimeField(LocalTime.of(03, 14));
    instance3.setDateField(LocalDate.of(2034, 6, 14));
    instance3.setDateTimeField(LocalDateTime.of(1987, 07, 24, 13, 22, 45));
    instance3.setZonedDateTimeField(ZonedDateTime.of(LocalDateTime.now().plusDays(3), ZoneId.systemDefault()));
    instance3.setIntField(22);
    instance3.setLongField(333);
    instance3.setDoubleField(444.555);
    instance3.setFloatField(5555.6666f);
    instance3.setBooleanField(false);
    instance3.setEntityGuid("instance3");
    
    TypeClass instance4 = new TypeClass();
    instance4.setStringField("Four");
    instance4.setTimeField(LocalTime.of(12, 44));
    instance4.setDateField(LocalDate.of(3034, 12, 1));
    instance4.setDateTimeField(LocalDateTime.of(1964, 10, 24, 2, 12, 14));
    instance4.setZonedDateTimeField(ZonedDateTime.of(LocalDateTime.now().minusDays(3), ZoneId.systemDefault()));
    instance4.setIntField(10);
    instance4.setLongField(100);
    instance4.setDoubleField(100.22);
    instance4.setFloatField(1000.0f);
    instance4.setBooleanField(false);
    instance4.setEntityGuid("instance4");
    
    collection.add(instance1);
    collection.add(instance2);
    collection.add(instance3);
    collection.add(instance4);
    return collection;
}
```

### 1.2.4 Save
The API has a single **save()** method within the class **JdsSave**. The method can takes either one of the following arguments **(JdsEntity... entities)** or **(Collection\<JdsEntity\> entities)**. The method also expects the user to supply a batch size.
```java
List<TypeClass> collection = getCollection();
JdsSave.save(jdsDataBase, 1, collection);
System.out.printf("Saved %s\n", collection);
```

### 1.2.5 Load
The system currently has three variants of the **load()** method. The first variant loads ALL the instances of a JdsEntity class. The second variant loads ALL the instances of a JdsEntity class with matching Entity Guids which are supplied by the user. The second variant adds an optional parameter "Comparator<? extends JdsEntity>" which allows you to load a sorted collection
```java
List<TypeClass> allInstances;
List<TypeClass> specificInstance;

//load all entities of type SimpleAddressBook
allInstances = JdsLoad.load(jdsDataBase, TypeClass.class);

//load all entities of type SimpleAddressBook with Entity Guids in range
specificInstance = JdsLoad.load(jdsDataBase, TypeClass.class, "instance3");

//load all entities of type SimpleAddressBook with Entity Guids in range SORTED by creation date
Comparator<TypeClass> comparator = Comparator.comparing(TypeClass::getDateField);
specificAddressBook = JdsLoad.load(jdsDataBase, TypeClass.class, comparator, "testGuid0001");
```

### 1.2.6 Load with Filter
A filter mechanism is present. It is fairly basic and is still being refined. An example to sample usage is shown below.
```java
JdsFilter query = new JdsFilter().equals(TestFields.AREA_NAME, "Riverdale").like(TestFields.COUNTRY_NAME, "Zam").or().equals(TestFields.PROVINCE_NAME, "Copperbelt");
List<SimpleAddress> output = query.find(jdsDataBase, SimpleAddress.class);
```

### 1.2.7 Delete
You can delete by providing one or more JdsEntities or via a collection of strings representing JdsEntity UUIDS.
```java
public void deleteUsingStrings() {
    JdsDelete.delete(jdsDataBase, "instance2");
}

public void deleteUsingObjectOrCollection() {
    List<TypeClass> collection = getCollection();
    JdsDelete.delete(jdsDataBase, collection);
}
```

## 1.3 Backend Design
Section coming soon, but it looks like this

![Database design](https://raw.githubusercontent.com/SubiyaCryolite/Jenesis-Data-Store/master/database_design.png)

# Development
I highly recommend the use of the [IntelliJ IDE](https://www.jetbrains.com/idea/download/) for development.

# Contributing to Jenesis Data Store
If you would like to contribute code you can do so through GitHub by forking the repository and sending a pull request targeting the current development branch.

When submitting code, please make every effort to follow existing conventions and style in order to keep the code as readable as possible.

# Bugs and Feedback
For bugs, questions and discussions please use the [Github Issues](https://github.com/SubiyaCryolite/Jenesis-Data-Store/issues).
