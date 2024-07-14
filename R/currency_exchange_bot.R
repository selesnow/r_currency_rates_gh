library(httr)
library(jsonlite)
library(telegram.bot)

# Функция для получения курса валют
get_exchange_rate <- function(api_key, currency) {
  url <- paste0("https://api.exchangerate-api.com/v4/latest/USD?apikey=", api_key)
  response <- GET(url)
  data <- fromJSON(content(response, "text"))
  return(data$rates[[currency]])
}

# Функция для отправки сообщения в Telegram
send_telegram_message <- function(bot_token, chat_id, message) {
  bot <- Bot(token = bot_token)
  bot$sendMessage(chat_id = chat_id, text = message)
}

# Получение переменных среды
api_key   <- Sys.getenv("EXCHANGE_RATE_API_KEY")
bot_token <- Sys.getenv("TELEGRAM_BOT_TOKEN")
chat_id   <- Sys.getenv("TELEGRAM_CHAT_ID")
currency  <- "EGP"

# Получение курса валют и отправка сообщения
exchange_rate <- get_exchange_rate(api_key, currency)
message <- paste("Курс", currency, "к USD:", exchange_rate)
send_telegram_message(bot_token, chat_id, message)
