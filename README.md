# GettingStarted
Go here first to setup GitHub and RStudio and get them talking - Credit: M. Pinsky ds4eeb course materials, 2026.
## 1. Set up RStudio to communicate with GitHub

### 1.1 Install packages
We're going to use a "package" called `usethis` to make it easy for RStudio and GitHub to work together. In R, a package bundles together reusable code to accomplish a particular purpose, along with data and documentation, and is easy to share with others. Packages are part of what makes R so powerful because anyone can improve or add to existing base R capabilities.

The traditional place to download packages is from CRAN, the Comprehensive R Archive Network, which is the same place you downloaded R. As Julie Lowndes has said, CRAN is like a grocery store or iTunes for vetted R packages.

Open RStudio on your computer and type this in the console:  
```
install.packages("usethis")
```

You should see R respond by saying it is trying and then downloaded the package. Now that you have the package, you shouldn't need to download this package again. 

Now you need to activate (or "attached") the package to your current session in R. You'll need to do this each time you want to use the package in a new R session. Type this in the console:  
```
library("usethis")
```

When `usethis` is successfully attached, you won’t get any feedback in the Console. So unless you get an error, this worked for you.

Now let’s do the same with the `here` package, which makes it easy to work with file paths in RStudio projects:
```
install.packages("here")
library("here")
```

`here` is a “chatty” package and, when attached, responds with the filepath we are working from.

### 1.2 Configure Git in RStudio
This next set up step is a one-time thing! You will only have to do this once per computer.

You will need to know your GitHub username, the email address you created your GitHub account with, and your GitHub password.

We will be using the use_git_config() function from the usethis package we just installed. Since we already installed and attached this package, type the following into your Console, but replace USERNAME with your GitHub username, and replace EMAIL with the same email you used to create your GitHub account:

```
use_git_config(user.name = "USERNAME", user.email = "EMAIL")
```

If you see `Error in use_git_config() : could not find function "use_git_config"`, please run `library("usethis")`

You can check that things worked and diagnose problems by typing this in the console:
```
# check by running a git situation-report: 
#   - your user.name and user.email should appear in global Git config 
git_sitrep()
```

