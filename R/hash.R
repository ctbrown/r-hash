#' hash/associative array/dictionary data structure for the R language
#' 
#' Functions for creating and working with hash objects: 
#' 
#' `hash` Class constructor 
#' 
#' `is.hash` test if object is of class "hash"
#' 
#' `as.list`
#' 
#' `as.list.hash` convert a hash object to a list
#' 
#' @param x a hash object.
#' 
#' @param all.names a logical indicating whether to copy all values or
#' (default) only those whose names do not begin with a dot
#' 
#' @param ...  Additional arguments passed to the function
#' #' HASH KEYS must be a valid character value and may not be the empty string
#' `""`.
#'  
#' 
#' @details
#' 
#' *KEYS* must be a valid R name, must be a character vector and must not 
#' be the empty string, `""`. When supplied by the used methods will try to 
#' coerce the keys to valid names using [make_keys()]
#' 
#' *VALUES* are restricted to any valid R objects.
#' HASH VALUES can be any R value, vector or object.
#' 
#' \emph{code{hash}}  returns a hash object.  Key-value pairs may be specified 
#' as: \cr
#' * explicitly named arguments `keys` and `values` \cr
#' * two unnamed objects of equal length as a set of key-value pairs \cr
#' * key=value pairs \cr
#' * a single naned vector \cr
#' * as a list \cr
#' 
# See \code{\link{.set}} for further details and how key-value vectors of
# unequal length are interpretted.
# 
#' *ACCESSORS.* Hashes may be accessed via the standard R accessors `[`, `[[` and
#' `\$`.  See [hash::extract()] for details.
#' 
#' *PASS-BY REFERENCE.* Environments and hashes are special objects in R because
#' only one copy exists globally. When provided as an argument to a function, no
#' local copy is made. When passes to functions, those functions can change the
#' value of the hash. This is not typical of R.
#' 
#' *PERFORMANCE.*  Hashes are based on R's native environments and are designed
#' to be exceedingly fast using the environments internal hash table.  For
#' small data structures, a list will out-perform a hash in nearly every case.
#' For larger data structure, i.e. > 500 key value pair the performance of the
#' hash becomes faster.  Much beyond that the performance of the hash far
#' outperforms native lists.
#' 
#' 
#' @return 
#'    `hash` hash object
#'    
#'    `is.hash` logical value indicating if the argument is a hash.
#'    
#'    `as.list` list conversion from hash
#'    
#'    `length` integer; number of key-value pairs in the hash
#' 
#' @author Christopher Brown
#' 
#' @seealso 
#'   [extract()]
#' 
#' @examples
#' 
#'   hash()                            # empty 
#'   h <- hash()                       # associate a name to the hash 
#' 
#'   hash( new.env() )                 # from environment 
#'      
#'   hash( a=1, b=2, c=3 )             # key-value pairs using named arguments   
#'   
#'   hash( letters[1:3], 1:3 )         # unamed args: two equal length vectors 
#'   hash( letters[1:3], 1 )           # unamed args: all keys with same value
#'                                     
#'   hash( 1:3, lapply(1:3, seq, 1 ))  # same, arbitrary values
#'   
#'   hash( c(a=1, b=2, c=3) )          # named vector of key-value pairs
#'   hash( list(a=1,b=2,c=3) )         # named list of key-value pairs
#'  
#'   is.hash( hash() )
#'   as.list(h)   # CONVERT TO LIST
#' 
#' @rdname hash
#' @aliases hash 
#' @importFrom methods new
#' @export hash

hash <- function( ... ) {

  li <- list(...)  

  if( length(li) == 1 && is.environment( li[[1]] ) ) { 
    h <- new( "hash", parent=emptyenv() )
    h@.xData <- li[[1]]
    
  } else if( length(li) == 1 && is.list( li[[1]] ) ) {
    h <- hash( as.environment(li[[1]]) )
    
  } else {    
    h <- new( 
      "hash" , 
       new.env( hash = TRUE , parent=emptyenv() )  
    )
  
    if ( length(li) >  0  ) { 
      if( length(li) > 0 ) .set( h, ... )
    }
  }

  h

}
	

# ---------------------------------------------------------------------
# MISC. FUNCTIONS
# ---------------------------------------------------------------------

#' @aliases is.hash
#' @rdname  hash
#' @importFrom methods is
#' @export is.hash

is.hash <- function(x) is( x, "hash" )


#' @aliases as.list.hash
#' @rdname hash
#' @export 

as.list.hash <- function(x, all.names=FALSE, ...) 
  as.list( x@.Data, all.names, ... )
