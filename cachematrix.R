## This file containts two functions. The first is "makeCacheMatrix" which allows one to
## save a matrix to a function's environment. This function then uses the <<- operator to
## save the input matrix and it's inverse to the function's environment. The function then
## returns a list of the sub-functions so that they can be used to access the funtion's data.
## 
## The second function "cacheSolve" accepts an argument of type "makeCacheMatrix" and returns that
## arguments managed inverse matrix. If the matrix inverse has already been computed, "cacheSolve"
## simply returns the iverse. If the inverse is null, then the inverse is computed and returned by
## "cacheSolve". In addtion to returning the inverse, if the inverse is computed, the computed inverse
## is saved into the input argument's function environment for subsequent use.

#By defaulting x, the object instantiation of "makeCacheMatrix" will return a valid object.
#This function acts as an object which holds the state of a matrix of interest. Once
#this "function object" is instantiated, the function is available in the parent environment, which
#is the environment in which it was instantiated. This function is connected to cacheSolve in the
#sense that an object of type "makeCacheMatrix" is passed to "cacheSolve" which then updates
#its input parameter to hold the inverse of the parameter, which is a square matrix.
#
#It is assumed that the input parameter is a square matrix with inverse. No validation is made on the input.
makeCacheMatrix <- function(x = matrix()) {
  
  inverseMatrix <- NULL #There is no inverse matrix when initially instantiating this object.
  
  #The set function has the same effect as instantiating the object originally.
  set <- function(y){
    x <<- y #Assigns y to x in the parent environment.
    inverseMatrix <<- NULL #When s
  }
  
  get <- function() x  #getter which provides access to the objects matrix.
  
  setinverse <- function(inverse_input) inverseMatrix <<- inverse_input #Saves inverse to parent environment.
  getinverse <- function() inverseMatrix  #Getter for the inverse matrix.
  
  #return sub-functions to the calling environment so that they can be used instead of using a[[]] operator.
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}

#The connection of this function to "makeCacheMatrix" is that you have to pass
#an object of type "makeCacheMatrix" to this function in order for it to work.
#Otherwise, the syntax x$getinverse() will not work. This function then computers the inverse of the 
#matrix managed by the input function. If that inverse is null, then this function computes the inverse,
#updates the input parameter with the inverse, and returns the inverse to the caller. If the inverse
#is not null, the inverse from the input parameter is returned to the caller. So in this case, the cached
#inverse is used in the sense that it is the return value of the function.
#
#It is assumed that the input parameter is of type "makeCacheMatrix".
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  
  #Get the inverse from the input "makeCacheMatrix" object x.
  inverse_x <- x$getinverse()
  
  #If the inverse has been computed already, no need to re-compute. Just return it.
  if (!is.null(inverse_x)){
    message("getting cached inverse")
    return(inverse_x)
  }
  
  sourceMatrix <- x$get() #Get the matrix in order to compute the inverse.
  
  #solve() computes the inverse of an input matrix.
  inverse_x <- solve(sourceMatrix)
  
  x$setinverse(inverse_x)  #Save the inverted matrix into the input object's environment.
  
  #Returns the inverse which can then be displayed to the console.
  inverse_x 
}
