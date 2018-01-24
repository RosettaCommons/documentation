Rosetta Documentation
=====================

##Documentation for Rosetta Applications.

**For live editing of this documentation, go to the (current) official site of <https://www.rosettacommons.org/docs/wiki/>**

(Log on with your GitHub account.)

While one technically can checkout and modify this repository, doing so is subject to merge conflicts with edits to the live site.

Reserve direct git access to the repository for uses which cannot be done through the live wiki interface. (e.g. uploading images and batch processing type edits.)

### Serving a local version

You can host a local version of the documentation server.

Install the gollum wiki server by following the instructions [here](https://github.com/gollum/gollum/wiki/Installation).
You will also need to install the github-markdown extensions (typically `gem install github-markdown`).

From the documentation directory, launch the gollum server with the following command

    gollum --h1-title --config rosetta_gollum_config.rb --port 7364

Then point your web browser at the following URL: <http://localhost:7364>  

RosettaCommons members can get more information [here](https://wiki.rosettacommons.org/index.php/Local_Gollum).

##Markup
Gollum allows two types of link markup: `[[text like this|link target]]` (reverse MediaWiki) and `[text like this](link target)`.  The first is preferred: the second looks like a complete link whether it is valid or not, but the first will redlink if the target does not exist.

The wiki has a git backend for diffs.
It is better to try to separate sentences with endlines, so that git diffs will work most efficiently. 
Sentences ending with ". " are concatenated as part of one paragraph in the HTML.
