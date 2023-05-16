#from https://usethis.r-lib.org/articles/git-credentials.html
#
#This script will allow RStudio and GitHub to talk to one another
#using HTTPS personal access tokens (PATs)

install.packages("usethis")

library(usethis)

usethis::create_github_token()

# Assuming you’re signed into GitHub, create_github_token() takes you to a pre-filled form to create a new PAT.
# It is a very good idea to describe the token’s purpose in the Note field, because one day you might have multiple PATs
#Once you’re happy with the token’s Note, Expiration, and Scopes, click “Generate token”.
#Copy the PAT to the clipboard, anticipating what we’ll do next: trigger a prompt that lets us store the PAT in the Git credential store.
#Run this:

gitcreds::gitcreds_set()

#Paste in PAT, hit enter

#If you already have a stored credential, gitcreds::gitcreds_set() reveals this and will even let you inspect it.
#When the PAT expires, return to https://github.com/settings/tokens and click on its Note. (You do label your tokens nicely by use case, right? Right?) 
#At this point, you can optionally adjust scopes and then click “Regenerate token”.
