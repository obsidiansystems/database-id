{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_database_id_obelisk (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ali/.cabal/bin"
libdir     = "/home/ali/.cabal/lib/x86_64-linux-ghc-8.4.3/database-id-obelisk-0.1.0.0-5QOxCc4CiM8HvPNgXeVedw"
dynlibdir  = "/home/ali/.cabal/lib/x86_64-linux-ghc-8.4.3"
datadir    = "/home/ali/.cabal/share/x86_64-linux-ghc-8.4.3/database-id-obelisk-0.1.0.0"
libexecdir = "/home/ali/.cabal/libexec/x86_64-linux-ghc-8.4.3/database-id-obelisk-0.1.0.0"
sysconfdir = "/home/ali/.cabal/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "database_id_obelisk_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "database_id_obelisk_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "database_id_obelisk_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "database_id_obelisk_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "database_id_obelisk_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "database_id_obelisk_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
