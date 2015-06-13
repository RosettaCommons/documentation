# How to use pointers correctly

##How to correctly use owning and access pointers

The following guide summarizes how to correctly use [[owning pointers]] and [[access pointers]]. With the transition to the boost:: / std:: pointer classes, these rules must be followed to avoid compilation errors or run-time crashes (double free).

Note:

* OP = `utility::pointer::owning_ptr` AKA `std::shared_ptr` or `boost::shared_ptr`
* AP = `utility::pointer::access_ptr` AKA `std::weak_ptr` or `boost::weak_ptr`

The pointer type is selectable at compilation-time. Boost pointers are the default (because they won't require a C++11 capable compiler); to compile with std:: pointers instead, build with extras=cxx11.
  
**Rules:**

* Never put `this` into an OP  
Only whatever instantiates the object can put that object into an OP.

* Never put a naked (raw) pointer received from somewhere into an OP  
Naked pointers can be used and passed around to refer to an object, but never be put back into OP or APs. Use with care, there is no guarantee that a naked pointer will remain valid.

* Never put a reference into an OP  
You can make a reference from an OP and pass it around, but you must be careful to ensure that the OP remains alive. References can never be put into OPs or APs. This will cause double-free corruption. Many objects such as Pose, Movers, ResidueType, provide the `get_self_ptr()` and `get_self_weak_ptr()` methods that can be called on a reference (or even a raw pointer) to obtain a proper OP or AP.  
  
    `get_self_ptr()` and `get_self_weak_ptr()` caveats:  
    * These methods are only valid if the object is associated with an OP and not declared on the stack, i.e. `Pose pose;` vs. `PoseOP pose( new Pose );`.

    * These methods cannot be used in the object's own constructor and destructor, because at this point in time they are not yet or no longer valid.

    * Calling these methods before the self-pointer is initialized will cause a bad_weak_ptr exception.

* Do not use `dynamic_cast<Some *>` and put the result into OPs  
dynamic_cast takes the address of the object and puts it back into an OP. Therefore use this instead to perform dynamic casts on OPs: `SomeOP x = utility::pointer::dynamic_pointer_cast<Some>(y);`
 
* If you need a non-owning pointer but aren't sure if a pointer will remain valid, do not use naked pointers (or references) but use weak_ptrs instead. You can check if the pointer is still valid or has expired (object being pointed to has been destroyed) using `ap.expired()`, or call `ap.lock()` to lock the AP and obtain an OP. Check the result of that lock call; if the pointer expired, you will get a NULL OP.  
Use of naked pointers is OK when needed, but one needs to be careful. Thus, preferably use OPs and APs.

**Disallowed usage:**

* Creating an OP from `this`, i.e. `SomeOP someop( this )`  
Never do this as it will cause double-free crashes. Each object address (i.e. resulting from instantiation with `new`) can be placed into an OP exactly once. Putting the same naked pointer into a second OP will result in a double-freeing of the object and hence a segmentation fault.  
Suggested use: `SomeOP someop( new Some( ... ) )`
   
* Assigning a naked pointer to an OP:  
`Some o = new Some;`  
`SomeOP op1 = new Some;`  
`SomeOP op2 = o;`  
These statements will not compile. Such implicit casts are explicitly disallowed so the developers have to explicitly indicate that they want the OP to manage the lifetime of the provided naked pointer. Do this, and only once, for a given instance:
`SomeOP op( new Some );`

* Passing or assigning this to an AP:  
`SomeCAP somecap( this );`  
`foo(SomeCAP x) {}; foo( this );`  
Will not compile. An AP can only be created from an OP.
   
* Dereferencing an AP directly:  
`some_ap_->foo()`  
`some_ap_->var`  
Will not compile. One must lock() the AP first:  
`some_ap_.lock()->foo()`  
`some_ap_.lock()->var`  
Note: When locking fails, the above will result in a null pointer dereference and seg fault. If unsure if locking will succeed, assign to an OP first:  
```
SomeOP some_op = some_ap_.lock();
if(some_op) {
  some_op->foo();
}
```  
An AP can be checked for validity with some_ap_.expired(), however, there is no guarantee that an AP will not expire between checking and locking. Use lock() and check the result instead if an AP is expected to be not always valid.  
If an AP should always be valid, one can create an OP from AP directly: `SomeOP some_op( some_ap_ );`. This throws a bad_weak_ptr exception if the AP expired, which helps with troubleshooting and can be caught.  
Using lock() without checking the result is fast but dangerous, i.e.: `some_ap_.lock()->foo();`
   
* Comparing an AP with an AP, OP, naked pointer or this:  
`if( some_ap == this )`  
`if( some_ap == some_other_ap )`  
`if( some_ap == some_op)`  
`if( some_ap == &some_ref )`  
Not allowed, will not compile. Use equal() helper template instead:  
`utility::pointer::equal( some_ap, this )`  
`utility::pointer::equal( some_ap, some_other_ap )`  
`utility::pointer::equal( some_ap, some_op )`  
`utility::pointer::equal( some_ap, &ref )`  
See also: http://stackoverflow.com/questions/12301916/equality-compare-stdweak-ptr

* Creating a set of AP: `typedef std::set< SomeCAP > SomeSet;`
Will not compile. Because a set is ordered but weak_ptr cannot be compared, we need to provide a comparator in C++11: `typedef std::set< SomeCAP, std::owner_less< SomeCAP > > SomeSet;`

* Create an OP from a reference: `SomeOP someop( &someref );`
This will cause double-free crashes. Never create an OP from a reference.  Just don't. This is totally illegal but will compile ... and crash:  
`SomeOP op( new Some );`  
`Some &op_ref = *op;`  
`SomeOP op2( &op_ref );`  
These are OK:  
`SomeOP op( new Some );`  
`SomeAP ap( op );`  
`SomeOP op2( op );`  
`SomeOP op3( ap );`  
`SomeAP ap2( ap );`  

Questions, Suggestions? Email Luki: lugo@uw.edu

##Should I use owning pointers or a reference (&) in my class/function?

This is a set of guidelines for choosing between Owning Pointer (OP) and 'const &' coding style for class data members and function arguments.

-   Use OPs when objects are passed into a different object which will retain partial ownership.
-   Use references (&) where objects are passed and are going to be modified
-   Use const references (const &) where objects are passed and are not going to be modified

To decide which data type is appropriate for your function/class, consider the following questions:

    1.  Will an instance of your class own this data? i.e: is the data life span exactly the same as that of a class instance? In this case, you probably do not need to use an OP.
    2.  Is your class holding "someone else's data", i.e. 'referencing' it? If this is the case, then you should probably use an OP.

##See Also

* [[Coding conventions]]
* [[Development tutorials home page|devel-tutorials]]
* [[Development Documentation]]: The development documentation home page
* [[Owning pointers]]
* [[Access pointers]]
* [[ReferenceCount]]: Formerly used for owning and access pointers (now deprecated)
* [[Writing an app]]