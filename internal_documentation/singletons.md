10/6/2014

Singleton class X must now do the following:
1) using CRTP, derive publicly from <code> utility::SingletonBase< X > </code>

2) define a private, <code> static function X * create_singleton_instance(); </code>

3) declare <code> class utility::SingletonBase< X > </code> to be a friend so that it
    (and no one else) can call create_singleton_instance()

4) include the following code block to define two static variables in X.cc:
    

    namespace utility {
    
    using my::namespace::X;
    
    #if defined MULTI_THREADED && defined CXX11
    template <> std::mutex utility::SingletonBase< X > ::singleton_mutex_;
    template <> std::atomic< X * > utility::SingletonBase< X >::instance_( 0 );
    #else
    template <> X * utility::SingletonBase< X >::instance_( 0 );
    #endif
    
    }
    

The SingletonBase class defines the <code> static X * get_instance() </code> function and handles
the instantiation of the instance in a thread-safe manner. The instance_ pointer
belongs to the base class.
    
Singletons, with certain explicit exceptions (the JobDistributor, the ResourceManager)
should not hold job-specific data.
