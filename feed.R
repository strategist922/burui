# feed

load('feed.Rdata')

feedadd <- function(nick, url){
  feed[[nick]] <- url
  return('received')
}

feedlist <- function(){
  return(names(feed))
}

feeddel <- function(nick){
  if (nick %in% names(feed)){
    feed[[nick]] <- NULL
    return('deleted')
  }else{
    return('not found')
  }
}

feedfetch <- function(nick){
  return('not implemented')
}

save(feed, file = 'feed.Rdata')