_G.os_name = function()
  return os.getenv 'OS' or io.popen('uname -s'):read '*l'
end
