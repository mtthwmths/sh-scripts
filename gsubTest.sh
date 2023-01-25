#!/bin/bash
# this is a quick script attempting to redact usernames from a log file using gawk.
# username pattern letter/digit.letter.letter/digit format
# check using param expansion if params were passed
#   references: 
#     https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html, https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Bourne-Shell-Builtins
: ${1? Usage - $0 infile outfile}
: ${2? Usage - $0 infile outfile}

#define file locations and create them in current folder if they don't exist
input_file=$1
output_file=$2
touch $input_file
touch $output_file

#string of patterns that are not names
exclude_strings="\\b(db|dbcp|http|jmx|editor|startheartbeatactivity|scriptrunner|createpagetemplate|jira|thread|resumedraft|atlassian|catalina|awt|java|sidebar|common|ForkJoinPool|session|pubsub|entity|Function|jdk|currentNode|CodeSmells|synchrony|version|HazelcastInstance|confluence|custom|doeditattachment|config|viewpageattachments|manifold|clojure|aleph|ginga|org|com|rome|application|bnd|editattachment|ProviderManager|letterhead|line|movepage|user|path|os|file|jnidispatch|stash|bitbucket|jna|uploadpack|atl|batch|form|table|package)\\b"

#actual command
gawk -v exclude="$exclude_strings" \
'{if (! match($0, exclude))
gsub(/([a-zA-Z])+\.([a-zA-Z0-9])+((\.)*([a-zA-Z0-9])*){0,1}/, "USER_REDACTED"); print}' \
$input_file > $output_file
