local _, PKG = ...

-- global API for this addon
DEMODAL_ADDON = {}
DEMODAL_ADDON.VERSION_STRING = "DeModal 0.9.11"
DEMODAL_ADDON.VERSION = "0.9.11"

-- load all the things
PKG.LoadSlashCommands()
PKG.SettingsMixin.Init()
PKG.DeModalMixin.Init()
