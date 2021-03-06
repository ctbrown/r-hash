# 2019-01-04 Version 3.3.0

 * Converted documentation to MD via `roxygen2md()`
 
 * Added additional tests
 
 * `values()` now uses `mget`.  Thanks to @MRohani for leading to this find. 

 * `make.keys()` -> `make_keys()`; `make.keys()` will be deprecated in the future.
   
 * `has.key()` -> `has_key()`; `has.key()` will be deprecated in the future.

 * Added `head()` and `tail()` methods. 
 
 * Added `as.data.frame.hash()` method.

# 2017-03-01 Vesion 3.2.0 

 * added `kv` function to iterate by key and value
 
 * `values` always returns a named list. Use `unlist` to simplify 
   (#13: Florent Angly)
 
 * hash operation no longer sorts by key, providing an speed-up especially for 
   large hashes (#15: Florent Angly)
  
 * `names` has been removed. Now calling names uses `base::names` by default, 
   `keys` should be mostly used instead. It is faster and more flexible.
  
 * Hash key misses with `[` returns `NULL` if not found. (#1: Rohani)
 
 * `values` now will always return a list. Use `unlist` to create a vector. 

# 2014-11-20 Version 3.0.2 

* improve and expand tests especially of all `hash` constructor methods
* improve examples in hash.R


# 2014-11-20 Version 3.0.1 

* Move to new testthat standard
* Fix imports of utils and method packages
* Documentation fixes

# 2014-02-01 Version 3.0.0

## Incompatibe Changes breaking some backward compatability:

* `h[]` returns a copy of h
* .set is nolonger supported.  Standard R accessors should be used.

## New features 

* New ways to edit key names:
**  `setkeys` allows setting of key names similar to data.table's `setnames`
** `keys<-` for setting simple keys 

* `names` works same as `keys`


## Organizational Changes

* Fully converted to roxygen2 documentation
* Better organized files
* much improved documetation.


# OlDER CHANGES 


2013-02-20 Version 2.2.6
  - Fixes bug with '[' assessor which was broken.  Thanks to Jeremy Rassen.
  - Adds some test for accessors using testthat

2013-01-31 Version 2.2.5 
Fixes bug with has.key.  Because of the default settingg of inherits=TRUE in 
the exists function, the has.key function was revealing keys for objects
found on inherited environments, this included functions such as 'c' and 'q'. 
Thanks to Michael Pratt for spotting the bug.

2012-04-25 Version 2.2.0
  Recaptured orphaned package
  - R/zzz.R: uses utlis::packageVersion(pkgname, libname)
  - R/DESCRIPTION: Dependency to R-2.12.0+

2011-03-17 Version 2.1.0
  Changed contact information.

2010-09-26 Version 2.0.2 (cbrown) 
  Just releasing as version 2.0.2.  Mostly, documentation and benchmarks added.
  Unreleased to CRAN.

2010-07-25 
  - demo/hash-benchmarks.R has been expanded.

2010-06-14
  - man/hash-package.Rd
  - man/hash-class.Rd: Ammended notes section specifically being more
    clear about the PASS-BY-REFERENCE BEHAVIOR of HASHES

2010-05-26 Version 2.0.1 (cbrown)
  - At the request of Michael Hahsler, removed the ODG ASCII ART logo in the 
    .OnLoad method. It will comeback as soon as I can figure out how to disable
    it through the appropriate option.

  Hi Christopher,

   thank you for providing the package hash. I am thinking of using
   it in my rEMM package. Is there a way to make the load message a
   little less flashy. I include hash in my DESCRIPTION file and the
   ASCII art comes always up when my package loads.

   Thanks,
   Michael

   --      Dr. Michael Hahsler, Visiting Assistant Professor
    Department of Computer Science and Engineering
    Lyle School of Engineering
    Southern Methodist University, Dallas, Texas

2010-04-24 Version 2.0.0 (cbrown)

 - The coercion of keys make.keys has largely been deprecated.  This might change
   in future version, but what we really want is to have any object stand for the
   keys that will get automatically converted.  This might be make.key in the 
   future.  Also, we removed .get.  All the accessor coding now exists in the 
   definition of the native accessors.

 - R/format : implement max.print to display only getOption('max.print') keys.
   
 - R/na.actions : 
   na.*.hash function's have been renamed to hash.na.function.  This is so as not to
   conflict with the base::na.* S3 functions.  It is unfortunate, because it would 
   have been nice to retain a name.  It was impossible because of the generic form 
   of the functions, na.fail which requires an object as the first argument.  Meanwhile,
   the 'ifnotfound' argument of mget takes one argument.  mget is extensively used
   in this package and the one argument that needs to be passed is the name of the
   key.  The choice was to either re-write the standardGeneric which will cause 
   downstream problems -OR- abandone the na.* names.  The latter was chosen with 
   the added benefit that other hash controlled options would be grouped by hash.* 
   in the option vector.

 - R/Class-hash:
   - [[, [[<-: DEPRECATED
     + methods deprecated because new objects can inherit from environments.
   - $ : DEPRECATED
     + methods deprecated because new objects can inherit from environments
     + NB. $<- is still retained so that ha$a <- NULL will remove 'a' from ha.
   - [: 
     + No longer relise on .set, creates new hash directly

 - R/hash-benchmark.R
   + Uses rbenchmark to check various perfomance metrics

 - DESCRIPTION: 
   + Suggests: rbenchmark (>= 0.3) 

 - R/get-R: .get DEPRECATED for perfomance reasons. 

 - R/values.R: 
   + values() 
     - redefined as function(x, keys=NULL, ... ) 
     - no longer uses .get

 - R/hash-action.R : DEPRECATED
   After renaming these, it was decided that these would be DEPRECATED. 
   Sometimes consitency is better than customizabilty.
   replaces R/na.action with the following funcitons renamed:
   + hash.na.fail => hash.fail
   + hash.na.warn => hash.warn
   + hash.na.default => hash.default
   



2010-03-15 
  - Passes Checks on R 2.9.2, 2.10.1. 2.11.0 (devel)
  - Warning on CHECK:
      Defining type "environment" as a superclass via class ".environment"
  
Some R data types do not behave normally, in the sense that they are non-local references
or other objects that are not duplicated. Examples include those corresponding to classes
"environment", "externalptr", and "name". These can not be the types for objects with 
user-defined classes (either S4 or S3) because setting an attribute overwrites the object
in all contexts. It is possible to define a class that inherits from such types, through 
an indirect mechanism that stores the inherited object in a reserved slot. The 
implementation tries to make such classes behave as if the object had a data part of the
corresponding object type. Methods defined with the object type in the signature should 
work as should core code that coerces an object to the type in an internal or primitive
calculation. There is no guarantee, however, because C-level code may switch directly on 
the object type, which in this case will be "S4". The cautious mechanism is to use 
as(x, "environment") or something similar before doing the low-level computation. See
the example for class "stampedEnv" below. 

 - R/Class-hash.R: Added if( getRversion ) to accomodate older and newer versions of R.
  - man/hash-accessors.Rd: added alias for $-hash,NULL-method.


2010-02-16 Version 1.99.3 (cbrown)
  - Fixed several typos
  - R/Class-hash.R 
    + [[ now allows for na.action and works correctly
    + $ now calls [[ rather than get

2010-02-16 Version 1.99.1 (cbrown)
  - Fixed S4 Documentation Bugs throughtout
  - R/Class-hash.R : sped up $ and [[ with 'try' was previously using keys which is 
    very slow by comparison.
  - R/values.R : fixed definition to values<-

2010-02-16 Version 1.99.0 (cbrown)
  RELEASE CANDIDATE FOR VERSION 2.00
  THIS VERSION BREAKS BACKWARD COMPATABILITY WHEN TRYING TO ACCESS A 
  NON-EXISTANT KEY.  PACKAGE NOW RETURNS NA BY DEFAULT, BUT BAHAVIOUR IS
  CONTROLABLE BY Options('na.default.hash')
  
  - R/Class-hash.R: fixed $ accessor to remove 'name' 
  - R/get: 
    - Added ability to control the default action when non-existant
        keys are requested.  Thanks Matthias Buch-Kromann.
    - Deault for non-existant keys is NA.
    - Added customizable behavior for accessing non-existing keys 
  - man/hash-pacakge.Rd: Added note comparing hash implementation to 
    native environments

2010-02-15 Version 1.10.3 (cbrown)
  - R/keys.R: added all.names = T to show even hidden names.
  - R/values.R: 
      + Added keys argument to 'values' and 'values<'- methods. 
      + 'values' Passes ... argument to .get method
    Thanks Matthias Buch-Kromann.

2010-01-01 Version 1.10.2 (cbrown)
  - R/Class-hash.R
    + Added methods signature [-hash,missing,... to return the case when 
      no indexes are provided to the hash slice method.
  - R/get.R
    + get.R will not return a simplified version from sapply call. When the
      hash had values with all the same elements, a matrix was returned and
      this interferred with the hash slices, [.  I am not sure the behavior 
      was even useful.
  - R/values.R
    + Added replacement method for values
  - R/zzz.R
    + Make it so that the odg.logo is displayed only once per session.

2009-12-09 Version 1.10.1 (cbrown)
  - R/Class-hash.R
    + Removed 'name' from signature for methods: $, $<-

2009-11-29 Version 1.10.0 (cbrown)
  - R/set.R
    + Fixed problem pointed out by Denise Maudlin from blog.opendatagroup.com
        key <- 'one'
        ikey <- 'two'
        val <- 'three'
        info <- hash()
        info[key] <- hash( keys=c(ikey), values=c(val) )
        Error in get(make.keys(i), x@.Data) : object ‘1′ not found
      Solution is to check if only one key is provided than the values are
      are the value vector. 
  - tests/set.r
    + Added test for adding hashes as values.
  - Class-hash.R
    + [[-method: verifies if argument is a previously assigned key. If not, 
      method returns NULL with a warning. 
      NULL with a warning.
    + $-method:  verifies if argument is a previously assigned key. If not, 
      method returns NULL with a warning. 

2009-11-11 (cbrown)
  - R/zzz.R 
    + Fixed logo
  - R/invert.R
    + Made better generic for use with formula tools 

2009-11-04 Version 1.0.3 (cbrown)
  + Fixed dependency of R-2.9.0

2009-10-14 (cbrown)
  + show.R
    - Handled cases where values are not supported by "format".  These are collapsed as character

2009-10-11 (cbrown) Version 1.0.2
  + revert previous change allowing [[(hash) to accept multiple keys


2009-10-09 (cbrown) Version 1.0.1  ( not released on CRAN )
  + [[(hash) 
    support for multiple supplied keys also passes ... to simplify
  + now properly inherits from environment
  + requires R>=2.9.0

2009-09-30 (cbrown)
  + validate.key rename make.keys
    - This is more R-ish and more like the make.names function.

2009-09-28 (cbrown)
  + R/hash.R: 
    - Fixed format of hash accessors.  Now hashes can contain hashes.
    - Deprecated use of [[ with multipe keys.

  + R/show.R: Now aliases format 
  + R/format.R: added
  + R/zzz.R: added graphical Open Data Logo
  + R/print.R: added


2009-09-04 (cbrown)
  - R/zzz.R: added Open Data message

2009-09-04 Version 0.40 (cbrown)
  - R/get.R: Added drop to reduce to lowest dimension by default.
  + R/invert.R: 
    + invert method added.
	+ inverted.hash function added.
	

