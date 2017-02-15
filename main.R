# main.R
library('telegram')
bot <- TGBot$new(token = bot_token('RBot'))
bot$set_default_chat_id(user_id('me'))

load('history.Rdata')

result <- bot$getUpdates()
message.update_id <- result$update_id
message.new_id <- setdiff(message.update_id, history)
message.text <- result[message.update_id %in% message.new_id,][[2]][[5]]

result <- bot$getUpdates()
message.update_id <- result$update_id
message.new_id <- setdiff(message.update_id, history)
message.text <- result[message.update_id %in% message.new_id,][[2]][[5]]

sapply(message.text, function(text){
  vec <- strsplit(text, " ")[[1]]
  
  
  
  if (substring(vec[1], 1, 1) == '/'){
    bot$sendMessage(switch(substring(vec[1], 2),
                           feedadd = feedadd(vec[2], vec[3]),
                           feeddel = feeddel(vec[2]),
                           feedlist = feedlist(), 
                           feedfetch = feedfetch(vec[2]))) 
  }
})

history <- union(history, message.new_id)
save(history, file = 'history.Rdata')
