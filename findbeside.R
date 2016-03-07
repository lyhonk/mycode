findbeside <- function(dmr,tr,bn=1){
  # 寻找临近dmr的特征区域
  #
  # Args:
  #     dmr: a data.table include id, start, end
  #     tr: a data.table include id, start, end
  #     bn: integer, the number of regrion beside dmr
  # Returns:
  #     a data.table include start, end
  # Author:
  #     Jimmy Chen, E-mail: Jimmy_ccj@outlook.com
  
  if(class(dmr) != "data.table" || class(tr) != "data.table" ){
    stop("dmr and tr must be data.table")
  }
  dp <- dmr[,.(median=as.double(median(start:end))),by=id]$median
  tp <- tr[,.(median=as.double(median(start:end))),by=id]$median
  dis <- abs(outer(dp,tp,"-"))
  br <- data.table(dmr.id=numeric(),tr.id=numeric())
  for(i in 1:nrow(dis)){
    match.id <- which(dis[i,] %in% head(unique(sort(dis[i,])),bn))
    br <- data.table(dmr.id=c(br$dmr.id,rep(i,length(match.id))),tr.id=c(br$tr.id,match.id))
  }
  return(br)
}