### 1.3 Get a personal access token (PAT)
Personal access tokens are an alternative to using passwords for authentication to GitHub, and they make working with GitHub through RStudio much easier. I recommend creating one for this class, though you could use an existing one if you have it. The instructionsn below are modified from [this longer guide](https://usethis.r-lib.org/articles/git-credentials.html) from the creators of the usethis package. 

Type:
```
usethis::create_github_token()
```

As a small note, see how we referenced the `usethis` package with two colons `::` before calling the `create_github_token()` function? That's a way to be very specific to R about which package to look in for the function. It's not usually necessary if you have the package loaded.

Assuming you’re signed into GitHub (you should be), `create_github_token()` takes you to a pre-filled form to create a new PAT. You can get to the same page in the browser by clicking on “Generate new token” from https://github.com/settings/tokens. The advantage of create_github_token() is that the creators of the usethis package have pre-selected some recommended scopes, which you can look over and adjust before clicking “Generate token”.

It is a very good idea to describe the token’s purpose in the Note field, because one day you might have multiple PATs. We recommend naming each token after its use case, such as the computer or project you are using it for, e.g. “2026 ds4eeb personal laptop”. In the future, you will find yourself staring at this list of tokens, because inevitably you’ll need to re-generate or delete one of them. Make it easy to figure out which token you need to fiddle with.

GitHub encourages the use of perishable tokens, with a default Expiration period of 30 days. Unless you have a specific reason to fight this, I recommend accepting this default. I assume that GitHub’s security folks have good reasons for their recommendation. But, of course, you can adjust the Expiration behaviour as you see fit (perhaps the end of this course).

Once you’re happy with the token’s Note, Expiration, and Scopes, click “Generate token”.

You won’t be able to see this token again, so don’t close or navigate away from this browser window until you store the PAT locally. Copy the PAT to the clipboard, anticipating what we’ll do next: trigger a prompt that lets us store the PAT in the Git credential store.

Sidebar about storing your PAT: If you use a password management app, such as 1Password or Bitwarden (highly recommended!), you might want to add this PAT (and its Note) to the entry for GitHub. Storing your PAT in the Git credential store is a semi-persistent convenience, sort of like a browser cache or “remember me” on a website, but it’s quite possible you will need to re-enter your PAT in the future. You could decide to embrace the impermanence of your PAT and, if it is somehow removed from the store, you’ll just re-generate a new PAT and re-enter it. If you accept the default 30-day expiration period, this is a workflow you’ll be using often anyway. But if you create long-lasting tokens or want to play around with the functions for setting or clearing your Git credentials, it can be handy to have your own record of your PAT in a secure place, like 1Password or Bitwarden.

### 1.4 Put your PAT into the local Git credential store
We assume you’ve created a PAT and have it available on your clipboard.

How to insert your PAT in the Git credential store? Type this in the RStudio console:
```
gitcreds::gitcreds_set()
```

You already have the `gitcreds` package installed, because it came with `usethis`.

If you don’t have a PAT stored already, it will prompt you to enter your PAT. Paste!

```
? Enter password or token: ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
-> Adding new credentials...
-> Removing credentials from cache...
-> Done.
```

If you already have a stored credential, `gitcreds::gitcreds_set()` reveals this and will even let you inspect it. This helps you decide whether to keep the existing credential or replace it. When in doubt, embrace a new, known-to-be-good credential over an old one, of uncertain origins.

If you have worked with GitHub before and previously made your GitHub PAT available by setting the `GITHUB_PAT` environment variable in `.Renviron`, come talk to the instructor for helping addressing it.

The general function `usethis::git_sitrep()` will report on your PAT, along with other aspects of your Git/GitHub setup.
```
git_sitrep()
```

### 1.5 A note about ongoing PAT maintenance
You are going to be (re-)generating and (re-)storing your PAT on a schedule dictated by its expiration period. By default, once per month.

When the PAT expires, return to https://github.com/settings/tokens and click on its Note. (You do label your tokens nicely by use case, right? Right?) At this point, you can optionally adjust scopes and then click “Regenerate token”. You can optionally modify its Expiration and then click “Regenerate token” (again). As before, copy the PAT to the clipboard, call `gitcreds::gitcreds_set()`, and paste!

Hopefully it’s becoming clear why each token’s Note is so important. The actual token may be changing, e.g., once a month, but its use case (and scopes) are much more persistent and stable.

Phew! Glad we have now proved to GitHub who we are when we use RStudio.

### 1.6 Ensure that Git/GitHub/RStudio are communicating
We are going to go through a couple steps to make sure the Git/GitHub are communicating with RStudio.

First, create a new project by clicking on the drop-down menu in the upper right and selecting "New Project". Alternatively, you could also go to File > New Project…, or click the little white + in a green circle with the R box in the top left.
<p align="center">
<img src="https://github.com/ds4eeb/GitAndGitHub/blob/main/data/images/newproject1.png" width="600" />
</p>

Next, select Version Control:
<p align="center">
<img src="https://github.com/ds4eeb/GitAndGitHub/blob/main/data/images/newproject2.png" width="400" />
</p>

Then select Git (since we are using Git):
<p align="center">
<img src="https://github.com/ds4eeb/GitAndGitHub/blob/main/data/images/newproject3.png" width="400" />
</p>

Do you see this?
<p align="center">
<img src="https://github.com/ds4eeb/GitAndGitHub/blob/main/data/images/newproject4.png" width="400" />
</p>

If yes, hooray! If no:
1. Double check that your GitHub username and email are correct
2. Troubleshooting, starting with [HappyGitWithR’s troubleshooting chapter](https://happygitwithr.com/troubleshooting.html)
