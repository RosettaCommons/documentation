#Global Data in Rosetta
###What is global data?

Global data is data that is visible to all parts of the program, or more broadly construed, data for which there is only a single copy for the whole program.

###What counts as global data?

* Data declared at namespace scope either with the keyword "static" or with "extern" or with neither of those keywords. 
If it's at namespace scope, it's global data.

* Data declared as "static" at function scope.

* Data declared as "static" at class scope.

###What is wrong with global data?

The problem with global data is that there is only a single copy of it per program.  In a multithreaded program, if two threads were to try and interact with the data at the same time, they might cause the program to crash, or they might generate the wrong result.  If two threads interact with the same data at the same time, this is known as a *race condition.*  The best way to avoid race conditions is to avoid global data.

###When is it ok to use global data?

For Tracers, as long as they are declared "static thread_local".  (NOTE: If you're going to be writing to a Tracer with any regularity -- i.e. greater than once per second -- you should always check to make sure that the Tracer is visible before sending output to it).

For singletons, as long as:
1. there is a single, private, static pointer to self and, besides mutexes, no other static data,

2. the class is bitwise const after it is initialized, or, like the ScoringManager, or the ChemicalManager manages singleton-like behavior for other classes, but those classes are bitwise const after their initialization.  (This is sadly not currently true of the ChemicalManager since we modify existing ResidueTypeSets after construction).

For mutexes.  Mutexes are meant for controlling access to global data like singletons and so all interactions with mutexes will be threadsafe.

###When should I use the keyword "static"?

For data, only when declaring tracers, singletons, or mutexes; nothing else is acceptable.  Do not declare static data as part of a function.  Do not implement singletons by putting a static instance pointer inside of a function.  Instead, singletons should derive from class utility::SingletonBase.  More on singletons below.

There are rare instances where you might want to declare something "static thread_local," but don't assume that the solution to your problem is to do that.  Talk to me before you seek out that solution.

Static functions are different from static data, and are almost always fine.  Static functions have the ability to interact with static data of a class, but as long as there is no static data in a class, then there is no danger.  You might worry that data declared at function scope inside of a static function might represent global data; it isn't. A  piece of data declared inside of a static function is not static data.  E.g.
```
 class MyClass {
    static void some_static_function() {
       int myint = 0; /*perfectly safe*/
       ...
    }
 };
```
the integer ''myint'' may live inside of a static function, but it is not itself a static variable: each invocation of some_static_function will allocate a separate instance of myint.

###What are Singletons and how should they be declared?

[[Singletons]] are classes where there should only be one instance per program.  They are accessed through a static function, "get_instance", that returns access to the single instance.  The singleton design pattern solves a number of common problems when dealing with global data -- in particular, the "static initialization order fiasco," and the need to ensure that global data is initialized only once -- and so they are frequently used.

Singletons are usually implemented with the following four features:
* private static pointer to the class, often named "instance_"
* public static get_instance() function that returns the instance_ pointer after the instance has been constructed
* private default constructor (no one but the class itself is allowed to construct an instance of the class)
* private and unimplemented copy constructor and assignment operators (no one, not even the class itself, should copy the class)

Besides the instance pointer, no other data in the singleton class should be static.

Singletons in Rosetta should derive from class utility::SingletonBase using the "CRTP" design pattern.  That is, class X should be declared:
```
 class X : public utility::SingletonBase< X >
 {
   ...
 };
```
so that it derives from a class which is templated on itself.  The base class will declare the get_instance() function and the instance_ data member. 

Class X must define a private static function
```
 static
 X *
 create_singleton_instance();
```
that takes no parameters and returns a pointer to an X.  This will be invoked by the SingletonBase's get_instance() function; the base class's function ensures that the class is constructed in a threadsafe manner.
In order for the base class to invoke this function, it must be declared as a friend of the derived class.
```
 class X : public utility::SingletonBase< X > {
 public:
    friend class utility::SingletonBase< X >;
 private:
    static X * create_singleton_instance();
 };
```

The SingletonBase class declares the copy constructor and assignment operator as deleted, so they should automatically be removed from your derived singleton class. 
(You'll get an error if you try to define the assignment operator, and if you define the copy constructor properly. You might be able to improperly define a copy constructor, but DON'T.)

###Can I change or reset a Singleton after it's constructed, e.g. after one job completes and before the next one starts or in response to some event that occurs as a job is running?

No. That would prevent two jobs from interacting with the Singleton at the same time.  If one job were to reset the Singleton while a second job was trying to use its data, then the second job would crash.

###What if I have a problem and the only way around it is global data?

Talk to me (Andrew Leaver-Fay) first.  There's almost surely a way around it.

###What if there's big expensive-to-load or expensive-to-store data that I need to load in for each job but more than one job can take advantage of that data, e.g. Fragments?

Then you could use the [[ResourceManager]] to manage the creation of that data.  NOTE: the ResourceManager won't let you change the data after it's created because if two jobs in two threads are trying to use that data, they will quite likely want to change that data in different ways, or they might try to change it at the same time and corrupt it in doing so.  If you need to change data during the course of execution, you will need each Job to load that data in.

If you're using [[RosettaScripts]], and you want to load in per-job non-const data, you can add new "DataLoaders" to load that data into the DataMap.  E.g. the ScoreFunctionLoader loads ScoreFunction objects into the DataMap.


##See Also

* [[Coding Conventions]]: More information on best practices for coding in Rosetta
* [[Singletons]]: Guidelines for using singleton classes in Rosetta
* [[Common Errors]]: Commonly encountered errors for Rosetta developers