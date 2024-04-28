library("pxweb")

#avkommentera nedan.
#kör pxweb_interactiv och välj de val du vill ha men välj ja på print as json.

#pxweb_interactive("https://api.scb.se/OV0104/v1/doris/sv/ssd/START/TK/TK1001/TK1001A/PersBilarDrivMedel")

#i terminalen kommer koden nedan fram kopiera den och lägg i detta dokument.

#skapa en json fil och kopiera in allt mellan "######## STORE AS JSON FILE ########"
#ha inte med store as json eller #. 


#Ändra query path till din json fil sökväg. 
#kör sedan koden nedan.
# Download data 
px_data <- 
  pxweb_get(url = "https://api.scb.se/OV0104/v1/doris/sv/ssd/START/TK/TK1001/TK1001A/PersBilarDrivMedel",
            query = "C:\\Users\\david\\Documents\\skola\\githubs\\r_prog_ds23-main\\kunskapskontroll\\api.json")

# Convert to data.frame 
px_data_frame <- as.data.frame(px_data, column.name.type = "text", variable.value.type = "text")

# Get pxweb data comments 
px_data_comments <- pxweb_data_comments(px_data)
px_data_comments_df <- as.data.frame(px_data_comments)

# Cite the data as 
pxweb_cite(px_data)


#inspekterar datan.

px_data_frame
View(px_data_frame)
names(px_data_frame)
geom_point()

sapply(px_data_frame, class)
sum(is.na(px_data_frame))
px_data_frame[is.na(px_data_frame)] <- 0