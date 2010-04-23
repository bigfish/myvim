
  " Vim script file                                       vim600:fdm=marker:
  " FileType:   MXML
  " Maintainer: David Wilehlm
  " Location:   http://www.vim.org/scripts/script.php?script_id=301

  " This is a wrapper script to add extra html support to xml documents.
  " Original script can be seen in xml-plugin documentation.

  " Only do this when not done yet for this buffer
  if exists("b:did_ftplugin")
    finish
  endif

  " Don't set 'b:did_ftplugin = 1' because that is xml.vim's responsability.
  let b:mxml_mode = 1

  runtime ftplugin/actionscript.vim
  runtime ftplugin/actionscript_snippets.vim


  " On to loading xml.vim
  runtime ftplugin/xml.vim
