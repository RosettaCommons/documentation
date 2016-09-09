(This is an archived email originally written by Andy Watkins.)

So, I've made a bunch of modernizations that touch a bunch of files. I'm going to describe the same process I outlined on the PR discussion with specific git commands -- shamelessly plagiarized from an earlier guide for beautification. I will also describe them with words so that this TYPE of strategy seems intuitive, too. The idea is that master's history since you branched from it now has two different types of parts, and for efficiency you want to consider them separately. 

Most of master's history involves commits that are unlikely to touch your files, but likely to involve some amount of semantic change. The big automated transformations -- beautification, modernization -- are very likely to touch basically everyone's files, but conveniently you can reproduce the exact same transformation yourself, on your files, or (in theory) choose to ignore it. So you treat the first part of master's history seriously, you resolve any conflicts with modernization by trusting your reproduction, and then you treat the rest of master's history seriously.

1) Merge the revision of master that immediately preceded the modernization into your branch
> git merge c2abaa4

2) Resolve any conflicts between your branch and master at this point. Conflicts here are real! Don't dismiss them.

[OPTIONAL: 3) Modernize your branch, if you really want - manual or automated, doesn't matter! The [documentation](http://clang.llvm.org/extra/clang-tidy/index.html#using-clang-tidy)for `clang-tidy` is pretty self-explanatory, but I can provide some suggestions. In particular, use all the modernize checks, and nothing else - some of the performance checks don't work very well on our codebase and lead to headaches.]

4) Merge the single revision of master where it WAS modernized into your branch using the -Xours flag.
> git merge -Xours 01a57f1

5) Merge the rest of master into your branch. All conflicts generated after this point are real and must be carefully handled.
`> git merge master`

<!-- SEO:
cxx11
c++11
merge
-->