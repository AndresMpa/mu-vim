-- SETTINGS

-- Nvim Basics
require('settings')
-- Key map
require('mapping')
-- Auto commands
require('autocommand')

-- FIRST RUN
require('first_run').run()

-- PLUGIN
-- Plugin list
require('plugins')
-- Set up
require("composition")
