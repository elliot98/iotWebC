library(shiny)
library(readr)
feed = read_csv("feed.csv")
data = feed[,3:4]
clu = kmeans(data,4)
clu$cluster = factor(clu$cluster)

tab = table(clu$cluster)
fin = which(tab == max(tab))

avP = 0
avT = 0
clim = NULL

for(i in fin){
  get = data.frame(c(data),c(clu$cluster))
  spec = data.frame(which(get$c.clu.cluster.==i))
  for(j in spec){
    clim = rbind(get[j,])
  }
  
  avT = avT + mean(clim[,1])
  avP = avP + mean(clim[,2])
}

avT = avT/length(fin)
avP = avP/length(fin)

shinyServer(
  function(input,output){
    output$temp = renderText(avT)
    output$pres = renderText(avP)
    output$count = renderText(length(fin))
    output$max = renderText(max(tab))
    output$tag = renderText("<br><br><br><br><br><br><br><br><br><br>")
    
    output$cluPlot = renderImage({
      outfile = tempfile(fileext='.png')
      
      png(outfile, width=600, height=600)
      plot(data, col=clu$cluster, main="Cluster Data")
      dev.off()
      
      list(src = outfile,
           contentType = 'image/png',
           width = 600,
           height = 600,
           alt = "This is alternate text")
    }, deleteFile = TRUE)
    
    output$cluPlot2 = renderImage({
      outfile1 = tempfile(fileext='.png')
      
      png(outfile1, width=600, height=600)
      plot(clim[,2:1], main="Chosen Cluster(s)")
      dev.off()
      
      list(src = outfile1,
           contentType = 'image/png',
           width = 600,
           height = 600,
           alt = "This is alternate text")
    }, deleteFile = TRUE)
  }
)