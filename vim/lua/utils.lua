Utils = {}

Utils.getLinuxDirPath = function(str)
  return str:match("(.*/)")
end

return Utils
