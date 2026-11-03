Rosetta Documentation
=====================

##Documentation for Rosetta Applications.

This repository is hosted as a live website at <https://docs.rosettacommons.org/docs/latest/>.

**For live editing of this documentation, go to the (current) official site of <https://docs.rosettacommons.org/docs/wiki/>**

(Login with a Rosetta Commons GitHub account required.)

While one technically can checkout and modify this repository, doing so is subject to merge conflicts with edits to the live site.

Reserve direct git access to the repository for uses which cannot be done through the live wiki interface. (e.g. uploading images and batch processing type edits.)

##Markup
Gollum allows two types of link markup: `[[text like this|link target]]` (reverse MediaWiki) and `[text like this](link target)`.  The first is preferred: the second looks like a complete link whether it is valid or not, but the first will redlink if the target does not exist. The former also works based on plain page names, rather than full URLs.

The Rosetta Gollum version has a special syntax for page inclusion. `[[include:page_name]]` will insert the content of `page_name.md` into the page at that location -- this is primarily useful for the auto-generated XML documentation.

The wiki has a git backend for diffs.
It is better to try to separate sentences with endlines, so that git diffs will work most efficiently. 
Sentences ending with ". " are concatenated as part of one paragraph in the HTML.

# Hosting the documentation wiki locally

The Rosetta documentation is set up to be hosted on a [Gollum wiki](https://github.com/gollum/gollum), a simple Markdown powered wiki. 

Due to the unique needs of the Rosetta Commons documentation, we actually use a custom version. **Default installs of Gollum will not work properly.** i
See <https://github.com/RosettaCommons/gollum-lib>. This version should automatically be installed when setting things up as below.

### Ruby Installation

Gollum wiki requires Ruby to run. It is best to install the needed libraries into their own environment. Your prefered method of managing Ruby environments should be fine, but for those without Ruby experience, we recommend `rbenv`. Install from your operating system's package management environment, or see <https://github.com/rbenv/rbenv> for installation instructions.

Once you have the Ruby version mangager installed, create a Ruby environment for the Rosetta documentation (current recommended version is 3.1.7, as version 3.2 has issues with the version of the `thin` package needed -- this may be resolved once `thin` v2.0.0 comes out).

        rbenv install 3.1.7

### Gollum Installation

Rosetta uses a custom version of Gollum-lib. The proper versions are annotated in the Gemfile. To install them, and the needed dependencies, use the `bundle` command.

	bundle install

### Running the Gollum Server

You can launch gollum directly by using the `bundle` command:

        bundle exec gollum --port 4567 --config rosetta_gollum_config.rb

Then the Gollum wiki will be visible at <http://localhost:4567/>

Additional command line parameters can be found [here](https://github.com/gollum/gollum?tab=readme-ov-file#configuration)

Ones of note:

* `--ref` -- Which branch to serve from (default `main`). Note that Gollum will only server committed pages.
* `--no-edit` -- Serve the non-editable (public) version.

#### Note

The actual https://docs.rosettacommons.org/docs sites are served with the `thin` webserver client, using the rcpubdocs-config.yml (public, non-editable site) or rcdocs-config.yml (internal, editable but Github-protected site) configuration files (along with `config-public.ru` and `config.ru`). These are launched with (basically) the following command:

     bundle exec thin -C rcpubdocs-config.yml -l /opt/logs/rcdocs.log start

This serves the website at http://localhost:3001/docs/latest/ for rcpubdocs-config.yml and port http://localhost:3001/docs/wiki for rcdocs-config.yml.
The server will be launched in the background -- run the same command with `stop` to stop the server.

