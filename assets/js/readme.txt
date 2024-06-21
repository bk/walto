The file static/js/site.js was derived from assets/js/site.js in the following
way, assuming you have both npm and esbuild installed and in your path (both
commands run in the theme base directory):

  npm install
  esbuild --bundle assets/js/site.js --outdir=static/js/

There is no need to run these commands again unless the source site.js file
is changed.
