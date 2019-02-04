function chain.links.pwd
  set -q chain_project_glyph
    or set -l chain_project_glyph '@'

  set -l prefix ''
  set -l path "$PWD"

  # Replace either HOME with ~ or abbreviate project root.
  if vcs.present
    set path (string replace (vcs.root) '' "$path")
    set prefix @(basename (vcs.root))
  else
    set path (string replace ~ '~' "$path")
  end

  # Shorten path segments, using an ellipses if the number of folders
  # in the path is bigger than 2
  if test (echo $path | grep -o '/' | wc -l) -gt 2
    set -l base (echo "$path" | cut -d'/' -f1-2)
    set path (string join '/' $base '...' (string split -m 1 -r '/' "$path")[2])
  end
 
  echo cyan
  echo "$prefix$path"
end
