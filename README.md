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

    gollum --h1-title --config config.rb --port 7364

Then point your web browser at the following URL: <http://localhost:7364>  

RosettaCommons members can get more informatio [here](https://wiki.rosettacommons.org/index.php/Local_Gollum).

