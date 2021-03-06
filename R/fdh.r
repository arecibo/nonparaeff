fdh <- function(base = NULL, frontier = NULL,
                 noutput = 1, orientation=1) {

  if(is.null(frontier))
    frontier <- base

  if(!is.null(base) & !is.null(frontier)){
    base <- as.matrix(base)
    frontier <- as.matrix(frontier)
  }

  if(ncol(base) != ncol(frontier))
    stop("Number of columns in base matrix and frontier matrix should be the same!")

  s <- noutput
  m <- ncol(base) - s
  n <- nrow(base)
  nf <- nrow(frontier)

  front.Y <- t(frontier[, 1:s])
  front.X <- t(frontier[, (s+1):(s+m)])
  base.Y <- t(base[, 1:s])
  base.X <- t(base[, (s+1):(s+m)])
  
  re <- data.frame(matrix(0, nrow = n, ncol = 1))
  names(re) <- c("eff")
  
  for(i in 1:n){
    if(orientation == 1){
      x0 <- base.X[,i]
      y0 <- base.Y[,i]
      front.idx.x <- apply(front.X <= x0, 2, prod) == 1
      front.idx.y <- apply(front.Y >= y0, 2, prod) == 1
      front.idx <- which(front.idx.x * front.idx.y == 1)
      mat <- matrix(front.X[,front.idx]/x0, nrow = m, ncol = length(front.idx))
      eff <- min(apply(mat, 2, max))
    }
    if(orientation == 2){
      x0 <- base.X[,i]
      y0 <- base.Y[,i]
      front.idx.x <- apply(front.X <= x0, 2, prod) == 1
      front.idx.y <- apply(front.Y >= y0, 2, prod) == 1
      front.idx <- which(front.idx.x * front.idx.y == 1)
      mat <- matrix(front.Y[,front.idx]/y0, nrow = m, ncol = length(front.idx))
      eff <- max(apply(mat, 2, min))
    }
    re[i,1] <- eff
  }

  return(re)
}
                 

