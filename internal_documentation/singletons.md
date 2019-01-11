Singletons
==========

10/6/2014, updated 9/13/2016

Singleton class X must now do the following:
1) using CRTP, derive publicly from <code> utility::SingletonBase< X > </code>

2) define a private, <code> static function X * create_singleton_instance(); </code>

3) declare <code> class utility::SingletonBase< X > </code> to be a friend so that it
    (and no one else) can call create_singleton_instance()
  

The SingletonBase class defines the <code> static X * get_instance() </code> function and handles
the instantiation of the instance in a thread-safe manner. The instance_ pointer
belongs to the base class.
    
Singletons, with certain explicit exceptions (the JobDistributor, the ResourceManager)
should not hold job-specific data.
